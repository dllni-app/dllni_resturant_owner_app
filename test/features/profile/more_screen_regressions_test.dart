import 'package:flutter_test/flutter_test.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_resturant_data_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/helpers/activity_description_localizer.dart';

void main() {
  test('restaurant store image and banner are read independently', () {
    final data = FetchResturantDataModelData.fromJson({
      'name': 'QA Restaurant',
      'primaryImage': 'https://example.org/logo.png',
      'banner': 'https://example.org/cover.png',
    });
    expect(data.primaryImage, 'https://example.org/logo.png');
    expect(data.banner, 'https://example.org/cover.png');
    expect(data.toJson()['banner'], 'https://example.org/cover.png');
  });

  test('audit order statuses localize without affecting order number', () {
    const message = 'غيّر حالة الطلب #ORD-123 من preparing إلى ready_for_pickup';
    expect(
      localizeActivityDescription(message),
      'غيّر حالة الطلب #ORD-123 من قيد التحضير إلى جاهز للاستلام',
    );
    expect(localizeActivityDescription('عرض QA accepted_today'), 'عرض QA accepted_today');
  });
}
