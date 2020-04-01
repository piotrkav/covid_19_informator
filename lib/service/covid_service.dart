import 'dart:convert';

import 'package:covid_19_informator/model/covid-info.dart';
import 'package:http/http.dart' as http;

class CovidService {
  Future<List<CovidCountryInfo>> getCovidInfoForCountries() async {
    final response = await http.get('https://corona.lmao.ninja/countries');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("data fetched");
      print(response.body);
      try {
        Iterable list = json.decode(response.body);
        var countriesInfo = list.map((model) => CovidCountryInfo.fromJson(model)).toList();
        print(countriesInfo);
        return countriesInfo;
      } on Exception catch (e) {
        print(e);
        return new List();
      }
    } else {
      return new List();
    }
  }
}
