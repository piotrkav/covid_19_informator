class CovidHistoricData {
  String country;
  String province;
  Timeline timeline;

  CovidHistoricData.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    province = json['province'];
    timeline = json['timeline'] != null
        ? new Timeline.fromJson(json['timeline'])
        : null;
  }
}

class Timeline {
  Map<String, int> cases;
  Map<String, int> deaths;
  Map<String, int> recovered;

  Timeline({this.cases, this.deaths, this.recovered});

  Timeline.fromJson(Map<String, dynamic> map) {
    cases = map['cases'] != null ? Map.from(map['cases']) : null;
    deaths = map['deaths'] != null ? Map.from(map['deaths']) : null;
    recovered = map['recovered'] != null ? Map.from(map['recovered']) : null;
  }
}
