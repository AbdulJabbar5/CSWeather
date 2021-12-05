import 'package:flutter/material.dart';
import 'package:cs_weather/custom_widgets/app_text.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: this.label,
          fontSize: 10,
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null
            ? Icon(
          iconData,
          size: 20,
        )
            : Container(),
        SizedBox(
          height: 10,
        ),
        AppText(
          text:this.value,
          fontSize: 10,
        ),
      ],
    );
  }
}