import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CovidWatch',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Color(0xff143150),
          secondaryHeaderColor: Color(0xff000000), // 08b9ff, 609fe2 (original)
          scaffoldBackgroundColor: Color(0xffD8D8D8),
          buttonColor: Color(0xff143150),
          cardColor: Color(0xff5a7491),
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        home: new HomePage(
          title: 'CovidWatch',
        ));
  }
}
