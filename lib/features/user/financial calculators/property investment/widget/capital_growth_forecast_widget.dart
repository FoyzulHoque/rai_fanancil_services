import 'package:flutter/material.dart';
import 'dart:math' as math;

class CapitalGrowthForecastChart extends StatelessWidget {
  final List<int> years; // e.g. [1, 3, 5, 7, 10]
  final List<double> propertyValues;
  final List<double> equityValues;
  final String title;
  final double? height;

  const CapitalGrowthForecastChart({
    super.key,
    required this.years,
    required this.propertyValues,
    required this.equityValues,
    this.title = "Capital Growth Forecast",
    this.height = 380,
  }) : assert(years.length == propertyValues.length &&
      years.length == equityValues.length);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 16, 32), // more left padding for Y labels
            child: _LineChartPainterWidget(
              years: years,
              propertyValues: propertyValues,
              equityValues: equityValues,
            ),
          ),
        ),
        _Legend(),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _LineChartPainterWidget extends StatelessWidget {
  final List<int> years;
  final List<double> propertyValues;
  final List<double> equityValues;

  const _LineChartPainterWidget({
    required this.years,
    required this.propertyValues,
    required this.equityValues,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GrowthChartPainter(
        years: years,
        propertyValues: propertyValues,
        equityValues: equityValues,
        theme: Theme.of(context),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _GrowthChartPainter extends CustomPainter {
  final List<int> years;
  final List<double> propertyValues;
  final List<double> equityValues;
  final ThemeData theme;

  _GrowthChartPainter({
    required this.years,
    required this.propertyValues,
    required this.equityValues,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final maxValue = [...propertyValues, ...equityValues]
        .reduce((a, b) => a > b ? a : b);
    if (maxValue == 0) return;

    final yRange = maxValue;

    // ─── Helper paints ───────────────────────────────────────
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..strokeWidth = 1;

    final dashVerticalPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.5;

    final labelStyle = TextStyle(
      color: theme.colorScheme.onSurface.withOpacity(0.7),
      fontSize: 12,
    );

    final yearLabelStyle = TextStyle(
      color: theme.colorScheme.onSurface,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );

    // ─── Horizontal grid lines + Y labels (LEFT side) ────────
    const steps = 5;
    for (int i = 0; i <= steps; i++) {
      final ratio = i / steps;
      final y = height * (1 - ratio);

      // Dashed horizontal line
      _drawDashedLine(
        canvas,
        Offset(0, y),
        Offset(width, y),
        dashWidth: 5,
        dashSpace: 3,
        paint: gridPaint,
      );

      // Y label on left
      final value = (ratio * yRange).roundToDouble();
      final textSpan = TextSpan(text: _format(value), style: labelStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
        ..layout();
      tp.paint(canvas, Offset(-tp.width - 8, y - tp.height / 2));
    }

    // ─── Dashed vertical line in middle ──────
    final midX = width / 2;
    _drawDashedLine(
      canvas,
      Offset(midX, 0),
      Offset(midX, height),
      dashWidth: 4,
      dashSpace: 4,
      paint: dashVerticalPaint,
    );

    // ─── Year labels ─────────────────────────────────────────
    final pointCount = years.length;
    for (int i = 0; i < pointCount; i++) {
      final x = _getX(i, width, pointCount);
      final textSpan = TextSpan(text: "Year${years[i]}", style: yearLabelStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
        ..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, height + 8));
    }

    // ─── Lines & Dots ────────────────────────────────────────
    final propPaint = Paint()
      ..color = const Color(0xFF1976D2)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final equityPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final propPath = Path();
    final equityPath = Path();

    for (int i = 0; i < pointCount; i++) {
      final x = _getX(i, width, pointCount);
      final yProp = _valueToY(propertyValues[i], height, yRange);
      final yEquity = _valueToY(equityValues[i], height, yRange);

      if (i == 0) {
        propPath.moveTo(x, yProp);
        equityPath.moveTo(x, yEquity);
      } else {
        propPath.lineTo(x, yProp);
        equityPath.lineTo(x, yEquity);
      }

      // Dots
      canvas.drawCircle(Offset(x, yProp), 5, Paint()..color = propPaint.color);
      canvas.drawCircle(Offset(x, yEquity), 5, Paint()..color = equityPaint.color);
    }

    canvas.drawPath(propPath, propPaint);
    canvas.drawPath(equityPath, equityPaint);
  }

  double _getX(int index, double width, int pointCount) {
    return (index / (pointCount - 1)) * width;
  }

  double _valueToY(double value, double height, double yRange) {
    return height * (1 - (value / yRange));
  }

  String _format(double value) {
    if (value >= 1000000) return "${(value / 1000000).toStringAsFixed(0)}M";
    if (value >= 1000) return "${(value / 1000).toStringAsFixed(0)}K";
    return value.toStringAsFixed(0);
  }

  void _drawDashedLine(
      Canvas canvas,
      Offset p1,
      Offset p2, {
        required double dashWidth,
        required double dashSpace,
        required Paint paint,
      }) {
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance == 0) return;

    final unitX = dx / distance;
    final unitY = dy / distance;

    double current = 0.0;
    while (current < distance) {
      final start = Offset(
        p1.dx + unitX * current,
        p1.dy + unitY * current,
      );

      current += dashWidth;
      final endDistance = math.min(current, distance);
      final end = Offset(
        p1.dx + unitX * endDistance,
        p1.dy + unitY * endDistance,
      );

      canvas.drawLine(start, end, paint);

      current += dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40,
        children: [
          _LegendItem(color: const Color(0xFF1976D2), label: "Property Value"),
          _LegendItem(color: const Color(0xFF4CAF50), label: "Your Equity"),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}