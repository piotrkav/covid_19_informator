import 'package:covid_19_informator/model/covid_paginated_data_table_source.dart';
import 'package:covid_19_informator/service/covid_service.dart';
import 'package:covid_19_informator/service/service_locator.dart';
import 'package:covid_19_informator/widget/cases_line_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/covid-historical-data.dart';
import 'model/covid-info.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.  // This class is the configuration for the state. It holds the values (in this
  //  // case the title) provided by the parent (in this case the App widget) and
  //  // used by the build method of the State. Fields in a Widget subclass are
  //  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CovidService covidService = locator<CovidService>();

  List<CovidCountryInfo> covidCountryInfoList;

  Future<List<CovidCountryInfo>> futureCovidCountryInfos;
  Future<List<CovidHistoricData>> futureCovidHistoricData;
  bool sort;

  @override
  void initState() {
    sort = false;
    futureCovidCountryInfos = covidService.getCovidInfoForCountries();
    futureCovidHistoricData = covidService.getHistoricalData();
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Container(
          child: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<List<CovidCountryInfo>>(
                  future: futureCovidCountryInfos,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Flexible(
                        child: dataBody(snapshot.data),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                new Container(
                  height: 1,
                  width: 1,
                ),
                FutureBuilder<List<CovidHistoricData>>(
                  future: futureCovidHistoricData,
                  builder: (context, snapshot) {
                    // ignore: missing_return
                    if (snapshot.hasData) {
                      return Flexible(
                        child: Container(
                          color: Colors.white,
                          height: 400.0,
                          width: 800.0,
                          child: new Padding(
                            padding: new EdgeInsets.all(10),
                            child: new CasesLineChart(snapshot.data.firstWhere(
                                (element) => element.country == 'Poland')),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                  },
                ),
              ],
            ),
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
