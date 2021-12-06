import 'dart:convert';
import 'package:cs_weather/network/base_repository.dart';
import 'package:cs_weather/data/weather_response.dart';
import 'package:cs_weather/utilities/string_constants.dart';
import 'package:cs_weather/network/service_provider.dart';

class ApiRepository extends BaseRepository {
  ApiRepository._internal();

  static final ApiRepository _userRepositoryInstance =
  new ApiRepository._internal();

  factory ApiRepository() => _userRepositoryInstance;

  Future<WeatherDetails?> getCurrentWeather(String cityParam) async {
    final response = await networkProvider.callWebService(
        method: APIMethod.GET,
        path: GET_CURRENT_WEATHER + 'q=$cityParam&appid=$API_KEY',
        headers: header);
    if (response != null) {
      final weatherJson = json.decode(response.body);
      final currentWeatherResponse = WeatherDetails.fromJson(weatherJson);
      return currentWeatherResponse;
    } else {
      return null;
    }
  }

  Future<List<WeatherDetails>?> getForecastWeather(String cityParam) async {
    final response = await networkProvider.callWebService(
        method: APIMethod.GET,
        path: GET_FORECAST_WEATHER + 'q=$cityParam&appid=$API_KEY',
        headers: header);
    if (response != null) {
      final weatherJson = json.decode(response.body);
      List<WeatherDetails> forecast =
      WeatherDetails.fromForecastJson(weatherJson);
      return forecast;
    } else {
      return null;
    }
  }

  Future<WeatherDetails?> getLocationByLocation(
      double latitude, double longitude) async {
    final response = await networkProvider.callWebService(
        method: APIMethod.GET,
        path: GET_CURRENT_WEATHER +
            'lat=$latitude&lon=$longitude&appid=$API_KEY',
        headers: header);
    if (response != null) {
      final weatherJson = json.decode(response.body);
      final currentWeatherResponse = WeatherDetails.fromJson(weatherJson);
      return currentWeatherResponse;
    } else {
      return null;
    }
  }
}