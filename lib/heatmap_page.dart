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
  Position position;
  LatLng _center = new LatLng(43.549384, -79.662611);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void initState() {
    super.initState();
    //_checkEmailVerification();
    _initializeMap();
  }

  void _initializeMap() async {
    position = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 13.0,
      ),
    );
  }
}
