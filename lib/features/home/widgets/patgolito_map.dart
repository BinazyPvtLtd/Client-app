

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PatgolitoMap extends StatefulWidget {
  const PatgolitoMap({
    super.key,
    this.latitude = 26.8467,
    this.longitude = 80.9462,
    this.zoom = 15.5,
    this.onCameraIdlePosition,
    this.interactive = true,
    this.showMyLocation = false,
    this.visibleMapFraction = 0.22,
  });

  final double latitude;
  final double longitude;
  final double zoom;
  final bool interactive;
  final bool showMyLocation;
  final double visibleMapFraction;

  final ValueChanged<LatLng>? onCameraIdlePosition;

  @override
  State<PatgolitoMap> createState() => PatgolitoMapState();
}

class PatgolitoMapState extends State<PatgolitoMap> {
  GoogleMapController? _mapController;
  late LatLng _cameraTarget;

  Future<void> moveTo(LatLng target) async {
  final controller = _mapController;

  if (controller == null || !mounted) return;

  _cameraTarget = target;

  final double mapHeight = context.size?.height ?? 600;

  // Home Screen par 22% map visible hai.
  final double visibleHeight =
      mapHeight * widget.visibleMapFraction;

  final double offset = (mapHeight - visibleHeight) / 2;

  try {
    // Center map on actual GPS coordinates.
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: widget.zoom,
        ),
      ),
    );

    // Move GPS indicator into the visible map area.
    await controller.moveCamera(
      CameraUpdate.scrollBy(
        0,
        offset,
      ),
    );

    debugPrint('MAP CAMERA POSITION UPDATED');
    debugPrint('VISIBLE MAP HEIGHT: $visibleHeight');
    debugPrint('CAMERA OFFSET: $offset');
  } catch (e) {
    debugPrint('MAP CAMERA ERROR: $e');
  }
}

  @override
  void initState() {
    super.initState();

    _cameraTarget = LatLng(
      widget.latitude,
      widget.longitude,
    );
  }

  @override
void didUpdateWidget(covariant PatgolitoMap oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.latitude != widget.latitude ||
      oldWidget.longitude != widget.longitude) {
    _cameraTarget = LatLng(
      widget.latitude,
      widget.longitude,
    );
  }
}

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // padding: const EdgeInsets.only(
      //   bottom: 300,
      // ),
      padding: EdgeInsets.zero,

      initialCameraPosition: CameraPosition(
        target: _cameraTarget,
        zoom: widget.zoom,
      ),

      mapType: MapType.normal,

      // Show current GPS position
      myLocationEnabled: widget.showMyLocation,

      // We use our custom location button
      myLocationButtonEnabled: false,

      zoomGesturesEnabled: widget.interactive,
      scrollGesturesEnabled: widget.interactive,
      rotateGesturesEnabled: widget.interactive,
      tiltGesturesEnabled: widget.interactive,

      zoomControlsEnabled: false,
      compassEnabled: true,
      mapToolbarEnabled: false,

      buildingsEnabled: true,
      trafficEnabled: false,
      indoorViewEnabled: false,

      onCameraMove: (position) {
        _cameraTarget = position.target;
      },

      onCameraIdle: () {
        widget.onCameraIdlePosition?.call(
          _cameraTarget,
        );
      },

      // onMapCreated: (controller) {
      //   _mapController = controller;

      //   controller.moveCamera(
      //     CameraUpdate.newCameraPosition(
      //       CameraPosition(
      //         target: _cameraTarget,
      //         zoom: widget.zoom,
      //       ),
      //     ),
      //   );
      // },

      onMapCreated: (controller) {
  _mapController = controller;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;

    // Only center when GPS coordinates are available.
    if (widget.showMyLocation) {
      moveTo(
        LatLng(
          widget.latitude,
          widget.longitude,
        ),
      );
    }
  });
},
    );
  }
}