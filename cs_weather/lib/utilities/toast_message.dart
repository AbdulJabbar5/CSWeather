import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { SUCCESS, FAILED }

class AppMessage {

  static Color _backgroundColor = Colors.black87;
  static Color _textColor = Colors.white;

  static void toast(String message, {required ToastType toastType}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: _backgroundColor,
        textColor: _textColor,
        fontSize: 16.0);
  }
}