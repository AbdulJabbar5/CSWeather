import 'package:flutter/material.dart';
import 'package:weatherapp/ui/citysecection/city_selection_page.dart';
import 'package:cs_weather/utilities/string_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_SELECT_CITY:
        return MaterialPageRoute(
            builder: (_) => CitySelectionPage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}