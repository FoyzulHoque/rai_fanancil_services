import 'package:flutter/material.dart';
import 'dart:math' as math;

class CostDistributionChart extends StatelessWidget {
  final String title;
  final List<CostItem> items;
  final double chartSize;
  final double holeRadiusFactor; // 0.0 = full pie, 0.6–0.75 = donut

  CostDistributionChart({
    super.key,
    this.title = "Cost Distribution",
    required this.items,
    this.chartSize = 280,
    this.holeRadiusFactor = 0.68,
  }) : assert(items.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final total = items.fold<double>(0, (sum, item) => sum + item.amount);
    if (total <= 0) return const SizedBox.shrink();

    // ✅ slice gap like your image
    const double gapRadians = 0.06;

    double cumulative = 0;
    final segments = <Segment>[];

    for (final item in items) {
      final fraction = item.amount / total;
      final baseStart = cumulative * 2 * math.pi - math.pi / 2;

      double sweep = fraction * 2 * math.pi;
      if (items.length > 1) {
        sweep = math.max(0.0, sweep - gapRadians);
      }

      segments.add(
        Segment(
          color: item.color,
          startAngle: baseStart + (items.length > 1 ? gapRadians / 2 : 0),
          sweepAngle: sweep,
          label: item.label,
          amount: item.amount,
        ),
      );

      cumulative += fraction;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: chartSize,
          height: chartSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(chartSize, chartSize),
                painter: _DonutChartPainter(
                  segments: segments,
                  holeRadiusFactor: holeRadiusFactor,
                ),
              ),

              // ✅ NO CENTER TEXT (so "Total $6k" will NEVER appear)
            ],
          ),
        ),

        const SizedBox(height: 28),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: items.map(_buildLegendRow).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendRow(CostItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Text(
            _formatAmount(item.amount),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    if (value >= 1000) {
      return '\$${(value / 1000).toStringAsFixed(0)}k';
    }
    return "\$${value.toStringAsFixed(0)}";
  }
}

// ────────────────────────────────────────────────

class CostItem {
  final String label;
  final double amount;
  final Color color;

  CostItem({
    required this.label,
    required this.amount,
    required this.color,
  });
}

class Segment {
  final Color color;
  final double startAngle;
  final double sweepAngle;
  final String label;
  final double amount;

  Segment({
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
    required this.label,
    required this.amount,
  });
}

class _DonutChartPainter extends CustomPainter {
  final List<Segment> segments;
  final double holeRadiusFactor;

  _DonutChartPainter({
    required this.segments,
    required this.holeRadiusFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * holeRadiusFactor;

    final outerRect = Rect.fromCircle(center: center, radius: outerRadius);

    for (final segment in segments) {
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        outerRect,
        segment.startAngle,
        segment.sweepAngle,
        true,
        paint,
      );
    }

    // cut out hole
    final holePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, innerRadius, holePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
