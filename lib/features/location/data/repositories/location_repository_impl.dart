import '../../core/location_permission_handler.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/geolocation_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GeolocationDatasource _datasource;
  final LocationPermissionHandler _permissionHandler;

  LocationRepositoryImpl({
    required GeolocationDatasource datasource,
    required LocationPermissionHandler permissionHandler,
  })  : _datasource = datasource,
        _permissionHandler = permissionHandler;

  @override
  Future<LocationEntity> getCurrentLocation() async {
    await _permissionHandler.ensurePermissions();
    return _datasource.getPosition();
  }
}
