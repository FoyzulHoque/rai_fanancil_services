import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IncomeTaxOverviewChart extends StatelessWidget {
  const IncomeTaxOverviewChart({
    super.key,
    required this.grossIncome,
    required this.deductions,
    required this.taxableIncome,
    required this.taxPayable,
    required this.netAfterTax,
    this.barWidth = 38,
    this.maxY = 600000,
  });

  final double grossIncome;
  final double deductions;
  final double taxableIncome;
  final double taxPayable;
  final double netAfterTax;

  final double barWidth;
  final double maxY;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        const Text(
          "Income & Tax Overview",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),

        const SizedBox(height: 24),

        // Chart
        SizedBox(
          height: 320,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              minY: 0,
              titlesData: _buildTitles(),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 150000,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                ),
              ),
              barGroups: _buildBarGroups(),
              barTouchData: BarTouchData(enabled: false),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // X-axis labels (alternative style)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _LabelText("Gross\nIncome"),
              _LabelText("Deductions"),
              _LabelText("Taxable\nIncome"),
              _LabelText("Tax\nPayable"),
              _LabelText("Net After\nTax"),
            ],
          ),
        ),
      ],
    );
  }

  FlTitlesData _buildTitles() {
    return FlTitlesData(
      show: true,
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false), // we use custom labels below
      ),
      leftTitles: AxisTitles(
        axisNameWidget: const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "Amount",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 48,
          interval: 150000,
          getTitlesWidget: (value, meta) {
            final label = value == 0
                ? '\$0'
                : value >= 1000000
                ? '\$${(value / 1000).toStringAsFixed(0)}k'
                : '\$${(value / 1000).toStringAsFixed(0)}k';
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return [
      _makeBarGroup(0, grossIncome),
      _makeBarGroup(1, deductions),
      _makeBarGroup(2, taxableIncome),
      _makeBarGroup(3, taxPayable),
      _makeBarGroup(4, netAfterTax),
    ];
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blue.shade700,
          width: barWidth,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }
}

class _LabelText extends StatelessWidget {
  const _LabelText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade800,
        height: 1.3,
      ),
    );
  }
}