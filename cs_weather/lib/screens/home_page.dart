import 'package:cs_weather/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'home_widget_heart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeWidget _homeWidget;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => HomeProvider(context),
      child: Consumer<HomeProvider>(
        builder:
            (BuildContext context, HomeProvider homeProvider, Widget child) {
          _homeWidget = HomeWidget(homeProvider,context);
          return ModalProgressHUD(
            inAsyncCall: homeProvider.isLoading,
            child: Scaffold(
              appBar: _homeWidget.appBar(),
              body: _homeWidget.homeBody(),
            ),
          );
        },
      ),
    );
  }
}
