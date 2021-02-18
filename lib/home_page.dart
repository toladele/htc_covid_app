import 'package:covid19/covid19.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_resource.dart';
import 'config/size_config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int globalCases = 0;
  int cityCases = 0;
  int countryCases = 0;
  int provinceCases = 0;

  @override
  void initState() {
    super.initState();
    //_checkEmailVerification();
    _getCovidStats();
  }

  void _getCovidStats() async {
    // get the latest update for Ontario
    var covid = Covid19Client();
    var provinceSummary =
        await covid.getLive(country: "Canada", status: "confirmed");
    var countrySummary = await covid.getByCountry(country: "Canada");
    var globalSummary = await covid.getWorldTotal();
    var globalContents = globalSummary.totalConfirmed;
    var countryContents =
        countrySummary.lastWhere((element) => element.country == "Canada");
    var provinceContents =
        provinceSummary.lastWhere((element) => element.province == "Ontario");
    setState(() {
      provinceCases = provinceContents.confirmed;
      countryCases = countryContents.confirmed;
      globalCases = globalContents;
      cityCases = 847;
    });
    var reversedContents = "hey";
    covid.close();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
              getCanadaLogo(),
              getNumCases(),
              Text(
                'New Confirmed Cases'.toUpperCase(),
                maxLines: 3,
                style: TextStyle(
                    color: ColorResource.accentColor,
                    fontSize: SizeConfig().getBlockSizeHorizontal(13),
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(0),
                  SizeConfig().getBlockSizeHorizontal(0),
                  SizeConfig().getBlockSizeVertical(5),
                ),
                child: Text(
                  'Mississauga, ON'.toUpperCase(),
                  style: TextStyle(
                      color: ColorResource.accentColor,
                      fontSize: SizeConfig().getBlockSizeHorizontal(10),
                      fontWeight: FontWeight.normal),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Province-wide: ',
                    style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
                      color: ColorResource.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    provinceCases.toString().replaceAllMapped(
                        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
                    style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
                      color: ColorResource.accentColor,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Nationwide: ',
                    style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
                      color: ColorResource.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    countryCases.toString().replaceAllMapped(
                        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
                    style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
                      color: ColorResource.accentColor,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Global: ',
                    style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
                      color: ColorResource.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    globalCases.toString().replaceAllMapped(
                        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
                    style: TextStyle(
                      fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
                      color: ColorResource.accentColor,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: _selectedIndex == 2
            ? FloatingActionButton(
                onPressed: () {},
                tooltip: 'Increment',
                child: Icon(Icons.add),
              )
            : Container(), // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: SizeConfig().getBlockSizeVertical(3.0),
          unselectedItemColor: Theme.of(context).secondaryHeaderColor,
          selectedItemColor: ColorResource.accentColor,
          backgroundColor: ColorResource.mainColor,
          elevation: 10.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Bulletin',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Expenses',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getCanadaLogo() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        SizeConfig().getBlockSizeHorizontal(45),
      ),
      child: Row(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/canada.png"),
              width: SizeConfig().getBlockSizeHorizontal(10),
              // height: SizeConfig().getBlockSizeVertical(25),
            ),
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              SizeConfig().getBlockSizeHorizontal(2),
              0,
            ),
          ),
          Text(
            'Canada',
            style: TextStyle(
              fontSize: SizeConfig().getBlockSizeHorizontal(5.0),
              color: ColorResource.accentFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget getNumCases() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        SizeConfig().getBlockSizeVertical(2),
      ),
      child: Text(
        cityCases.toString().toUpperCase(),
        style: TextStyle(
            color: ColorResource.accentFont,
            fontSize: SizeConfig().getBlockSizeHorizontal(13),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
