import 'package:flutter/material.dart';
import 'dart:math' as math;

class PaymentBreakdownChart extends StatelessWidget {
  final double principalAmount; // e.g. 450000
  final double interestAmount;  // e.g. 423000
  final double pieSize;         // diameter

  const PaymentBreakdownChart({
    super.key,
    required this.principalAmount,
    required this.interestAmount,
    this.pieSize = 220, // Adjusted for a better fit within the new container
  });

  @override
  Widget build(BuildContext context) {
    final total = principalAmount + interestAmount;
    if (total <= 0) return const SizedBox.shrink();

    final principalFraction = principalAmount / total;
    final principalAngle = principalFraction * 2 * math.pi;

    // Define the new colors from the image
    const principalColor = Color(0xFF00A98F); // Vibrant Green
    const interestColor = Color(0xFFF3A66B);  // Peach Orange
    const titleColor = Color(0xFF1A4A6A);     // Dark Navy Blue

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Payment Breakdown",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Principal: \$${(principalAmount / 1000).toStringAsFixed(0)}k",
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: principalColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: pieSize,
            height: pieSize,
            child: CustomPaint(
              painter: _PaymentPiePainter(
                principalAngle: principalAngle,
                principalColor: principalColor,
                interestColor: interestColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Interest: \$${(interestAmount / 1000).toStringAsFixed(0)}k",
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: interestColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentPiePainter extends CustomPainter {
  final double principalAngle;
  final Color principalColor;
  final Color interestColor;

  _PaymentPiePainter({
    required this.principalAngle,
    required this.principalColor,
    required this.interestColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Principal (Vibrant Green)
    final principalPaint = Paint()
      ..color = principalColor
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      rect,
      -math.pi / 2, // Start at the top
      principalAngle,
      true,
      principalPaint,
    );

    // Interest (Peach Orange)
    final interestPaint = Paint()
      ..color = interestColor
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      rect,
      -math.pi / 2 + principalAngle,
      2 * math.pi - principalAngle,
      true,
      interestPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
