import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cs_weather/data/cities_data.dart';
import 'package:cs_weather/data/fav_city.dart';
import 'package:cs_weather/network/base_provider.dart';
import 'package:cs_weather/utilities/string_constants.dart';

class CitySelectionProvider extends BaseProvider {
  BuildContext context;
  List<CitiesData>? _listOfAllCity;
  Box<FavCity>? favCityBox;
  
  CitySelectionProvider(this.context) {
    super.isLoading = true;
    initBoxes();
    loadJson();
  }

  Future<void> loadJson() async {
    if (favCityBox!.length == 0) {
      String data = await DefaultAssetBundle.of(context)
          .loadString(JSON_CITIES_IN_MALAYSIA);
      final cityJson = json.decode(data);
      listOfAllCity = CitiesData.fromJsonToList(cityJson);
      listOfAllCity.forEach((item) {
        addToHive(FavCity(item.city ?? "", item.admin ?? "", item.country ?? "", item.lat ?? "",
            item.lng ?? "", item.isFavourite ?? false));
      });
    }
    super.isLoading = false;
  }

  void addToHive(FavCity item) async {
    await favCityBox!.add(item);
    notifyListeners();
  }

  List<CitiesData> get listOfAllCity => _listOfAllCity ?? [];

  set listOfAllCity(List<CitiesData> value) {
    _listOfAllCity = value;
    notifyListeners();
  }

  void initBoxes() async {
    favCityBox = Hive.box<FavCity>(BOX_NAME);
    await Hive.openBox<FavCity>(BOX_NAME);
  }
}