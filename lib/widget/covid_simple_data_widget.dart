import 'package:covid_19_informator/model/covid-info.dart';
import 'package:covid_19_informator/util/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home.dart';

class CovidSimpleDataWidget extends StatefulWidget {
  final List<CovidCountryInfo> countries;
  final CovidCountryInfo selectedCountry;

  const CovidSimpleDataWidget({Key key, this.countries, this.selectedCountry})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CovidSimpleDataState(countries, selectedCountry);
  }
}

class CovidSimpleDataState extends State<CovidSimpleDataWidget> {
  List<CovidCountryInfo> countries;
  CovidCountryInfo selectedCountry;

  CovidSimpleDataState(this.countries, this.selectedCountry);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipPath(
          clipper: BottomClipper(),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF1146CF),
                    ]),
                image: DecorationImage(image: AssetImage(MainPageImgPath))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/dr.svg",
                        width: 230,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                        top: 100,
                        left: 150,
                        child: Text(
                          "#StayAtHome",
                          style: HeadingTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: BorderColor,
              )),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isExpanded: true,
                      style: SubTextStyle,
                      value: selectedCountry,
                      items: countries
                          .map((countryInfo) => DropdownMenuItem(
                              value: countryInfo,
                              child: Text(countryInfo.country)))
                          .toList(),
                      onChanged: (selected) {
                        changeData(selected);
                      }),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Case update \n",
                          style: TitleTextStyle,
                        ),
                        TextSpan(
                          text: "Newest update on 03.05.2020",
                          style: SubTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Details",
                    style: TextStyle(
                        color: PrimaryColor, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: ShadowColor,
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DataCounter(
                      colorOf: InfectedColor,
                      numberOf: selectedCountry.cases,
                      title: "Infected",
                    ),
                    DataCounter(
                        colorOf: RecoverColor,
                        numberOf: selectedCountry.recovered,
                        title: "Recovered"),
                    DataCounter(
                        colorOf: DeathColor, numberOf: selectedCountry.deaths, title: "Deaths"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void changeData(CovidCountryInfo selected) {
    print(selected.country);
    setState(() {
      this.selectedCountry = selected;
    });
  }
}
