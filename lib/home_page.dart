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
  int _counter = 0;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: SizeConfig().getBlockSizeVertical(10),
          ),
          Text(
            '20'.toUpperCase(),
            style: TextStyle(
                color: Colors.red[800],
                fontSize: SizeConfig().getBlockSizeHorizontal(30),
                fontWeight: FontWeight.bold),
          ),
          Text(
            'New'.toUpperCase(),
            style: TextStyle(
                color: ColorResource.accentColor,
                fontSize: SizeConfig().getBlockSizeHorizontal(16),
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Confirmed'.toUpperCase(),
            style: TextStyle(
                color: ColorResource.accentColor,
                fontSize: SizeConfig().getBlockSizeHorizontal(16),
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Cases'.toUpperCase(),
            style: TextStyle(
                color: ColorResource.accentColor,
                fontSize: SizeConfig().getBlockSizeHorizontal(16),
                fontWeight: FontWeight.bold),
          ),
          Text(
            'London'.toUpperCase(),
            style: TextStyle(
                color: ColorResource.accentColor,
                fontSize: SizeConfig().getBlockSizeHorizontal(14),
                fontWeight: FontWeight.normal),
          ),
        ],
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
