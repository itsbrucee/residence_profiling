sealed class LocationFailure implements Exception {
  final String message;
  const LocationFailure(this.message);

  @override
  String toString() => message;
}

class LocationServiceDisabled extends LocationFailure {
  const LocationServiceDisabled()
      : super('Location services are disabled. Please enable GPS in device settings.');
}

class LocationPermissionDenied extends LocationFailure {
  const LocationPermissionDenied()
      : super('Location permission was denied. Please grant location access.');
}

class LocationPermissionPermanentlyDenied extends LocationFailure {
  const LocationPermissionPermanentlyDenied()
      : super(
            'Location permission is permanently denied. Please enable it in app settings.');
}

class LocationFetchFailed extends LocationFailure {
  const LocationFetchFailed([super.message = 'Failed to retrieve location.']);
}

class LocationTimeout extends LocationFailure {
  const LocationTimeout()
      : super('Location request timed out. Please try again in an open area.');
}
