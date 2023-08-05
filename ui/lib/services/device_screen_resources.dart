import 'package:flutter/material.dart';

abstract class DeviceScreenResources {
  static late double screenWidth;
  static late double screenHeight;
  static late double statusBarHeight;
  static const double bottomBarHeight = 80.0;

  static void calculate(MediaQueryData mediaQuery) {
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    statusBarHeight = mediaQuery.viewPadding.top;
  }
}
