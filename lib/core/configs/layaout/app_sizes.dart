import 'package:flutter/material.dart';

class AppSizes {
  static double getMaxHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getMaxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}