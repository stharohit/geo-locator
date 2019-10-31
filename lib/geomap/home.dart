import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocatorapp/geomap/locationUpdate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import './map.dart';

class MapHome extends StatefulWidget {
  MapHome({Key key}) : super(key: key);

  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  double lat, lng, zoom = 15; //map variables
  Completer<GoogleMapController> _controller =
      Completer(); //Map controller from google map flutter

  @override
  void initState() {
    super.initState();
    this.initialLocation();
    this.trackLocation();
  }

  void initialLocation() async {
    var location = new Location();
    var loc = await location.getLocation();

    setState(() {
      lat = loc.latitude;
      lng = loc.longitude;
    });
  }

  Future<void> trackLocation() async{
    GoogleMapController controller = await _controller.future;
    var location = new Location();
    location.onLocationChanged().listen((loc) {
      setState(() {
        lat = loc.latitude;
        lng = loc.longitude;
        zoom = 15;
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude, loc.longitude),
        zoom: 15,
        bearing: 12,
      )));
      MapGoogle(lat, lng, zoom);
      LocationUpdate(lat: lat, long: lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Locator'),
      ),
      body: Center(
        child: lat != null
            ? MapGoogle(lat, lng, zoom)
            : CircularProgressIndicator(),
      ),
      bottomNavigationBar: LocationUpdate(lat: lat, long: lng),
    );
  }
}
