import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Displays a FlutterMap centered on the given coordinates with a pin marker.
/// Works with OpenStreetMap tiles (free, no API key).
/// When offline, the map tiles won't load but the coordinates remain valid.
class LocationMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double zoom;
  final double height;
  final bool interactive;

  const LocationMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.zoom = 16.0,
    this.height = 280,
    this.interactive = true,
  });

  @override
  Widget build(BuildContext context) {
    final center = LatLng(latitude, longitude);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: height,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: zoom,
            interactionOptions: InteractionOptions(
              flags: interactive ? InteractiveFlag.all : InteractiveFlag.none,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.barangay_esystem',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: center,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
