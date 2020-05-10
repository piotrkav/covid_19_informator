import 'package:covid_19_informator/model/covid_paginated_data_table_source.dart';
import 'package:covid_19_informator/service/covid_service.dart';
import 'package:covid_19_informator/service/service_locator.dart';
import 'package:covid_19_informator/util/const.dart';
import 'package:covid_19_informator/widget/covid_simple_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/covid-info.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CovidService covidService = locator<CovidService>();

  List<CovidCountryInfo> covidCountryInfoList;

  Future<List<CovidCountryInfo>> futureCovidCountryInfos;
  List<CovidCountryInfo> covidCountryInfos;
  CovidCountryInfo selectedCountry;

  @override
  void initState() {
    selectedCountry = null;
    futureCovidCountryInfos = covidService.getCovidInfoForCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: PrimaryColor,
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
      body: new Container(
        child: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<CovidCountryInfo>>(
            future: futureCovidCountryInfos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                covidCountryInfos = snapshot.data;
                selectedCountry = snapshot.data
                    .firstWhere((element) => element.country == 'Poland');
                if (selectedCountry == null) {
                  selectedCountry = covidCountryInfos.first;
                }
                return CovidSimpleDataWidget(
                  countries: snapshot.data,
                  selectedCountry: selectedCountry,
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Container(
                    child: Center(child: Text("${snapshot.error}")));
              } else {
                print("No data yet");
                List<Widget> children;
                children = <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  ),
                );
              }
              // By default, show a loading spinner.
            },
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  SingleChildScrollView dataBody(List<CovidCountryInfo> covidVirusInfo) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
            header: Text("Coronavirus is a biatch"),
            rowsPerPage: 10,
            columns: [
              DataColumn(
                label: Text("Country"),
                numeric: false,
                tooltip: "Country",
              ),
              DataColumn(
                label: Text("All cases"),
                numeric: true,
                tooltip: "All cases",
              ),
              DataColumn(
                label: Text("Todays cases"),
                numeric: true,
                tooltip: "Todays cases",
              ),
              DataColumn(
                label: Text("Total deaths"),
                numeric: true,
                tooltip: "Total deaths",
              ),
              DataColumn(
                label: Text("Todays deaths"),
                numeric: true,
                tooltip: "Todays deaths",
              ),
              DataColumn(
                label: Text("Recovered"),
                numeric: true,
                tooltip: "Recovered",
              ),
              DataColumn(
                label: Text("Active"),
                numeric: true,
                tooltip: "Active",
              ),
              DataColumn(
                label: Text("Critical"),
                numeric: true,
                tooltip: "Critical",
              ),
              DataColumn(
                label: Text("Cases per 1 million"),
                numeric: true,
                tooltip: "Cases per 1 million",
              ),
              DataColumn(
                label: Text("Deaths per 1 million"),
                numeric: true,
                tooltip: "Deaths per 1 million",
              ),
            ],
            source: new CovidPaginatedDataTableSource(covidVirusInfo)));
  }
}

class DataCounter extends StatelessWidget {
  final int numberOf;
  final Color colorOf;
  final String title;

  const DataCounter({
    Key key,
    this.numberOf,
    this.colorOf,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(4),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorOf.withOpacity(0.25),
          ),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(width: 2, color: colorOf)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "$numberOf",
          style: TextStyle(fontSize: 24, color: colorOf),
        ),
        Text(
          "$title",
          style: SubTextStyle,
        )
      ],
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
