// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PatgolitoMap extends StatefulWidget {
//   const PatgolitoMap({super.key});

//   @override
//   State<PatgolitoMap> createState() => _PatgolitoMapState();
// }

// class _PatgolitoMapState extends State<PatgolitoMap> {
//   GoogleMapController? _mapController;

//   // Temporary map location: Lucknow
//   // Current GPS location is NOT being accessed.
//   static const CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(26.8467, 80.9462),
//     zoom: 15.5,
//     tilt: 0,
//     bearing: 0,
//   );

//   @override
//   void dispose() {
//     _mapController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: _initialCameraPosition,

//       // Real, colourful Google road map
//       mapType: MapType.normal,

//       // Current location disabled for now
//       myLocationEnabled: false,
//       myLocationButtonEnabled: false,

//       // Map interaction
//       zoomGesturesEnabled: true,
//       scrollGesturesEnabled: true,
//       rotateGesturesEnabled: true,
//       tiltGesturesEnabled: true,

//       // Clean professional appearance
//       zoomControlsEnabled: false,
//       compassEnabled: true,
//       mapToolbarEnabled: false,

//       // Real map details
//       buildingsEnabled: true,
//       indoorViewEnabled: false,
//       trafficEnabled: false,

//       onMapCreated: (controller) {
//         _mapController = controller;
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PatgolitoMap extends StatefulWidget {
  const PatgolitoMap({
    super.key,
    this.latitude = 26.8467,
    this.longitude = 80.9462,
    this.zoom = 15.5,
    this.onCameraIdlePosition,
  });

  final double latitude;
  final double longitude;
  final double zoom;

  // Optional: future location selection support.
  final ValueChanged<LatLng>? onCameraIdlePosition;

  @override
  State<PatgolitoMap> createState() => _PatgolitoMapState();
}

class _PatgolitoMapState extends State<PatgolitoMap> {
  GoogleMapController? _mapController;
  late LatLng _cameraTarget;

  @override
  void initState() {
    super.initState();
    _cameraTarget = LatLng(widget.latitude, widget.longitude);
  }

  @override
  void didUpdateWidget(covariant PatgolitoMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude) {
      final target = LatLng(widget.latitude, widget.longitude);

      _cameraTarget = target;

      _mapController?.animateCamera(CameraUpdate.newLatLng(target));
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
      initialCameraPosition: CameraPosition(
        target: _cameraTarget,
        zoom: widget.zoom,
      ),
      mapType: MapType.normal,

      // GPS disabled
      myLocationEnabled: false,
      myLocationButtonEnabled: false,

      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,

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
        widget.onCameraIdlePosition?.call(_cameraTarget);
      },

      onMapCreated: (controller) {
        _mapController = controller;
      },
    );
  }
}
