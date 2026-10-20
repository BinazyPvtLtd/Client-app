import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

import 'package:geocoding/geocoding.dart' as geo;

class PickupLocationResult {
  final String address;
  final double latitude;
  final double longitude;

  const PickupLocationResult({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class PickupLocationPickerScreen extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final bool isDropLocation;

  const PickupLocationPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    this.isDropLocation = false,
  });

  @override
  State<PickupLocationPickerScreen> createState() =>
      _PickupLocationPickerScreenState();
}

class _PickupLocationPickerScreenState
    extends State<PickupLocationPickerScreen> {
  final TextEditingController _searchController = TextEditingController();

  GoogleMapController? _mapController;

  // Map ka initial position sirf fallback hai.
  // Isse user ki current location assume nahi karna.
  static const LatLng _fallbackCenter = LatLng(26.8467, 80.9462);

  late LatLng _selectedPosition;
  String _selectedAddress = '';
  String? _errorMessage;

  bool _loading = false;
  bool _mapMode = true;
  bool _hasResolvedLocation = false;

  @override
  void initState() {
    super.initState();

    // Default map location: Lucknow, Uttar Pradesh
    _selectedPosition = _fallbackCenter;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _resolvePosition(LatLng position) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _hasResolvedLocation = false;
    });

    try {
      final places = await geo.Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (!mounted) return;

      final address = places.isEmpty
          ? '${position.latitude}, ${position.longitude}'
          : _formatAddress(places.first);

      setState(() {
        _selectedPosition = position;
        _selectedAddress = address;
        _hasResolvedLocation = true;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _selectedPosition = position;
        _selectedAddress =
            '${position.latitude.toStringAsFixed(6)}, '
            '${position.longitude.toStringAsFixed(6)}';
        _hasResolvedLocation = true;
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _formatAddress(geo.Placemark place) {
    final parts = [
      place.street,
      place.subLocality,
      place.locality,
      place.administrativeArea,
      place.postalCode,
    ];

    return parts
        .whereType<String>()
        .where((value) => value.trim().isNotEmpty)
        .toSet()
        .join(', ');
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final enabled = await Geolocator.isLocationServiceEnabled();

      if (!enabled) {
        throw Exception('Please enable location services on your phone.');
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permission is blocked. Enable it in app settings.',
        );
      }

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission was denied.');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      final point = LatLng(position.latitude, position.longitude);

      if (!mounted) return;

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(point, 17),
      );

      await _resolvePosition(point);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _errorMessage = error.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _searchAddress() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final results = await geo.Geocoding().locationFromAddress(query);

      if (results.isEmpty) {
        throw Exception('Address not found. Try more details.');
      }

      final point = LatLng(results.first.latitude, results.first.longitude);

      if (!mounted) return;

      await _resolvePosition(point);

      if (!mounted) return;

      setState(() => _mapMode = true);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(point, 16),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Could not find this address. Try adding area and city.';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _confirmLocation() {
    if (_loading || !_hasResolvedLocation) return;

    Navigator.of(context).pop(
      PickupLocationResult(
        address: _selectedAddress,
        latitude: _selectedPosition.latitude,
        longitude: _selectedPosition.longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        title: Text(
          widget.isDropLocation
              ? 'Select drop location'
              : 'Change pickup location',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _searchAddress(),
                    decoration: InputDecoration(
                      hintText: 'Search area, street, address',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                        onPressed: _loading ? null : _searchAddress,
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMD,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.my_location_rounded,
                      color: AppColors.primary,
                    ),
                    title: const Text('Use my current location'),
                    subtitle: Text(
                      widget.isDropLocation
                          ? 'Detect drop using GPS'
                          : 'Detect pickup using GPS',
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _loading ? null : _useCurrentLocation,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.map_outlined,
                      color: AppColors.primary,
                    ),
                    title: const Text('Choose on map'),
                    subtitle: Text(
                      widget.isDropLocation
                          ? 'Move the map to set drop point'
                          : 'Move the map to set pickup point',
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      setState(() => _mapMode = true);
                    },
                  ),
                ],
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: AppSpacing.screenPadding,
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
                ),
              ),
            if (_loading)
              const LinearProgressIndicator(color: AppColors.primary),
            Expanded(
              child: _mapMode
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _selectedPosition,
                            zoom: 15,
                          ),
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          onCameraMove: (position) {
                            _selectedPosition = position.target;
                            _hasResolvedLocation = false;
                          },
                          onCameraIdle: () {
                            _resolvePosition(_selectedPosition);
                          },
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                        ),
                        const IgnorePointer(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 34),
                            child: Icon(
                              Icons.location_on_rounded,
                              size: 48,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Padding(
                        padding: AppSpacing.screenPadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 52,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              _hasResolvedLocation
                                  ? _selectedAddress
                                  : 'Search an address or use your current location',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_hasResolvedLocation)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Text(
                        _selectedAddress,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.buttonHeight,
                    child: ElevatedButton(
                      onPressed: _hasResolvedLocation && !_loading
                          ? _confirmLocation
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusButton,
                          ),
                        ),
                      ),
                      child: Text(
                        widget.isDropLocation
                            ? 'Confirm drop location'
                            : 'Confirm pickup location',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
