import 'package:dllni_resturant_owner_app/features/home/data/models/fetch_notifications_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchNotificationsModel parses item metadata and read flags', () {
    final model = FetchNotificationsModel.fromJson({
      'data': [
        {
          'id': 'abc',
          'source': 'restaurant',
          'category': 'orders',
          'title': 'طلب جديد',
          'body': 'وصل طلب جديد',
          'type': 'order',
          'isRead': 0,
          'createdAt': '2026-06-20 10:00:00',
          'meta': {'orderId': 7, 'route': '/orders/details'},
        },
      ],
      'meta': {'page': 1, 'perPage': 10, 'total': 1, 'lastPage': 1, 'unreadTotal': 1},
    });

    final item = model.data!.first;
    expect(item.id, 'abc');
    expect(item.isRead, false);
    expect(item.meta!['orderId'], 7);
    expect(model.meta!.unreadTotal, 1);
  });
}
