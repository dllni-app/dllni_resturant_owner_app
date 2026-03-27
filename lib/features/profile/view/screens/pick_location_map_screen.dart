import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class PickLocationMapParams {
  const PickLocationMapParams({this.latitude, this.longitude});

  final double? latitude;
  final double? longitude;
}

class PickLocationResult {
  const PickLocationResult({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.district,
    required this.locationDetails,
  });

  final double latitude;
  final double longitude;
  final String city;
  final String district;
  final String locationDetails;
}

@AutoRoutePage(path: '/profile/map')
class PickLocationMapScreen extends StatefulWidget {
  const PickLocationMapScreen({super.key, required this.params});

  final PickLocationMapParams params;

  @override
  State<PickLocationMapScreen> createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  static const LatLng _defaultCenter = LatLng(24.7136, 46.6753);

  late final MapController _mapController;
  LatLng? _selected;
  String? _displayAddress;
  String _city = '';
  String _district = '';
  String _locationDetails = '';
  bool _isGeocoding = false;
  String? _geocodeError;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _selected = _resolveInitialLatLng();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selected != null) {
        _reverseGeocode(_selected!);
      }
    });
  }

  LatLng _resolveInitialLatLng() {
    final lat = widget.params.latitude;
    final lng = widget.params.longitude;
    if (lat == null || lng == null || (lat == 0 && lng == 0)) {
      return _defaultCenter;
    }
    return LatLng(lat, lng);
  }

  Future<void> _reverseGeocode(LatLng point) async {
    setState(() {
      _isGeocoding = true;
      _geocodeError = null;
    });
    try {
      final placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
      final p = placemarks.isNotEmpty ? placemarks.first : null;
      if (!mounted) return;
      if (p == null) {
        setState(() {
          _city = '';
          _district = '';
          _locationDetails = '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
          _displayAddress = _locationDetails;
        });
        return;
      }
      final city = _firstNonEmpty([p.locality, p.subAdministrativeArea, p.administrativeArea]);
      final district = _firstNonEmpty([p.subLocality, p.subAdministrativeArea, p.administrativeArea]);
      final details = _formatLocationDetails(p, point);
      setState(() {
        _city = city;
        _district = district;
        _locationDetails = details;
        _displayAddress = _formatDisplayAddress(p, point);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _geocodeError = e.toString();
        _city = '';
        _district = '';
        _locationDetails = '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
        _displayAddress = _locationDetails;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isGeocoding = false;
        });
      }
    }
  }

  String _firstNonEmpty(List<String?> parts) {
    for (final s in parts) {
      if (s != null && s.trim().isNotEmpty) return s.trim();
    }
    return '';
  }

  String _streetLine(Placemark p) {
    final a = p.street?.trim() ?? '';
    final b = p.subThoroughfare?.trim() ?? '';
    if (a.isNotEmpty && b.isNotEmpty) return '$a $b';
    if (a.isNotEmpty) return a;
    if (b.isNotEmpty) return b;
    return '';
  }

  String _formatLocationDetails(Placemark p, LatLng point) {
    final line = _firstNonEmpty([_streetLine(p), p.thoroughfare, p.name]);
    final country = p.country?.trim();
    if (line.isNotEmpty && country != null && country.isNotEmpty) {
      return '$line، $country';
    }
    if (line.isNotEmpty) return line;
    if (country != null && country.isNotEmpty) return country;
    return '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
  }

  String _formatDisplayAddress(Placemark p, LatLng point) {
    final parts = <String>[];
    final street = _firstNonEmpty([_streetLine(p), p.thoroughfare]);
    if (street.isNotEmpty) parts.add(street);
    final locality = _firstNonEmpty([p.subLocality, p.locality]);
    if (locality.isNotEmpty) parts.add(locality);
    final admin = _firstNonEmpty([p.administrativeArea]);
    if (admin.isNotEmpty) parts.add(admin);
    if (p.country != null && p.country!.trim().isNotEmpty) parts.add(p.country!.trim());
    if (parts.isEmpty) {
      return '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
    }
    return parts.join('، ');
  }

  void _onTapMap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selected = point;
    });
    _mapController.move(point, _mapController.camera.zoom);
    _reverseGeocode(point);
  }

  void _confirm() {
    final point = _selected;
    if (point == null) return;
    context.pop(
      PickLocationResult(latitude: point.latitude, longitude: point.longitude, city: _city, district: _district, locationDetails: _locationDetails),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initial = _selected ?? _resolveInitialLatLng();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: () => context.pop()),
        title: AppText.titleMedium('تحديد الموقع', fontWeight: FontWeight.w600),
        actions: [
          TextButton(
            onPressed: _selected == null || _isGeocoding ? null : _confirm,
            child: AppText.labelLarge('تأكيد', color: context.primary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(initialCenter: initial, initialZoom: 15, onTap: _onTapMap),
              children: [
                TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.dllni.restOwner'),
                if (_selected != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _selected!,
                        width: 40,
                        height: 40,
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.location_pin, color: context.primary, size: 40),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (_isGeocoding)
            const Center(
              child: Card(
                child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
              ),
            ),
          if (_displayAddress != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.black.withAlpha(176), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _displayAddress!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    if (_geocodeError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _geocodeError!,
                          style: TextStyle(color: Colors.red.shade200, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
