import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:good_lib/good_lib.dart';
import 'package:image/image.dart' as im;
import 'package:ui/src/canvas_screen/resources.dart';

class SidePanelToolButtonModel {
  final Enum id;
  final IconData icon;
  final bool isToggled;
  final VoidCallback? onTap;

  SidePanelToolButtonModel({
    required this.id,
    required this.icon,
    this.isToggled = false,
    this.onTap,
  });
}

class SidePanelToolButtonList extends StatefulWidget {
  final double splashRadius;
  final double iconSize;
  final String rippleShaderAsset;
  final List<SidePanelToolButtonModel> items;

  const SidePanelToolButtonList({
    Key? key,
    required this.splashRadius,
    required this.iconSize,
    required this.rippleShaderAsset,
    required this.items,
  }) : super(key: key);

  @override
  State<SidePanelToolButtonList> createState() => _SidePanelToolButtonListState();
}

class _SidePanelToolButtonListState extends State<SidePanelToolButtonList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.items
          .map((e) => SidePanelToolButton(
                model: e,
                size: widget.iconSize,
                splashRadius: widget.splashRadius,
              ))
          .toList(),
    );
  }
}

class SidePanelToolButton extends StatefulWidget {
  final SidePanelToolButtonModel model;
  final double size;
  final double splashRadius;

  const SidePanelToolButton({
    Key? key,
    required this.model,
    required this.splashRadius,
    required this.size,
  }) : super(key: key);

  @override
  State<SidePanelToolButton> createState() => _SidePanelToolButtonState();
}

typedef PixelFormat = ui.PixelFormat;
typedef ImFormat = im.Format;

class _SidePanelToolButtonState extends State<SidePanelToolButton> with WidgetResourcesMixin<SidePanelToolButton, SideToolsPanelResources> {
  final key = GlobalKey();
  final frameRate = 1000 ~/ 60;
  final animationDuration = 1;
  ui.FragmentProgram? rippleShaderProgram;
  ui.Image? snapshot;

  Timer? timer;
  double time = 0.0;

  final utf8Decoder = const Utf8Decoder();

  Future<void> _getSnapshot() async {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      RenderRepaintBoundary box = keyContext.findRenderObject() as RenderRepaintBoundary;
      snapshot = box.toImageSync();
      rippleShaderProgram = await ui.FragmentProgram.fromAsset(r.barrelDistortionShaderAsset);
      animateSplash();
    }
  }

  void animateSplash() {
    timer = Timer.periodic(Duration(milliseconds: frameRate), (timer) {
      if (time >= animationDuration) {
        time = 0.0;
        timer.cancel();
        setState(() {
          snapshot = null;
        });
      } else {
        setState(() {
          time += 1 / 60;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getSnapshot,
      child: (snapshot == null)
          ? RepaintBoundary(
              key: key,
              child: Icon(
                widget.model.icon,
                size: 32,
              ),
            )
          : CustomPaint(
              painter: ShaderPainter(
                shaderProgram: rippleShaderProgram!,
                widgetSnapshot: snapshot!,
                timeMs: time,
              ),
              child: Container(
                width: 32,
                height: 32,
                color: Colors.transparent,
              ),
            ),
    );
  }
}

class ShaderPainter extends CustomPainter {
  final ui.FragmentProgram shaderProgram;
  final ui.Image widgetSnapshot;
  final double timeMs;

  ShaderPainter({
    required this.shaderProgram,
    required this.widgetSnapshot,
    required this.timeMs,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shader = shaderProgram.fragmentShader();
    // uSize
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    // uTime
    shader.setFloat(2, timeMs);
    // uTexture
    shader.setImageSampler(0, widgetSnapshot);
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
