import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';

class HeatMapPage extends StatefulWidget {
  @override
  _HeatMapPageState createState() => _HeatMapPageState();
}

class _HeatMapPageState extends State<HeatMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Position position;
  final Set<Heatmap> _heatmaps = {};
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.549384, -79.662611),
    zoom: 14.4746,
  );
  LatLng _heatmapLocation = LatLng(43.549384, -79.662611);

  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  void initState() {
    super.initState();
    //_checkEmailVerification();
    _initializeMap();
  }

  void _initializeMap() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _heatmapLocation = LatLng(position.latitude, position.longitude);
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _addHeatmap();
    return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        heatmaps: _heatmaps,
        initialCameraPosition: _kGooglePlex);
  }

  void _addHeatmap() {
    setState(() {
      _heatmaps.add(Heatmap(
          heatmapId: HeatmapId(_heatmapLocation.toString()),
          points: _createPoints(_heatmapLocation),
          radius: 50,
          visible: true,
          gradient: HeatmapGradient(
            colors: <Color>[Colors.red],
            startPoints: <double>[1.0],
          )));
    });
  }

  //heatmap generation helper functions
  List<WeightedLatLng> _createPoints(LatLng location) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(
        _createWeightedLatLng(location.latitude - 1, location.longitude, 1));

    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }
}
