import 'package:flutter/material.dart';
import 'package:cs_weather/data/weather_response.dart';
import 'package:cs_weather/custom_widgets/app_text.dart';
import 'package:cs_weather/utilities/color_constants.dart';
import 'package:cs_weather/custom_widgets/value_title.dart';

class CurrentConditions extends StatelessWidget {
  final WeatherDetails weather;

  const CurrentConditions({required Key key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: pureWhite,
          size: 50,
        ),
        SizedBox(
          height: 10,
        ),
        AppText(
          text: '${this.weather.temperature!.celsius}°',
          fontSize: 17,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile(
            "max",
            '${this.weather.maxTemperature!.celsius}°',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Container(
                width: 1,
                height: 30,
                color: pureWhite,
              ),
            ),
          ),
          ValueTile("min", '${this.weather.minTemperature!.celsius}°'),
        ]),
      ],
    );
  }
}