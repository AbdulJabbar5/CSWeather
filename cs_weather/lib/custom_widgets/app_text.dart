import 'package:flutter/material.dart';
import 'package:cs_weather/utilities/color_constants.dart';
import 'package:cs_weather/utilities/size_constants.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign alignment;

  const AppText({
    required this.text,
    this.textColor = textWhite,
    this.fontWeight = FontWeight.w400,
    this.fontSize = normalTextSize,
    this.alignment = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: alignment,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: 'Exo',
      ),
    );
  }
}