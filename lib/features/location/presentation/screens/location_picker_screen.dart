import 'package:flutter/material.dart';
import '../../core/location_failure.dart';
import '../notifiers/location_notifier.dart';
import '../widgets/location_map_widget.dart';

/// A full-screen location picker that:
/// 1. Requests GPS permissions
/// 2. Fetches current coordinates
/// 3. Displays them on a FlutterMap
/// 4. Returns (latitude, longitude) when the user confirms
///
/// Usage:
/// ```dart
/// final result = await Navigator.push<({double lat, double lng})>(
///   context,
///   MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
/// );
/// if (result != null) {
///   // use result.lat and result.lng
/// }
/// ```
class LocationPickerScreen extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const LocationPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late final LocationNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = LocationNotifier();

    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      // Don't auto-fetch if we already have coordinates
    } else {
      _notifier.fetchLocation();
    }

    _notifier.addListener(_onStateChange);
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStateChange);
    _notifier.dispose();
    super.dispose();
  }

  void _confirmLocation() {
    final loc = _notifier.location;
    if (loc != null) {
      Navigator.pop(context, (lat: loc.latitude, lng: loc.longitude));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(theme, colorScheme),
      ),
    );
  }

  Widget _buildBody(ThemeData theme, ColorScheme colorScheme) {
    // Show initial coordinates if provided and no fetch has happened
    final hasInitial =
        widget.initialLatitude != null && widget.initialLongitude != null;

    switch (_notifier.status) {
      case LocationStatus.idle:
        if (hasInitial) {
          return _buildLocationDisplay(
            theme,
            colorScheme,
            widget.initialLatitude!,
            widget.initialLongitude!,
            showConfirm: false,
          );
        }
        return _buildIdleState(colorScheme);

      case LocationStatus.loading:
        return _buildLoadingState(colorScheme);

      case LocationStatus.success:
        final loc = _notifier.location!;
        return _buildLocationDisplay(
          theme,
          colorScheme,
          loc.latitude,
          loc.longitude,
          accuracy: loc.accuracy,
          showConfirm: true,
        );

      case LocationStatus.error:
        return _buildErrorState(theme, colorScheme);
    }
  }

  Widget _buildIdleState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_searching, size: 64, color: colorScheme.primary),
          const SizedBox(height: 16),
          const Text('Tap below to get your current location'),
          const SizedBox(height: 24),
          _fetchButton(),
        ],
      ),
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Acquiring GPS signal...',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Make sure you are in an open area',
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDisplay(
    ThemeData theme,
    ColorScheme colorScheme,
    double lat,
    double lng, {
    double? accuracy,
    required bool showConfirm,
  }) {
    return Column(
      children: [
        Expanded(
          child: LocationMapWidget(latitude: lat, longitude: lng),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.my_location, color: colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lat: ${lat.toStringAsFixed(6)}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Lng: ${lng.toStringAsFixed(6)}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (accuracy != null)
                      Chip(
                        label: Text('±${accuracy.toStringAsFixed(0)}m'),
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _fetchButton(label: 'Refresh')),
            if (showConfirm) ...[
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _confirmLocation,
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm'),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildErrorState(ThemeData theme, ColorScheme colorScheme) {
    final failure = _notifier.failure;
    IconData icon = Icons.error_outline;
    String title = 'Location Error';
    String message = failure?.message ?? 'An unknown error occurred.';
    List<Widget> actions = [_fetchButton(label: 'Retry')];

    if (failure is LocationServiceDisabled) {
      icon = Icons.location_disabled;
      title = 'GPS Disabled';
      actions = [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _notifier.openLocationSettings(),
            icon: const Icon(Icons.settings),
            label: const Text('Open Settings'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _fetchButton(label: 'Retry')),
      ];
    } else if (failure is LocationPermissionDenied) {
      icon = Icons.lock_outline;
      title = 'Permission Denied';
      actions = [_fetchButton(label: 'Request Again')];
    } else if (failure is LocationPermissionPermanentlyDenied) {
      icon = Icons.block;
      title = 'Permission Blocked';
      actions = [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _notifier.openAppSettings(),
            icon: const Icon(Icons.settings),
            label: const Text('App Settings'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _fetchButton(label: 'Retry')),
      ];
    } else if (failure is LocationTimeout) {
      icon = Icons.timer_off;
      title = 'GPS Timeout';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(title,
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: colorScheme.error)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fetchButton({String label = 'Get Location'}) {
    return ElevatedButton.icon(
      onPressed:
          _notifier.status == LocationStatus.loading
              ? null
              : () => _notifier.fetchLocation(),
      icon: const Icon(Icons.location_on),
      label: Text(label),
    );
  }
}
