import 'package:geolocator/geolocator.dart';
import 'location_failure.dart';

class LocationPermissionHandler {
  /// Ensures location services are enabled and permissions are granted.
  /// Throws a specific [LocationFailure] subtype on any problem.
  Future<void> ensurePermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationServiceDisabled();
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationPermissionDenied();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationPermissionPermanentlyDenied();
    }
  }

  /// Opens the device's app settings page so the user can grant permissions.
  Future<bool> openSettings() => Geolocator.openAppSettings();

  /// Opens the device's location settings page so the user can enable GPS.
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();
}
