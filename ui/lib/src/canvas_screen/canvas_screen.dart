import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel.dart';

sealed class CanvasScreenCondition {}

final class CanvasDefault extends CanvasScreenCondition {}

final class CanvasLoading extends CanvasScreenCondition {}

class CanvasScreen extends GScreen<CanvasScreenCondition> {
  CanvasScreen({
    super.key,
    required super.$screenCondition,
    super.onLifecycleStateChange$,
  });

  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends GScreenState<CanvasScreen, CanvasScreenCondition> {
  @override
  void onConditionChange(CanvasScreenCondition state) async {
    super.onConditionChange(state);

    switch (state) {
      case CanvasDefault _:
        break;
      case CanvasLoading _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Align(
            alignment: Alignment.centerRight,
            child: Text('CANVAS SCREEN'),
          )),
          Positioned(
            right: 0.0,
            child: SideToolsPanel(),
          ),
        ],
      ),
    );
  }
}
