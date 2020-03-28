class CovidCountryInfo {
  String country;
  int cases;
  int todayCases;

  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;

  CovidCountryInfo(
      {this.country,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion});

  static List<CovidCountryInfo> getTempInfo() {
    return <CovidCountryInfo>[
      CovidCountryInfo(
          country: "Poland",
          cases: 1481,
          todayCases: 82,
          deaths: 17,
          todayDeaths: 1,
          recovered: 100,
          active: 19,
          critical: 3,
          casesPerOneMillion: 0.2,
          deathsPerOneMillion: 0.02),
      CovidCountryInfo(
          country: "USA",
          cases: 1481,
          todayCases: 82,
          deaths: 17,
          todayDeaths: 1,
          recovered: 100,
          active: 19,
          critical: 3,
          casesPerOneMillion: 0.2,
          deathsPerOneMillion: 0.02),
    ];
  }
}
