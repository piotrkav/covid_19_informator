import 'package:covid_19_informator/service/service_locator.dart';
import 'package:covid_19_informator/util/const.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'COVID-19 Virus Informator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: BackgroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(bodyText2: TextStyle(color: BodyTextColor)),
      ),
      home: MyHomePage(title: 'COVID-19 Virus Informator'),
    );
  }
}
