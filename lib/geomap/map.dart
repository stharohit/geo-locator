import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGoogle extends StatelessWidget {
  final double lat, lng, zoom;
  final Completer<GoogleMapController> _controller =
      Completer();
  final GoogleMapController controller;

  MapGoogle(this.lat, this.lng, this.zoom, this.controller);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: zoom,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
  }

  void setCamera() async {
    GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng),
        zoom: 15,
        bearing: 12,
      )));
  }
}