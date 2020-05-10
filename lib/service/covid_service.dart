import 'dart:convert';

import 'package:covid_19_informator/model/covid-historical-data.dart';
import 'package:covid_19_informator/model/covid-info.dart';
import 'package:http/http.dart' as http;

class CovidService {
  Future<List<CovidCountryInfo>> getCovidInfoForCountries() async {
    final response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    if (response.statusCode == 200) {
      try {
        Iterable list = json.decode(response.body);
        print(list);
        var countriesInfo =
            list.map((model) => CovidCountryInfo.fromJson(model)).toList();
        return countriesInfo;
      } on Exception catch (e) {
        print(e);
        return new List();
      }
    } else {
      print(response.statusCode);
      return new List();
    }
  }

  Future<List<CovidHistoricData>> getHistoricalData() async {
    final response = await http.get('https://corona.lmao.ninja/v2/historical');
    if (response.statusCode == 200) {
      try {
        Iterable list = json.decode(response.body);
        var historicalCountriesInfo =
            list.map((model) => CovidHistoricData.fromJson(model)).toList();
        return historicalCountriesInfo;
      } on Exception catch (e) {
        print(e);
        return new List();
      }
    } else {
      print(response.statusCode);
      return new List();
    }
  }
}
