import 'package:cs_weather/screens/home_page.dart';
import 'package:cs_weather/utilities/color_constants.dart';
import 'package:cs_weather/utilities/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:cs_weather/route/router.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'data/fav_city.dart';
import 'package:flutter/src/widgets/router.dart';

// initial starting point of our application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentPath = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentPath.path);
  Hive.openBox<FavCity>(BOX_NAME);
  Hive.registerAdapter(FavCityAdapter());
  runApp(CSWeather());
}

// root widget of our application
class CSWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: colorPrimaryDark));
    return MaterialApp(
      title: APP_NAME,
      initialRoute: ROUTE_HOME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: colorPrimary, fontFamily: 'Exo'),
      home: HomePage(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
