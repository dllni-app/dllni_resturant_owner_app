import 'package:flutter_test/flutter_test.dart';
import 'package:dllni_resturant_owner_app/core/helpers/restaurant_permission_labels.dart';

void main() {
  test('all restaurant permission codes have understandable Arabic labels', () {
    const labels = <String, String>{
      'ro.menu': 'إدارة الوجبات والمنتجات',
      'ro.offers_coupons': 'إدارة العروض والكوبونات',
      'ro.orders': 'إدارة الطلبات',
      'ro.staff_register': 'إدارة الموظفين',
      'ro.store_hours': 'بيانات المطعم وساعات العمل',
      'ro.warehouse': 'إدارة المخزون',
    };

    for (final entry in labels.entries) {
      expect(RestaurantPermissionLabels.title(name: entry.key), entry.value);
      expect(RestaurantPermissionLabels.title(slug: entry.key), entry.value);
    }
  });

  test('Arabic API names are retained, but raw unknown codes are hidden', () {
    expect(
      RestaurantPermissionLabels.title(name: 'وصول مخصص', slug: 'custom.permission'),
      'وصول مخصص',
    );
    expect(
      RestaurantPermissionLabels.title(name: 'ro.unknown', slug: 'ro.unknown'),
      'صلاحية أخرى',
    );
  });
}
