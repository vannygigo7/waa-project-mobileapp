import 'package:flutter/material.dart';

class AppNavigator {
  static void to(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void toAndReplace(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
