import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:htc_covid_app/config/color_resource.dart';
import 'package:htc_covid_app/config/size_config.dart';
import 'package:htc_covid_app/res_system/select_location_page.dart';
import 'package:htc_covid_app/res_system/view_appointment_page.dart';

import '../config/key_resource.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

final searchScaffoldKey = GlobalKey<ScaffoldState>();
final homeScaffoldKey = GlobalKey<ScaffoldState>();
const kGoogleApiKey = KeyResource.googleAPI;
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class _ReservationPageState extends State<ReservationPage> {
  Position position;
  var selectedAddress = "";
  var selectedLocationName = "";
  var selectedWebsite = "";
  var selectedPhoneNumber;
  var processedResponse;

  void initState() {
    super.initState();
    _determinePosition();
  }

  void _determinePosition() async {
    // gets all locations within 50km and calls process function to add to a list
    position = await Geolocator.getCurrentPosition();
    PlacesSearchResponse response = await _places.searchNearbyWithRadius(
        new Location(position.latitude, position.longitude), 5000,
        keyword: "health");
    _processResponse(response);
  }

  void _processResponse(PlacesSearchResponse response) {
    // filter out non-health responses
    processedResponse = response.results
        .where((element) => element.types.contains("health"))
        .toList();
    selectedAddress = "";
    selectedLocationName = "";
    selectedWebsite = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
          SizeConfig().getBlockSizeHorizontal(3),
          SizeConfig().getBlockSizeVertical(10),
          SizeConfig().getBlockSizeHorizontal(1),
          SizeConfig().getBlockSizeVertical(00),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            getVaccinatedLogo(),
            Text(
              'View or schedule your vaccination:'.toUpperCase(),
              // maxLines: 3,
              style: TextStyle(
                  color: ColorResource.accentColor,
                  fontSize: SizeConfig().getBlockSizeHorizontal(12),
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                SizeConfig().getBlockSizeHorizontal(0),
                SizeConfig().getBlockSizeVertical(3),
                SizeConfig().getBlockSizeHorizontal(0),
                SizeConfig().getBlockSizeVertical(00),
              ),
              child: RaisedButton(
                color: ColorResource.mainColor,
                onPressed: _handlePressButton,
                child: Text(
                  "Book Appointment".toUpperCase(),
                  style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(6),
                      color: ColorResource.accentFont),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: ColorResource.accentFont,
                        width: SizeConfig().getBlockSizeHorizontal(0.8))),
              ),
            ),
            RaisedButton(
              color: ColorResource.mainColor,
              child: Text(
                "View Appointment".toUpperCase(),
                style: TextStyle(
                  fontSize: SizeConfig().getBlockSizeHorizontal(6),
                  color: ColorResource.accentFont,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: ColorResource.accentFont,
                      width: SizeConfig().getBlockSizeHorizontal(0.8))),
              onPressed: () => _navigateToViewAppointmentPage(),
            ),
          ],
        ));
  }

  void onError(PlacesAutocompleteResponse response) {
    // catch errors
    print(response.errorMessage);
  }

  Future<void> _handlePressButton() async {
    // handle button click
    _navigateToSelectLocationPage();
  }

  _navigateToSelectLocationPage() async {
    Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => SelectLocationPage(
              locationList: processedResponse, position: position)),
    );
  }

  _navigateToViewAppointmentPage() async {
    Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ViewAppointmentPage()),
    );
  }

  Widget getVaccinatedLogo() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        SizeConfig().getBlockSizeHorizontal(60),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              SizeConfig().getBlockSizeHorizontal(2),
              0,
            ),
            child: Icon(
              Icons.check_circle,
              size: SizeConfig().getBlockSizeHorizontal(8),
              color: ColorResource.accentFont,
            ),
          ),
          Text(
            'Get Vaccinated!'.toUpperCase(),
            style: TextStyle(
              fontSize: SizeConfig().getBlockSizeHorizontal(6.0),
              color: ColorResource.accentFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
