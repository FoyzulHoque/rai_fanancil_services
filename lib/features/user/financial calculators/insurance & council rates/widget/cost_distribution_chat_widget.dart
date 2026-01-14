import 'package:flutter/material.dart';
import 'dart:math' as math;

class CostDistributionChart extends StatelessWidget {
  final String title;
  final List<CostItem> items;
  final double chartSize;
  final double holeRadiusFactor; // 0.0 = full pie, 0.6–0.75 = nice donut

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

    // Calculate start angles
    double cumulative = 0;
    final segments = <Segment>[];
    for (final item in items) {
      final fraction = item.amount / total;
      final startAngle = cumulative * 2 * math.pi - math.pi / 2;
      final sweepAngle = fraction * 2 * math.pi;
      segments.add(Segment(
        color: item.color,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        label: item.label,
        amount: item.amount,
      ));
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
              // Optional center text (total or title)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    _formatAmount(total),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Legend
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: items.map((item) => _buildLegendRow(item)).toList(),
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
      return '''\$${(value / 1000).toStringAsFixed(0)}k''';
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
    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);

    // Draw segments
    for (final segment in segments) {
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        outerRect,
        segment.startAngle,
        segment.sweepAngle,
        true, // fill center (but will be cut by inner circle)
        paint,
      );
    }

    // Cut out the center hole
    final holePaint = Paint()
      ..color = Colors.white // or your background color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, innerRadius, holePaint);

    // Optional: thin border
    final borderPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, outerRadius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
