import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HeatMapPage extends StatefulWidget {
  @override
  _HeatMapPageState createState() => _HeatMapPageState();
}

class _HeatMapPageState extends State<HeatMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  Position position;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void initState() {
    super.initState();
    //_checkEmailVerification();
    _initializeMap();
  }

  void _initializeMap() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }
}
