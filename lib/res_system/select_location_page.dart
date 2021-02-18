import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:htc_covid_app/config/color_resource.dart';

class SelectLocationPage extends StatefulWidget {
  SelectLocationPage({this.locationList, this.position});

  final List locationList;
  final Position position;

  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select a Vaccination Site',
          style: TextStyle(color: ColorResource.accentColor),
        ),
        backgroundColor: ColorResource.mainColor,
        elevation: 5.0,
      ),
      body: Container(
        child: new ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 2.0,
              );
            },
            itemCount: widget.locationList.length,
            itemBuilder: (BuildContext context, int index) {
              var lat = widget.locationList[index].geometry.location.lat;
              var long = widget.locationList[index].geometry.location.lng;
              var distance = calculateDistance(lat, long);
              return new ListTile(
                title: Text(widget.locationList[index].name),
                subtitle: Text(widget.locationList[index].vicinity),
                trailing: Text(
                  '${distance.toStringAsFixed(2)}km',
                  style: TextStyle(color: ColorResource.accentColor),
                ),
              );
            }),
      ),
    );
  }

  double calculateDistance(var givenLat, givenLong) {
    var distance = Geolocator.distanceBetween(widget.position.latitude,
        widget.position.longitude, givenLat, givenLong);
    return distance / 1000;
  }
}
