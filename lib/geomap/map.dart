import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapHome extends StatefulWidget {
  MapHome({Key key}) : super(key: key);

  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  var location = new Location();
  static double lat, long;
  Completer<GoogleMapController> _controller = Completer();
  var tracking = false;

  @override
  void initState() {
    super.initState();
    this.listenLocation();
  }

  void listenLocation() async {
    final GoogleMapController controller = await _controller.future;

    if (tracking == true) {
      location.onLocationChanged().listen((loc) {
        setState(() {
          lat = loc.latitude;
          long = loc.longitude;
        });
        controller.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(loc.latitude, loc.longitude),
            zoom: 15,
          )),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Locator'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 3,
        ),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _currentLocation,
        child: Icon(Icons.location_searching),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: Text('Latitude: $lat, Longitude: $long'),
      ),
    );
  }

  Future<void> _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    final currentLocation = await location.getLocation();

    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15,
      )),
    );
    setState(() {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      tracking = tracking ? false : true;
    });
  }
}
