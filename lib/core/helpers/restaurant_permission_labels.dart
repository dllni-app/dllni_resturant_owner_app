/// User-facing Arabic labels for stable restaurant permission codes.
///
/// The API's permission identifiers are intentionally not translated so that
/// authorization continues to use the exact backend codes.
abstract final class RestaurantPermissionLabels {
  static const Map<String, String> _titles = {
    'ro.menu': 'إدارة الوجبات والمنتجات',
    'ro.offers_coupons': 'إدارة العروض والكوبونات',
    'ro.orders': 'إدارة الطلبات',
    'ro.staff_register': 'إدارة الموظفين',
    'ro.store_hours': 'بيانات المطعم وساعات العمل',
    'ro.warehouse': 'إدارة المخزون',
  };

  static String title({String? name, String? slug}) {
    for (final candidate in [name, slug]) {
      final value = candidate?.trim();
      if (value != null && _titles.containsKey(value)) {
        return _titles[value]!;
      }
    }

    // Some API versions supply an already localized human-readable name.
    for (final candidate in [name, slug]) {
      final value = candidate?.trim() ?? '';
      if (value.isNotEmpty && !RegExp(r'^[a-z]{2}\\.').hasMatch(value)) {
        return value;
      }
    }
    return 'صلاحية أخرى';
  }
}
