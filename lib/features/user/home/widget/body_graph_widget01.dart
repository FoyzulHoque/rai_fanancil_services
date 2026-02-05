import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/themes/app_colors.dart';

class BodyGraphWidget01 extends StatelessWidget {
  const BodyGraphWidget01({
    super.key,
    required this.title,
    required this.monthlyData,
    this.lineColor = Colors.blue,
    this.fillOpacity = 0.25,
  });

  final String title;
  final List<Map<String, dynamic>> monthlyData;
  final Color lineColor;
  final double fillOpacity;

  @override
  Widget build(BuildContext context) {
    if (monthlyData.isEmpty) {
      return _cardShell(
        child: const Padding(
          padding: EdgeInsets.all(18),
          child: Center(child: Text("No data available")),
        ),
      );
    }

    final spots = monthlyData
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), (e.value['amount'] as num).toDouble()))
        .toList();

    final months = monthlyData.map<String>((e) => (e['month'] ?? '').toString()).toList();
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.15;

    return _cardShell(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // ✅ title + dropdown
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
                _miniDropdown(),
              ],
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 190,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxY / 4,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 9, color: Colors.black45),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= months.length) return const SizedBox();
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              months[i],
                              style: const TextStyle(fontSize: 9, color: Colors.black45),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (monthlyData.length - 1).toDouble(),
                  minY: 0,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      curveSmoothness: 0.35,
                      color: lineColor,
                      barWidth: 2.8,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            lineColor.withOpacity(fillOpacity),
                            lineColor.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: const LineTouchData(enabled: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniDropdown() {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "Daily",
          items: const [
            DropdownMenuItem(value: "Daily", child: Text("Daily")),
          ],
          onChanged: (_) {},
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          style: const TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _cardShell({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: child,
    );
  }
}
