import '../entities/location_entity.dart';
import '../../core/location_failure.dart';

abstract class LocationRepository {
  /// Retrieves the current device location via GPS.
  /// Returns [LocationEntity] on success, throws [LocationFailure] on error.
  Future<LocationEntity> getCurrentLocation();
}
