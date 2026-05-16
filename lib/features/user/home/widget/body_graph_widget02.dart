import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

import '../controller/user_property_value_controller.dart';
import '../model/user_property_value_trend_modal.dart';

class PropertyValueGrowthChart extends StatelessWidget {
  const PropertyValueGrowthChart({
    super.key,
    this.lineColor = AppColors.secondaryColors,
    this.dotOuterColor = const Color(0xFF90D8D8),
    this.dotInnerColor = AppColors.primary,
  });

  final Color lineColor;
  final Color dotOuterColor;
  final Color dotInnerColor;

  @override
  Widget build(BuildContext context) {
    // ✅ register once (won't recreate on rebuild)
    final UserPropertyValueController controller =
    Get.isRegistered<UserPropertyValueController>()
        ? Get.find<UserPropertyValueController>()
        : Get.put(UserPropertyValueController());

    return Obx(() {
      // ✅ map controller data to your existing monthlyData structure
      final monthlyData = controller.propertyValue
          .map<Map<String, dynamic>>((UserPropertyValueDetum e) => {
        'month': e.date ?? '',
        'amount': (e.value ?? 0.0), // null-safe
      })
          .toList();

      if (monthlyData.isEmpty) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: const Color(0xFFE6E6E6)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Center(child: Text("No data available")),
          ),
        );
      }

      // ✅ handle null/0 safely
      final spots = monthlyData
          .asMap()
          .entries
          .map((e) => FlSpot(
        e.key.toDouble(),
        ((e.value['amount'] as num?)?.toDouble() ?? 0.0),
      ))
          .toList();

      final months = monthlyData
          .map<String>((e) => (e['month'] ?? '').toString())
          .toList();

      // ✅ FIX: prevent fl_chart crash when all values are 0
      final maxSpotY =
      spots.fold<double>(0.0, (prev, s) => s.y > prev ? s.y : prev);

      final safeMaxY = maxSpotY <= 0 ? 1.0 : (maxSpotY * 1.15);
      final safeInterval = (safeMaxY / 4) <= 0 ? 1.0 : (safeMaxY / 4);

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Property Value Growth",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  _miniDropdown(controller),
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
                      horizontalInterval: safeInterval, // ✅ never 0
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: Colors.grey.shade200,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 44,
                          getTitlesWidget: (value, meta) => Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final i = value.toInt();
                            if (i < 0 || i >= months.length) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                months[i],
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.black45,
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
                    maxY: safeMaxY, // ✅ never 0
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.35,
                        color: lineColor,
                        barWidth: 2.8,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                                radius: 5.5,
                                color: dotInnerColor,
                                strokeWidth: 2.5,
                                strokeColor: dotOuterColor,
                              ),
                        ),
                        belowBarData: BarAreaData(show: false),
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
    });
  }

  Widget _miniDropdown(UserPropertyValueController controller) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() {
          return DropdownButton<String>(
            value: controller.selectedTrendType.value,
            items: const [
              DropdownMenuItem(value: "daily", child: Text("Daily")),
              DropdownMenuItem(value: "weekly", child: Text("Weekly")),
              DropdownMenuItem(value: "monthly", child: Text("Monthly")),
              DropdownMenuItem(value: "yearly", child: Text("Yearly")),
            ],
            onChanged: (val) {
              if (val == null) return;
              controller.selectedTrendType.value = val;
              controller.userPropertyValue(val); // ✅ correct API call
            },
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          );
        }),
      ),
    );
  }
}
