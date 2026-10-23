import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/helpers/seller_permission_access.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/add_employee_use_case.dart';

Future<void> session(Map<String, dynamic> value) async {
  SharedPreferences.setMockInitialValues({});
  await SharedPreferencesHelper.init();
  await SharedPreferencesHelper.saveData(key: 'user', value: jsonEncode(value));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('staff with absent or malformed permission payload always fails closed', () async {
    await session({'role': {'slug': 'employee'}});
    expect(SellerPermissionAccess.current().hasFullAccess, isFalse);
    expect(SellerPermissionAccess.current().can('ro.orders'), isFalse);
    await session({'role': {'slug': 'employee'}, 'permissions': 'invalid'});
    expect(SellerPermissionAccess.current().can('ro.staff_register'), isFalse);
  });

  test('owner role retains full access', () async {
    await session({'role': {'slug': 'owner'}});
    expect(SellerPermissionAccess.current().hasFullAccess, isTrue);
  });

  test('employee phone is canonicalized before reaching the backend', () {
    expect(AddEmployeeParams.normalizedPhone('0944000923'), '+963944000923');
    expect(AddEmployeeParams.normalizedPhone('944000923'), '+963944000923');
    expect(AddEmployeeParams.normalizedPhone('+963944000923'), '+963944000923');
    expect(AddEmployeeParams.normalizedPhone('+491701234567'), '+491701234567');
  });
}
