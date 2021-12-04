import 'package:flutter/material.dart';

// initial starting point of our application
void main() async {
  runApp(CSWeather());
}

// root widget of our application
class CSWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('CSWeather'),
          backgroundColor: Colors.amberAccent.shade200,
          centerTitle: false,
        ),
      ),
    );
  }
}
