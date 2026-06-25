import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/owner_order_details_model.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key, required this.order});

  final OwnerOrderDetailsData order;

  @override
  Widget build(BuildContext context) {
    final delivery = order.delivery;
    final address = delivery?.address ?? order.customerAddress;
    final isPickup = (delivery?.orderType ?? order.orderType) == 'pickup';
    final label = isPickup ? 'معلومات الاستلام' : 'معلومات التوصيل';
    final orderTypeLabel = delivery?.orderTypeLabelAr ?? (isPickup ? 'استلام' : 'توصيل');
    final mode = delivery?.pickupMode ?? order.pickupMode ?? '-';
    final scheduledFor = delivery?.scheduledFor ?? order.pickupScheduledFor ?? '-';
    final addressText = address?.displayText.trim() ?? '';

    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineMedium(label, fontWeight: FontWeight.bold),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _metricBox('المسافة', delivery?.distanceKm == null ? '-' : '${delivery!.distanceKm!.toStringAsFixed(1)} كم', context)),
              const SizedBox(width: 12),
              Expanded(child: _metricBox('وقت التوصيل', delivery?.estimatedDeliveryMinutes == null ? '-' : '${delivery!.estimatedDeliveryMinutes} دقيقة', context)),
            ],
          ),
          const SizedBox(height: 12),
          _box('نوع الطلب', orderTypeLabel, context),
          const SizedBox(height: 8),
          _box('نمط الطلب', mode, context),
          const SizedBox(height: 8),
          _box('الوقت المجدول', scheduledFor, context),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 20, color: Color(0xff6B7280)),
              const SizedBox(width: 8),
              Expanded(child: AppText.bodyMedium(addressText.isEmpty ? 'العنوان غير متوفر من بيانات الطلب الحالية' : addressText, color: const Color(0xff6B7280), textAlign: TextAlign.start)),
            ],
          ),
          const SizedBox(height: 12),
          _map(address),
        ],
      ),
    );
  }

  Widget _metricBox(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          AppText.labelSmall(label, color: const Color(0xff6B7280), fontWeight: FontWeight.w500),
          const SizedBox(height: 4),
          AppText.bodyLarge(value, color: const Color(0xff2F2B3D), fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget _box(String label, String value, BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.labelSmall(label, color: const Color(0xff6B7280), fontWeight: FontWeight.w500),
          Flexible(child: AppText.bodyMedium(value, color: const Color(0xff2F2B3D), fontWeight: FontWeight.w700, textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget _map(OwnerOrderAddress? address) {
    final latitude = address?.latitude;
    final longitude = address?.longitude;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 150,
        width: double.infinity,
        color: const Color(0xffF3F4F6),
        child: latitude == null || longitude == null
            ? const Center(child: Icon(Icons.map, color: Color(0xff9CA3AF), size: 42))
            : FlutterMap(
                options: MapOptions(initialCenter: LatLng(latitude, longitude), initialZoom: 15),
                children: [
                  TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.dllni.restaurant_owner_app'),
                  MarkerLayer(markers: [
                    Marker(point: LatLng(latitude, longitude), width: 40, height: 40, child: const Icon(Icons.location_pin, color: Color(0xffFF7A00), size: 40)),
                  ]),
                ],
              ),
      ),
    );
  }
}
