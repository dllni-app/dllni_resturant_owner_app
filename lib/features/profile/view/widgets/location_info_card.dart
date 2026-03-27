import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class LocationInfoCard extends StatelessWidget {
  const LocationInfoCard({
    super.key,
    required this.city,
    required this.county,
    required this.address,
    required this.lat,
    required this.long,
    required this.selectedLong,
    required this.selectedLat,
    this.onPickLocation,
  });

  final TextEditingController city;
  final TextEditingController county;
  final TextEditingController address;
  final double lat;
  final double long;
  final Function(double long) selectedLong;
  final Function(double lat) selectedLat;
  final VoidCallback? onPickLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: context.onPrimaryContainer,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 4), blurRadius: 20, spreadRadius: -2)],
      ),
      padding: EdgeInsetsDirectional.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: context.primaryContainer,
                radius: 16,
                child: AppText.labelLarge('2', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 12),
              AppText.titleLarge('العنوان والموقع', color: context.primaryContainer, fontWeight: FontWeight.bold),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText.bodyMedium('المدينة', fontWeight: FontWeight.w500),
                        AppText.bodyMedium('*', fontWeight: FontWeight.w500, color: context.error),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: city,
                      style: TextStyle(color: Color(0xff2F2B3D), fontSize: 14, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText.bodyMedium('الحي', fontWeight: FontWeight.w500),
                        AppText.bodyMedium('*', fontWeight: FontWeight.w500, color: context.error),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: county,
                      style: TextStyle(color: Color(0xff2F2B3D), fontSize: 14, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              AppText.bodyMedium('تفاصيل الموقع', fontWeight: FontWeight.w500),
              AppText.bodyMedium('*', fontWeight: FontWeight.w500, color: context.error),
            ],
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: address,
            style: TextStyle(color: Color(0xff2F2B3D), fontSize: 14, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
            ),
          ),
          SizedBox(height: 20),
          AppText.bodyMedium('الموقع على الخريطة', fontWeight: FontWeight.w500),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.lightBlueAccent.withAlpha(150)),
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.location_on_sharp, color: context.error, size: 60),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onPickLocation,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Color(0xff064E3B)),
                          padding: EdgeInsetsDirectional.symmetric(vertical: 12),
                          margin: EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.my_location, color: context.onPrimary, size: 14),
                              SizedBox(width: 8),
                              AppText.bodyMedium('تحديد الموقع', color: context.onPrimary, fontWeight: FontWeight.bold),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
