import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeWidget _homeWidget;

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
