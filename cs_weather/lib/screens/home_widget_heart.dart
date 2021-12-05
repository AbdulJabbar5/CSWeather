import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cs_weather/utilities/string_constants.dart';
import 'package:cs_weather/utilities/size_constants.dart';
import 'package:cs_weather/utilities/color_constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:cs_weather/custom_widgets/app_text.dart';

// menu list for locations
enum LocationMenu {
  LOCATION_KUALA_LUMPUR,
  LOCATION_GEORGE_TOWN,
  LOCATION_JOHAR_BAHRU,
  LOCATION_USE_CURRENT,
  LOCATION_ALL_CITY
}

// home widget root
class HomeWidget {
  final HomeProvider homeProvider;
  final BuildContext context;

  HomeWidget(this.homeProvider, this.context);

  // appbar widget
  Widget appBar() {
    return AppBar(
      title: AppText(
        text: APP_NAME,
        fontSize: bigTextSize,
      ),
      centerTitle: true,
      elevation: 0,
      actions: <Widget>[
        PopupMenuButton<LocationMenu>(
          onSelected: this._onOptionMenuItemSelected,
          child: Padding(
            padding: const EdgeInsets.all(pagePadding),
            child: Icon(
              Icons.location_on,
              color: textWhite,
            ),
          ),
          itemBuilder: (context) => <PopupMenuEntry<LocationMenu>>[
            _menuItemBuilder(
                CityList.cityList[0], LocationMenu.LOCATION_KUALA_LUMPUR),
            _menuItemBuilder(
                CityList.cityList[1], LocationMenu.LOCATION_GEORGE_TOWN),
            _menuItemBuilder(
                CityList.cityList[2], LocationMenu.LOCATION_JOHAR_BAHRU),
            _menuItemBuilder(
                CityList.cityList[3], LocationMenu.LOCATION_ALL_CITY),
            _menuItemBuilder(
                CityList.cityList[4], LocationMenu.LOCATION_USE_CURRENT),
          ],
        )
      ],
    );
  }

  // body widget
  Widget homeBody() {
    WeatherDetails data;
    if (homeProvider.weatherResponse != null) {
      data = homeProvider.weatherResponse;
    }
    return SafeArea(
      child: Container(
        decoration: backgroundDecoration(),
        child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: homeProvider.weatherResponse != null
              ? ListView(
            padding: EdgeInsets.all(pagePadding),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppText(
                    text: data.name,
                    fontSize: bigTextSize,
                    alignment: TextAlign.start,
                  ),
                  SizedBox(
                    height: iconHeight,
                    width: iconWidth,
                    child: Icon(
                      data.getIconData(),
                      color: pureWhite,
                    ),
                  )
                ],
              ),
              AppText(
                text: '${data.description}',
                fontSize: normalTextSize,
                alignment: TextAlign.start,
              ),
              currentDateTimeWidget(),
              AppText(
                text: '${data.temperature.celsius.toStringAsFixed(1)}°',
                fontSize: doubleBigTextSize,
                alignment: TextAlign.start,
              ),
              gap(),
              AppText(
                text: HOW_IS_TODAY,
                fontSize: bigTextSize,
              ),
              _weatherSwipeView(),
              gap(),
              Padding(
                child: Divider(color: pureWhite),
                padding: EdgeInsets.all(10),
              ),
              AppText(
                text: FORECAST,
                fontSize: bigTextSize,
              ),
              gap(),
              homeProvider.forecastWeatherResponse != null
                  ? ForecastHorizontalList(
                weatherList: homeProvider.forecastWeatherResponse,
              )
                  : Container(),
              gap(),
              Divider(
                height: 10,
                color: Colors.white,
              ),
            ],
          )
              : homeProvider.isLoading
              ? Container(
            child: Center(
              child: AppText(
                text: 'Loading..',
              ),
            ),
          )
              : LoadingFailedWidget(homeProvider: this.homeProvider),
        ),
      ),
    );
  }

  // common height size
  Widget gap() {
    return SizedBox(
      height: 10,
    );
  }

  // date formatter
  Widget currentDateTimeWidget() {
    return AppText(
      text: DateFormat('EEEE, d MMMM yyyy').format(
        DateTime.now(),
      ),
      alignment: TextAlign.start,
    );
  }

  // swiper view
  _weatherSwipeView() {
    WeatherDetails data = homeProvider.weatherResponse;
    return Opacity(
      opacity: 0.6,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .25,
        child: Swiper(
          itemCount: 4,
          index: 0,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                {
                  return _swipeView(
                      WIND_SPEED, GIF_WIND_MILL, '${data.windSpeed} kmph');
                }
                break;
              case 1:
                {
                  return _swipeView(
                    SUN_RISE,
                    GIF_SUNRISE,
                    DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(data.sunrise * 1000),
                    ),
                  );
                }
                break;
              case 2:
                {
                  return _swipeView(
                    SUN_SET,
                    GIF_SUNSET,
                    DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(data.sunset * 1000),
                    ),
                  );
                }
                break;
              case 3:
                {
                  return _swipeView(
                      HUMIDITY, GIF_HUMIDITY, '${data.humidity}%');
                }
                break;
              default:
                {
                  return _swipeView(
                      HUMIDITY, GIF_HUMIDITY, data.humidity.toStringAsFixed(2));
                }
            }
          },
          pagination: new SwiperPagination(
            margin: new EdgeInsets.all(5.0),
            builder: new DotSwiperPaginationBuilder(
              size: 5,
              activeSize: 5,
              color: pureWhite,
              activeColor: textBlack,
            ),
          ),
        ),
      ),
    );
  }

  _swipeView(String title, String gif, String data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: title,
          fontSize: 15,
          textColor: pureWhite,
        ),
        SizedBox(
          height: 70,
          width: 70,
          child: Image.asset(
            gif,
          ),
        ),
        AppText(
          text: data,
          textColor: pureWhite,
        ),
      ],
    );
  }

  _onOptionMenuItemSelected(LocationMenu item) {
    switch (item) {
      case LocationMenu.LOCATION_KUALA_LUMPUR:
        homeProvider.filterBy(CityList.cityList[0]);
        break;
      case LocationMenu.LOCATION_GEORGE_TOWN:
        homeProvider.filterBy(CityList.cityList[1]);
        break;
      case LocationMenu.LOCATION_JOHAR_BAHRU:
        homeProvider.filterBy(CityList.cityList[2]);
        break;

      case LocationMenu.LOCATION_ALL_CITY:
        homeProvider.otherCityOnClicked();
        break;

      case LocationMenu.LOCATION_USE_CURRENT:
        homeProvider.getUserLocation();
        break;
    }
  }

  _menuItemBuilder(String cityName, LocationMenu value) {
    return PopupMenuItem<LocationMenu>(
      value: value,
      child: AppText(
        text: cityName,
        textColor: colorPrimary,
      ),
    );
  }
}

