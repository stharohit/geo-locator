import 'package:flutter/material.dart';

class LocationUpdate extends StatelessWidget {
  final double lat, long;

  const LocationUpdate({Key key, this.lat, this.long}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text('latitude: $lat, longitude: $long'),
        ),
      ),
    );
  }
}
