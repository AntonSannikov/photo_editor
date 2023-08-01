import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  final Size size;
  final Color color;

  const DragHandle({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: DragHandlePainter(color),
    );
  }
}

class DragHandlePainter extends CustomPainter {
  final Color color;

  DragHandlePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();
    path.moveTo(width / 2, 0);
    path.quadraticBezierTo(0, height / 2, width / 2, height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DragHandlePainter oldDelegate) => false;
}
