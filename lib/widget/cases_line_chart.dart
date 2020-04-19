import 'package:charts_flutter/flutter.dart';
import 'package:covid_19_informator/model/covid-historical-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CasesLineChart extends StatelessWidget {
  CasesLineChart(this.covidHistoricData);

  CovidHistoricData covidHistoricData;

//  final List<Series<TimeSeriesSales, DateTime>> seriesList;

  @override
  Widget build(BuildContext context) =>
      TimeSeriesChart(getSeriesListFromHistoricalData(covidHistoricData),
          animate: true,
          behaviors: [
            new ChartTitle('Number of cases in ' + covidHistoricData.country,
                behaviorPosition: BehaviorPosition.top,
                titleOutsideJustification: OutsideJustification.start,
                // Set a larger inner padding than the default (10) to avoid
                // rendering the text too close to the top measure axis tick label.
                // The top tick label may extend upwards into the top margin region
                // if it is located at the top of the draw area.
                innerPadding: 18),
          ],
          dateTimeFactory: const LocalDateTimeFactory(),
          domainAxis: DateTimeAxisSpec(
              showAxisLine: true,
              viewport: DateTimeExtents(
                  start: getFirstDate(covidHistoricData),
                  end: getLastDate(covidHistoricData)),
              tickFormatterSpec: new AutoDateTimeTickFormatterSpec(
                  day: new TimeFormatterSpec(
                      format: 'd', transitionFormat: 'MM/dd/yyyy'))));

  /// Create one series with sample hard coded data.

  List<Series<TimeSeriesSales, DateTime>> getSeriesListFromHistoricalData(
      CovidHistoricData covidHistoricData) {
    var country = covidHistoricData.country;

    List<TimeSeriesSales> data = new List();
    covidHistoricData.timeline.cases.forEach((key, value) {
      DateFormat fromDate = new DateFormat('M/dd/yy');
      DateFormat myFormat = new DateFormat('20yyMMdd');
      String date = myFormat.format(fromDate.parse(key));
      print(date);
      if (date != null) {
        var keyDate = DateTime.tryParse(date);
        print(keyDate);
        if (keyDate != null) {
          print(keyDate.year);
          print(keyDate.month);
          print(keyDate.day);
          data.add(new TimeSeriesSales(
              DateTime(keyDate.year, keyDate.month, keyDate.day), value));
        }
      }
    });
//   data = <TimeSeriesSales>[
//      TimeSeriesSales(DateTime(2019, 1, 7), 5),
//      TimeSeriesSales(DateTime(2019, 1, 8), 25),
//      TimeSeriesSales(DateTime(2019, 1, 9), 100),
//      TimeSeriesSales(DateTime(2019, 1, 10), 75),
//    ];

    return <Series<TimeSeriesSales, DateTime>>[
      Series<TimeSeriesSales, DateTime>(
        id: 'cases in ' + country,
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  getFirstDate(CovidHistoricData covidHistoricData) {
    var list = covidHistoricData.timeline.cases.entries.toList();
    return parseDateFromKey(list[0].key);
  }

  getLastDate(CovidHistoricData covidHistoricData) {
    var list = covidHistoricData.timeline.cases.entries.toList();
    return parseDateFromKey(list.last.key);
  }

}

DateTime parseDateFromKey(key) {
  DateFormat fromDate = new DateFormat('M/dd/yy');
  DateFormat myFormat = new DateFormat('20yyMMdd');
  String date = myFormat.format(fromDate.parse(key));
  var keyDate = DateTime.tryParse(date);
  return DateTime(keyDate.year, keyDate.month, keyDate.day);
}

class TimeSeriesSales {
  TimeSeriesSales(this.time, this.sales);

  final DateTime time;
  final int sales;
}
