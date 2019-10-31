import 'package:flutter/material.dart';
import 'package:geolocatorapp/geomap/map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MapHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

