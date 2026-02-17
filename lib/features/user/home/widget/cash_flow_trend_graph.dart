import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../../core/themes/app_colors.dart';
import '../controller/cash_flow_trend_data_controller.dart';
import '../model/user_cash_flow_trend_modal.dart';

class CashFlowTrendGraph extends StatefulWidget {
  const CashFlowTrendGraph({super.key});

  @override
  State<CashFlowTrendGraph> createState() => _CashFlowTrendGraphState();
}

class _CashFlowTrendGraphState extends State<CashFlowTrendGraph> {
  late final CashFlowTrendController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CashFlowTrendController());
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = AppColors.primary;
    const double fillOpacity = 0.20;

    return Obx(() {
      final monthlyData = controller.cashFlowTrendData
          .map<Map<String, dynamic>>((Datum e) => {
        'month': e.date,
        'amount': e.value,
      })
          .toList();

      if (monthlyData.isEmpty) {
        return _cardShell(
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

      // ✅ safe maxY + safe interval (fix fl_chart crash)
      final maxSpotY =
      spots.fold<double>(0.0, (prev, s) => s.y > prev ? s.y : prev);

      final safeMaxY = maxSpotY <= 0 ? 1.0 : (maxSpotY * 1.15);
      final safeInterval = (safeMaxY / 4) <= 0 ? 1.0 : (safeMaxY / 4);

      return _cardShell(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Cashflow Trend",
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
                          reservedSize: 36,
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
    });
  }

  Widget _miniDropdown() {
    final controller = Get.find<CashFlowTrendController>();

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
              controller.cashFlowTrend(val);
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
