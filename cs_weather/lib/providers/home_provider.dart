import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cs_weather/network/base_provider.dart';
import 'package:cs_weather/data/weather_response.dart';
import 'package:cs_weather/network/api_repository.dart';
import 'package:cs_weather/utilities/toast_message.dart';
import 'package:cs_weather/utilities/string_constants.dart';
import 'package:cs_weather/utilities/city_constants.dart';

class HomeProvider extends BaseProvider {
  final _repository = ApiRepository();
  final BuildContext context;
  WeatherDetails _weatherResponse = WeatherDetails();
  late List<WeatherDetails> _forecastWeatherResponse;
  late String _searchCity;

  HomeProvider(this.context) {
    filterBy(CitiesList.cityList[0]);
    loadJson(context);
  }

  Future<void> getCurrentWeather(String city) async {
    super.isLoading = true;
    WeatherDetails response;
    response = (await _repository.getCurrentWeather(city))!;
    super.isLoading = false;
    if (response != null) {
      weatherResponse = response;
    } else {
      //weatherResponse = null;
    }
  }

  Future<void> getForecastWeather(String city) async {
    super.isLoading = true;
    List<WeatherDetails> response;
    response = (await _repository.getForecastWeather(city))!;
    super.isLoading = false;
    if (response != null) {
      forecastWeatherResponse = response;
    } else {
      //forecastWeatherResponse = null;
    }
  }

  void filterBy(String searchCity) {
    this.searchCity = searchCity;
    getCurrentWeather(searchCity);
    getForecastWeather(searchCity);
  }

  getUserLocation() async {
    super.isLoading = true;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      getWeatherByLocation(position);
    } else {
      AppMessage.toast('Permission Denied!!', toastType: ToastType.FAILED);
      super.isLoading = false;
    }
  }

  Future<void> getWeatherByLocation(Position position) async {
    super.isLoading = true;
    WeatherDetails response;
    response = (await _repository.getLocationByLocation(
        position.latitude, position.longitude))!;
    super.isLoading = false;
    if (response != null) {
      weatherResponse = response;
    } else {
      //forecastWeatherResponse = null;
    }
  }

  WeatherDetails get weatherResponse => _weatherResponse;

  set weatherResponse(WeatherDetails value) {
    _weatherResponse = value;
    notifyListeners();
  }

  List<WeatherDetails> get forecastWeatherResponse => _forecastWeatherResponse;

  set forecastWeatherResponse(List<WeatherDetails> value) {
    _forecastWeatherResponse = value;
    notifyListeners();
  }

  String get searchCity => _searchCity;

  set searchCity(String value) {
    _searchCity = value;
    notifyListeners();
  }

  void loadJson(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString(JSON_CITIES_IN_MALAYSIA);
    final jsonResult = json.decode(data);
    print(jsonResult.toString());
  }

  void otherCityOnClicked() async {
    final result = await Navigator.pushNamed(context, ROUTE_SELECT_CITY);
    if (result != null) {
      filterBy(result.toString());
    }
  }
}