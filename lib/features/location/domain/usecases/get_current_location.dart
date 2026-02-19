import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository _repository;

  GetCurrentLocation(this._repository);

  Future<LocationEntity> call() => _repository.getCurrentLocation();
}
