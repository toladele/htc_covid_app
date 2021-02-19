import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htc_covid_app/config/cache_manager.dart';
import 'package:htc_covid_app/config/color_resource.dart';
import 'package:htc_covid_app/config/group-button/group_button.dart';
import 'package:htc_covid_app/config/size_config.dart';
import 'package:random_date/random_date.dart';

class SelectDatePage extends StatefulWidget {
  SelectDatePage({this.locationData});

  final List<dynamic> locationData;

  @override
  _SelectDatePageState createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  List<String> randomDates = [""];
  var selectedDate;

  @override
  void initState() {
    super.initState();
    randomDates = getRandomDate();
    selectedDate = randomDates[0];
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> locationData = widget.locationData;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ColorResource.accentColor, //change your color here
          ),
          title: Text(
            'Select a Date',
            style: TextStyle(color: ColorResource.accentColor),
          ),
          backgroundColor: ColorResource.mainColor,
          elevation: 5.0,
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                SizeConfig().getBlockSizeHorizontal(0),
                SizeConfig().getBlockSizeVertical(6),
                SizeConfig().getBlockSizeHorizontal(0),
                SizeConfig().getBlockSizeVertical(0),
              ),
              child: Center(
                  child: Text(
                widget.locationData[0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig().getBlockSizeHorizontal(6),
                  color: ColorResource.accentColor,
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                SizeConfig().getBlockSizeHorizontal(0),
                SizeConfig().getBlockSizeVertical(0),
                SizeConfig().getBlockSizeHorizontal(0),
                SizeConfig().getBlockSizeVertical(5),
              ),
              child: Center(
                  child: Text(
                widget.locationData[2],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig().getBlockSizeHorizontal(4),
                  color: ColorResource.accentColor,
                ),
              )),
            ),
            Center(
              child: Container(
                child: GroupButton(
                  selectedColor: ColorResource.accentFont,
                  isRadio: true,
                  spacing: 10,
                  direction: Axis.vertical,
                  onSelected: (index, isSelected) {
                    setState(() {
                      selectedDate = randomDates[index];
                    });
                    // print(locationData[3]);
                  },
                  buttons: randomDates,
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(4),
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(0),
                ),
                child: RaisedButton(
                  color: ColorResource.mainColor,
                  onPressed: () {
                    setState(() {
                      locationData.add(selectedDate);
                    });
                    _handlePressButton(locationData);
                  },
                  child: Text(
                    "Book Appointment".toUpperCase(),
                    style: TextStyle(
                        fontSize: SizeConfig().getBlockSizeHorizontal(5),
                        color: ColorResource.accentFont),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                          color: ColorResource.accentFont,
                          width: SizeConfig().getBlockSizeHorizontal(0.8))),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _handlePressButton(List<dynamic> data) async {
    // handle button click
    _createDataAndPop(data);
  }

  List<String> getRandomDate() {
    Random random = new Random();
    List<String> dateOptions = [];
    while (dateOptions.length < 5) {
      int randomTime = random.nextInt(18) + 08;
      var randomDate = RandomDate.withRange(2021, 2022).random();
      if (randomDate.isBefore(DateTime.now()) == false) {
        String dateSlug =
            "${getMonth(randomDate.month)} ${randomDate.day}, ${randomDate.year} — ${randomTime}:00";
        dateOptions.add(dateSlug);
      }
    }
    return dateOptions;
  }

  String getMonth(int month) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  Future<File> _createDataAndPop(List data) async {
    // concatenate all of the data in one string, separated by a line break
    int i = 0;
    var dataString = "";
    while (i < data.length) {
      data[i] = '${data[i]}\n';
      dataString += data[i];
      i++;
    }
    CacheManager().writeCache(dataString);
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }
}
