import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel/side_tools_panel.dart';

sealed class CanvasScreenState {}

final class CanvasDefault extends CanvasScreenState {}

final class CanvasLoading extends CanvasScreenState {}

class CanvasScreen extends GScreen<CanvasScreenState> {
  const CanvasScreen({
    super.key,
    required super.screenController,
  });

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends GScreenState<CanvasScreen, CanvasScreenState> {
  @override
  void onScreenStateChange(CanvasScreenState state) async {
    switch (state) {
      case CanvasDefault _:
        break;
      case CanvasLoading _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                Text('CANVAS SCREEN'),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: SideToolsPanel(),
        ),
      ],
    );
  }
}
