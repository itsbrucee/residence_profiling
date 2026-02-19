import 'package:flutter/foundation.dart';
import '../../core/location_failure.dart';
import '../../core/location_service.dart';
import '../../domain/entities/location_entity.dart';

enum LocationStatus { idle, loading, success, error }

class LocationNotifier extends ChangeNotifier {
  final LocationService _service;

  LocationNotifier({LocationService? service})
      : _service = service ?? LocationService.instance;

  LocationStatus _status = LocationStatus.idle;
  LocationEntity? _location;
  LocationFailure? _failure;

  LocationStatus get status => _status;
  LocationEntity? get location => _location;
  LocationFailure? get failure => _failure;

  bool get hasLocation => _location != null;

  Future<void> fetchLocation() async {
    _status = LocationStatus.loading;
    _failure = null;
    notifyListeners();

    try {
      _location = await _service.fetchCurrentLocation();
      _status = LocationStatus.success;
    } on LocationFailure catch (e) {
      _failure = e;
      _status = LocationStatus.error;
    } catch (e) {
      _failure = LocationFetchFailed('Unexpected error: $e');
      _status = LocationStatus.error;
    }

    notifyListeners();
  }

  Future<void> openAppSettings() => _service.openAppSettings();

  Future<void> openLocationSettings() => _service.openLocationSettings();

  void reset() {
    _status = LocationStatus.idle;
    _location = null;
    _failure = null;
    notifyListeners();
  }
}
