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
    if (totalAmount <= 0) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ✅ Donut Chart (NO center text)
        SizedBox(
          height: 220,
          width: 220,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {},
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0, // no gap between sections (like screenshot)
              centerSpaceRadius: 72, // donut hole size (tune to match)
              sections: _showingSections(),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ✅ Legend (dot + label + value) like screenshot
        ...items.map(_buildLegendRow).toList(),
      ],
    );
  }

  List<PieChartSectionData> _showingSections() {
    return items.map((item) {
      return PieChartSectionData(
        color: item.color,
        value: item.value,
        title: '', // ✅ remove % text from slices (clean ring like screenshot)
        radius: 56, // ring thickness/size
      );
    }).toList();
  }

  Widget _buildLegendRow(ChartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '\$${_money(item.value)}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _money(num v) {
    final s = v.toStringAsFixed(0);
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(reg, (m) => ',');
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
