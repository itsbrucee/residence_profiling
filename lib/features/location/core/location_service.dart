import '../data/datasources/geolocation_datasource.dart';
import '../data/repositories/location_repository_impl.dart';
import '../domain/entities/location_entity.dart';
import '../domain/usecases/get_current_location.dart';
import 'location_permission_handler.dart';

/// Public facade for the location feature module.
///
/// Usage from anywhere in the app:
/// ```dart
/// final location = await LocationService.instance.fetchCurrentLocation();
/// print(location.latitude);
/// ```
class LocationService {
  LocationService._();
  static final LocationService instance = LocationService._();

  late final LocationPermissionHandler _permissionHandler =
      LocationPermissionHandler();

  late final GeolocationDatasource _datasource = GeolocationDatasource();

  late final LocationRepositoryImpl _repository = LocationRepositoryImpl(
    datasource: _datasource,
    permissionHandler: _permissionHandler,
  );

  late final GetCurrentLocation _getCurrentLocation =
      GetCurrentLocation(_repository);

  /// Retrieves the current device GPS location.
  /// Handles permissions automatically. Throws [LocationFailure] on error.
  Future<LocationEntity> fetchCurrentLocation() => _getCurrentLocation();

  /// Opens device app settings (for permanently denied permissions).
  Future<bool> openAppSettings() => _permissionHandler.openSettings();

  /// Opens device location settings (when GPS is disabled).
  Future<bool> openLocationSettings() =>
      _permissionHandler.openLocationSettings();
}
