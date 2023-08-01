import 'package:flutter/material.dart';

abstract class SideToolsPanelResources {
  static late final double panelWidth;
  static late final double panelHeight;
  static late final double panelWidthOffset;
  static late final double dragAreaHeight;
  static late final double dragHandleWidth;
  static late final double dragHandleHeight;
  static late final double dragAreaTopPos;
  static late final double dragHandleTopPos;
  static late final double dragHandleRightPos;
  static late final double panelDragAnimationDxOffsetBound;
  static late final double closedPanelDxOffset;
  static const double dragVelocity = 1.0;

  static void calculate({
    required double screenWidth,
    required double screenHeight,
    required double statusBarHeight,
    required double bottomBarHeight,
  }) {
    panelWidth = screenWidth / 5;
    panelHeight = screenHeight;
    panelWidthOffset = panelWidth / 4;
    dragAreaHeight = screenHeight / 7.3;
    dragHandleWidth = screenWidth / 12;
    dragHandleHeight = screenHeight / 12;
    final double freeScreenSpace = screenHeight - statusBarHeight - kToolbarHeight - bottomBarHeight;
    dragAreaTopPos = (freeScreenSpace - dragAreaHeight) / 2;
    dragHandleTopPos = (freeScreenSpace - dragHandleHeight) / 2;
    dragHandleRightPos = panelWidth - panelWidthOffset - dragHandleWidth / 2;
    panelDragAnimationDxOffsetBound = (panelWidth - panelWidthOffset) / 3;
    closedPanelDxOffset = panelWidth - panelWidthOffset - 2.0;
  }
}
