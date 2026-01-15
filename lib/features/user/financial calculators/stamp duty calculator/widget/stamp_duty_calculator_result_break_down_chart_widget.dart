import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StampDutyCalculatorResultBreakDownChartWidget extends StatelessWidget {
  final double totalAmount;
  final List<ChartItem> items;

  const StampDutyCalculatorResultBreakDownChartWidget({
    super.key,
    required this.totalAmount,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Donut Chart
        SizedBox(
          height: 220,
          width: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      // You can add tooltip / highlight logic here if needed
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 70, // → donut hole size
                  sections: showingSections(),
                ),
              ),

              // Center Text (Total Amount)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$${totalAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Legend
        ...items.map((item) => _buildLegendRow(item)).toList(),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return items.map((item) {
      final percentage = (item.value / totalAmount) * 100;

      return PieChartSectionData(
        color: item.color,
        value: item.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
        ),
      );
    }).toList();
  }

  Widget _buildLegendRow(ChartItem item) {
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
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '\$${item.value.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Data model
class ChartItem {
  final String label;
  final double value;
  final Color color;

  ChartItem({
    required this.label,
    required this.value,
    required this.color,
  });
}