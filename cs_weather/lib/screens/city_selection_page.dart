import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:cs_weather/data/fav_city.dart';
import 'package:cs_weather/providers/city_selection_provider.dart';
import 'package:cs_weather/custom_widgets/app_text.dart';
import 'package:cs_weather/utilities/string_constants.dart';
import 'package:cs_weather/utilities/toast_message.dart';
import 'package:cs_weather/screens/city_selection_body_widget.dart';

import 'city_selection_body_widget.dart';

class CitySelectionPage extends StatefulWidget {
  @override
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CitySelectionProvider>(
      create: (BuildContext context) => CitySelectionProvider(context),
      child: Consumer<CitySelectionProvider>(
        builder:
            (BuildContext context, CitySelectionProvider value, Widget child) {
          return ModalProgressHUD(
            inAsyncCall: value.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: AppText(text: CITY_SELECTION_TITLE),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      value.favCityBox != null && value.favCityBox!.length > 0
                          ? showSearch(
                        context: context,
                        delegate: SearchCityDelegate(value),
                      )
                          : Container();
                    },
                  ),
                ],
              ),
              body: CityBody(
                provider: value,
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchCityDelegate extends SearchDelegate {
  final CitySelectionProvider provider;
  List<FavCity> searchCityList = [];
  List<FavCity> favList = [];

  SearchCityDelegate(this.provider) {
    ///sorting
    final keyList = provider.favCityBox!.keys.toList();
    keyList.forEach((key) {
      searchCityList.add(provider.favCityBox!.get(key));
    });
    searchCityList.sort(
            (a, b) => b.isFavourite.toString().compareTo(a.isFavourite.toString()));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _tempList = query.isEmpty
        ? searchCityList
        : searchCityList
        .where((element) =>
        element.city.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _tempList.length,
      itemBuilder: (BuildContext context, int position) {
        FavCity favCity = _tempList[position];
        return ListTile(
            onTap: () {
              favCity.isFavourite = !favCity.isFavourite;
              provider.addToHive(favCity);
              close(context, null);
              showResults(context);
            },
            title: Text(_tempList[position].city),
            trailing: IconButton(
              onPressed: () {
                AppMessage.toast(favCity.isFavourite
                    ? "Favourite removed"
                    : "Favourite added", toastType: ToastType.SUCCESS);
                favCity.isFavourite = !favCity.isFavourite;
                provider.addToHive(favCity);
                close(context, null);
              },
              icon: Icon(
                Icons.favorite_border,
                color: favCity.isFavourite ? Colors.green : Colors.grey,
              ),
            ));
      },
    );
  }
}