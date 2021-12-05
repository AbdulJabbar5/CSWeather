import 'package:flutter/material.dart';
import 'package:cs_weather/providers/home_provider.dart';
import 'package:cs_weather/custom_widgets/app_text.dart';

class LoadingFailedWidget extends StatelessWidget {
  final HomeProvider homeProvider;

  const LoadingFailedWidget({
    required this.homeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        child: AppText(text: 'Loading weather failed try again!'),
        onPressed: () {
          homeProvider.filterBy(homeProvider.searchCity);
        },
      ),
    );
  }
}