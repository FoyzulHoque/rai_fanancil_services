import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class PropertyValueGrowthChart extends StatelessWidget {
  const PropertyValueGrowthChart({
    super.key,
    required this.title,
    required this.monthlyData,
    this.lineColor = const Color(0xFF2196F3), // হালকা নীল লাইন
    this.dotOuterColor = const Color(0xFF1976D2), // ডটের বাইরের রিং
    this.dotInnerColor = Colors.white, // ডটের ভিতর সাদা
  });

  final String title;
  final List<Map<String, dynamic>> monthlyData;
  final Color lineColor;
  final Color dotOuterColor;
  final Color dotInnerColor;

  @override
  Widget build(BuildContext context) {
    if (monthlyData.isEmpty) {
      return Card(
        elevation: 4,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text("No data available")),
        ),
      );
    }

    final List<FlSpot> spots = monthlyData
        .asMap()
        .entries
        .map(
          (entry) => FlSpot(
            entry.key.toDouble(),
            (entry.value['amount'] as num).toDouble(),
          ),
        )
        .toList();

    final List<String> months = monthlyData
        .map<String>((data) => data['month'] as String)
        .toList();

    // Y-axis এর সর্বোচ্চ ভ্যালু + প্যাডিং যাতে লাইন উপরে না লাগে
    final double maxY =
        spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) * 1.1;

    return Card(
      elevation: 4,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 280, // একটু বেশি উচ্চতা যাতে ভালো দেখায়
              child: LineChart(
                LineChartData(
                  // হালকা গ্রিড লাইন (ডটেড)
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxY / 4,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                      dashArray: [8, 8],
                    ),
                  ),
                  titlesData: FlTitlesData(
                    // বামে Y-axis লেবেল (বড় সংখ্যা সুন্দর ফরম্যাটে)
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 70,
                        interval: maxY / 4,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _formatLargeNumber(value.toInt()),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    // নিচে মাসের নাম
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 3,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= months.length)
                            return const Text('');
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              months[index],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
                      barWidth: 3,
                      isStrokeCapRound: true,
                      // ডটগুলো visible + white inner circle সাথে blue outer ring
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 7,
                              color: dotInnerColor,
                              strokeWidth: 3.5,
                              strokeColor: dotOuterColor,
                            ),
                      ),
                      belowBarData: BarAreaData(show: false), // কোনো ফিল নেই
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) =>
                          Colors.blueAccent.withOpacity(0.8),
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((touchedSpot) {
                          return LineTooltipItem(
                            _formatLargeNumber(touchedSpot.y.toInt()),
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // বড় সংখ্যা সুন্দর করে ফরম্যাট করা (যেমন 1000000 → 1000000)
  String _formatLargeNumber(int value) {
    if (value >= 1000000) {
      return '${value ~/ 1000000}000000';
    } else if (value >= 1000) {
      return '${value ~/ 1000}000';
    }
    return value.toString();
  }
}
