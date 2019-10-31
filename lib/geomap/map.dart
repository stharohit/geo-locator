import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGoogle extends StatelessWidget {
  final double lat, lng, zoom;

  MapGoogle(this.lat, this.lng, this.zoom);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: zoom,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      );
  }
}