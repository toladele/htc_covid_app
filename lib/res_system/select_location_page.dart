import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:htc_covid_app/config/color_resource.dart';
import 'package:htc_covid_app/res_system/select_date_page.dart';

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
    var locationList = widget.locationList == null ? [] : widget.locationList;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorResource.accentColor, //change your color here
        ),
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
            itemCount: locationList.length,
            itemBuilder: (BuildContext context, int index) {
              var lat = locationList[index].geometry.location.lat;
              var long = locationList[index].geometry.location.lng;
              var distance = calculateDistance(lat, long);
              var name = locationList[index].name;
              var address = locationList[index].vicinity;
              List<dynamic> locationData = [
                name,
                '${distance.toStringAsFixed(2)}km',
                address
              ];
              return new ListTile(
                title: Text(name),
                subtitle: Text(address),
                trailing: Text(
                  '${distance.toStringAsFixed(2)}km',
                  style: TextStyle(color: ColorResource.accentColor),
                ),
                onTap: () => _handlePressButton(locationData),
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

  Future<void> _handlePressButton(List<dynamic> data) async {
    // handle button click
    _navigateToSelectDatePage(data);
  }

  _navigateToSelectDatePage(List<dynamic> data) async {
    Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => SelectDatePage(
                locationData: data,
              )),
    );
  }
}
