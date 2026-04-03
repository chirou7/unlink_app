import 'package:flutter/material.dart';

class DefaultAvatarWidget extends StatelessWidget {
  final double size;

  const DefaultAvatarWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _AvatarPainter()),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Draw outer yellow background/border
    final outerBgPaint = Paint()
      ..color =
          const Color(0xFFFFD966) // Light yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, outerBgPaint);

    // 2. Draw inner dark grey circle (the main background of the avatar)
    final innerRadius = radius * 0.92;
    final innerBgPaint = Paint()
      ..color =
          const Color(0xFF555555) // Dark grey
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, innerBgPaint);

    // Clip to inner circle so the body doesn't draw outside
    canvas.save();
    Path clipPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: innerRadius));
    canvas.clipPath(clipPath);

    // 3. Draw body (yellow shirt)
    final bodyPaint = Paint()
      ..color =
          const Color(0xFFFFC107) // Yellow shirt
      ..style = PaintingStyle.fill;

    final bodyPath = Path();
    final bodyTop = center.dy + radius * 0.3;
    final bodyWidth = radius * 1.5;

    bodyPath.moveTo(center.dx - bodyWidth / 2, size.height);
    // Draw shoulders curving up to neck
    bodyPath.quadraticBezierTo(
      center.dx - bodyWidth / 2.2,
      bodyTop + radius * 0.2,
      center.dx,
      bodyTop,
    );
    bodyPath.quadraticBezierTo(
      center.dx + bodyWidth / 2.2,
      bodyTop + radius * 0.2,
      center.dx + bodyWidth / 2,
      size.height,
    );
    bodyPath.close();
    canvas.drawPath(bodyPath, bodyPaint);

    // 4. Draw neck (pink)
    final skinPaint = Paint()
      ..color =
          const Color(0xFFFBA8A5) // Pinkish skin
      ..style = PaintingStyle.fill;

    final neckWidth = radius * 0.35;
    final neckHeight = radius * 0.4;
    final neckRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + radius * 0.2),
      width: neckWidth,
      height: neckHeight,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(neckRect, Radius.circular(neckWidth / 4)),
      skinPaint,
    );

    // 5. Draw white collar
    final collarPaint = Paint()
      ..color =
          const Color(0xFFFFF3E0) // Off-white/light yellow collar
      ..style = PaintingStyle.fill;
    final collarRect = Rect.fromCenter(
      center: Offset(center.dx, bodyTop + radius * 0.05),
      width: neckWidth * 1.6,
      height: neckHeight * 0.5,
    );
    canvas.drawOval(collarRect, collarPaint);

    // 6. Draw face/head (pink)
    final faceCenter = Offset(center.dx, center.dy - radius * 0.15);
    final faceWidth = radius * 0.65;
    final faceHeight = radius * 0.85;

    final facePath = Path();
    // Start from bottom center of chin
    facePath.moveTo(faceCenter.dx, faceCenter.dy + faceHeight / 2);
    // Left jaw/cheek
    facePath.quadraticBezierTo(
      faceCenter.dx - faceWidth / 2,
      faceCenter.dy + faceHeight / 2,
      faceCenter.dx - faceWidth / 2,
      faceCenter.dy,
    );
    // Top of head
    facePath.quadraticBezierTo(
      faceCenter.dx - faceWidth / 2,
      faceCenter.dy - faceHeight / 2,
      faceCenter.dx,
      faceCenter.dy - faceHeight / 2,
    );
    // Right side of head
    facePath.quadraticBezierTo(
      faceCenter.dx + faceWidth / 2,
      faceCenter.dy - faceHeight / 2,
      faceCenter.dx + faceWidth / 2,
      faceCenter.dy,
    );
    // Right jaw/cheek
    facePath.quadraticBezierTo(
      faceCenter.dx + faceWidth / 2,
      faceCenter.dy + faceHeight / 2,
      faceCenter.dx,
      faceCenter.dy + faceHeight / 2,
    );
    canvas.drawPath(facePath, skinPaint);

    // Draw right ear
    final earCenter = Offset(
      faceCenter.dx + faceWidth * 0.45,
      faceCenter.dy + radius * 0.1,
    );
    canvas.drawCircle(earCenter, radius * 0.15, skinPaint);

    // 7. Draw hair (black, stylized wavy)
    final hairPaint = Paint()
      ..color =
          const Color(0xFF1A1A1A) // Almost black
      ..style = PaintingStyle.fill;

    final hairTopY = faceCenter.dy - faceHeight * 0.4;

    // Base hair shape (covers top of head)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(faceCenter.dx, hairTopY),
        width: faceWidth * 1.2,
        height: faceHeight * 0.6,
      ),
      hairPaint,
    );

    // Draw individual wavy hair tufts (circles/ovals)
    // Top tufts
    canvas.drawCircle(
      Offset(center.dx - radius * 0.1, hairTopY - radius * 0.2),
      radius * 0.2,
      hairPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.15, hairTopY - radius * 0.15),
      radius * 0.25,
      hairPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.35, hairTopY),
      radius * 0.2,
      hairPaint,
    );

    // Left side tufts
    canvas.drawCircle(
      Offset(center.dx - radius * 0.3, hairTopY + radius * 0.05),
      radius * 0.2,
      hairPaint,
    );
    canvas.drawCircle(
      Offset(center.dx - radius * 0.35, hairTopY + radius * 0.25),
      radius * 0.15,
      hairPaint,
    );

    // Right side tufts (above ear)
    canvas.drawCircle(
      Offset(center.dx + radius * 0.4, hairTopY + radius * 0.2),
      radius * 0.22,
      hairPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.5, hairTopY + radius * 0.35),
      radius * 0.18,
      hairPaint,
    );

    // Restore canvas (remove clip)
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
