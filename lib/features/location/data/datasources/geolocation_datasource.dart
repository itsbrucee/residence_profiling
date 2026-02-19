import 'dart:async';
import 'package:geolocator/geolocator.dart';
import '../../core/location_failure.dart';
import '../../domain/entities/location_entity.dart';

class GeolocationDatasource {
  static const _timeout = Duration(seconds: 15);

  /// Fetches raw GPS position from the device hardware.
  /// Assumes permissions have already been granted.
  Future<LocationEntity> getPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: _timeout,
      );
      return LocationEntity(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      );
    } on TimeoutException {
      throw const LocationTimeout();
    } catch (e) {
      throw LocationFetchFailed('GPS error: $e');
    }
  }
}
