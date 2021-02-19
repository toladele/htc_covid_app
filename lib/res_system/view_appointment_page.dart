import 'package:flutter/material.dart';
import 'package:htc_covid_app/config/cache_manager.dart';
import 'package:htc_covid_app/config/color_resource.dart';
import 'package:htc_covid_app/config/size_config.dart';

class ViewAppointmentPage extends StatefulWidget {
  @override
  _ViewAppointmentPageState createState() => _ViewAppointmentPageState();
}

class _ViewAppointmentPageState extends State<ViewAppointmentPage> {
  List<String> appointmentData = ["No appointment booked!", "", "", ""];

  @override
  void initState() {
    super.initState();
    _getDataFromCache();
  }

  void _getDataFromCache() {
    CacheManager().readCache().then((String contents) {
      setState(() {
        appointmentData = contents.split("\n").toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(appointmentData);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg3.png"), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ColorResource.accentColor, //change your color here
          ),
          title: Text(
            'View Appointment',
            style: TextStyle(color: ColorResource.accentColor),
          ),
          backgroundColor: ColorResource.mainColor,
          elevation: 5.0,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(
            SizeConfig().getBlockSizeHorizontal(3),
            SizeConfig().getBlockSizeVertical(10),
            SizeConfig().getBlockSizeHorizontal(3),
            SizeConfig().getBlockSizeVertical(0),
          ),
          child: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(0),
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(8),
                ),
                child: Text(
                  'Your vaccination is scheduled for:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorResource.accentColor,
                      fontSize: SizeConfig().getBlockSizeHorizontal(5),
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(0),
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(1),
                ),
                child: Text(
                  appointmentData[0] != null
                      ? appointmentData[0]
                      : "No appointments booked!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorResource.accentColor,
                      fontSize: SizeConfig().getBlockSizeHorizontal(8),
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(0),
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(8),
                ),
                child: Text(
                  appointmentData[2] != null ? appointmentData[2] : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorResource.accentColor,
                      fontSize: SizeConfig().getBlockSizeHorizontal(5),
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(0),
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(1),
                ),
                child: Text(
                  appointmentData[3] != null
                      ? appointmentData[3].replaceFirst("—", "\n")
                      : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorResource.accentColor,
                      fontSize: SizeConfig().getBlockSizeHorizontal(8),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppointmentLogo() {
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
            'Your Appointment'.toUpperCase(),
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
