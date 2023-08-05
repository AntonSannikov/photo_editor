import 'package:flutter/material.dart';
import 'package:ui/services/device_screen_resources.dart';
import 'package:ui/src/canvas_screen/resources.dart';

abstract class ScreenResourcesCalculator {
  static void calculate(BuildContext ctx) {
    DeviceScreenResources.calculate(MediaQuery.of(ctx));
    SideToolsPanelResources.calculate(
        screenWidth: DeviceScreenResources.screenWidth,
        screenHeight: DeviceScreenResources.screenHeight,
        statusBarHeight: DeviceScreenResources.statusBarHeight,
        bottomBarHeight: DeviceScreenResources.bottomBarHeight);
  }
}
