import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';

class BorrowingOverviewResultScreen extends StatelessWidget {
  BorrowingOverviewResultScreen({super.key});

  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  // ✅ demo values (replace with API later)
  final String capacityRange = "\$145,000 – \$230,000";
  final String statusLabel = "Weak";

  final double netWorth = 170000;
  final double dtiRatio = 66.4;

  final double assets = 450000;
  final double liabilities = 280000;

  final double totalPropertyValue = 650000;
  final double totalCurrentBorrowings = 520000;
  final double availableEquity = 130000;
  final double totalLvr = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header (blue)
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.primaryDife),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Borrowing Overview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  child: RepaintBoundary(
                    key: pageKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Estimated Borrowing Capacity (gradient)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.95),
                                AppColors.blue.withOpacity(0.85),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Estimated Borrowing Capacity",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFCDD2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      statusLabel,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFD32F2F),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                capacityRange,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Net Worth + DTI boxes
                        Row(
                          children: [
                            Expanded(
                              child: _SmallStatBox(
                                title: "Net Worth",
                                value: "\$${_money(netWorth)}",
                                borderColor: const Color(0xFF4CAF50),
                                valueColor: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SmallStatBox(
                                title: "Debt-to-Income Ratio",
                                value: "${dtiRatio.toStringAsFixed(1)}%",
                                borderColor: const Color(0xFFFFB74D),
                                valueColor: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // ✅ Assets vs Liabilities (chart card)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE6E6E6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Assets vs Liabilities",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 170,
                                  child: _AssetsLiabilitiesBarChart(
                                    assets: assets,
                                    liabilities: liabilities,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _LegendDot(
                                        color: const Color(0xFF0D6EAA)),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                      child: Text(
                                        "Assets",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$${_shortMoney(assets)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    _LegendDot(
                                        color: const Color(0xFF29B6F6)),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                      child: Text(
                                        "Liabilities",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$${_shortMoney(liabilities)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Property Portfolio Details (table-style)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE6E6E6)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Property Portfolio Details",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _TableRowLine(
                                label: "Total Property Value",
                                value: "\$${_money(totalPropertyValue)}",
                                valueColor: Colors.black87,
                              ),
                              const Divider(height: 12),
                              _TableRowLine(
                                label: "Total Current Borrowings",
                                value: "\$${_money(totalCurrentBorrowings)}",
                                valueColor: Colors.red,
                              ),
                              const Divider(height: 12),
                              _TableRowLine(
                                label: "Available Equity",
                                value: "\$${_money(availableEquity)}",
                                valueColor: const Color(0xFF00A651),
                              ),
                              const Divider(height: 12),
                              _TableRowLine(
                                label: "Total LVR",
                                value: "${totalLvr.toStringAsFixed(1)}%",
                                valueColor: const Color(0xFF00A651),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ✅ Export PDF (outlined)
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 50));
                              final imageBytes = await captureFullPage();
                              if (imageBytes != null) {
                                final pdfFile = await generatePdf(imageBytes);
                                await printPdf(pdfFile);
                              }
                            },
                            icon: const Icon(Icons.download,
                                color: Colors.black54, size: 18),
                            label: const Text(
                              "Export PDF",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.primary.withOpacity(0.35),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ✅ Done
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: const Text("Done"),
                          ),
                        ),

                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- helpers ----------------

  static String _money(num v) {
    final s = v.toStringAsFixed(0);
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(reg, (m) => ',');
  }

  static String _shortMoney(num v) {
    // 450000 -> 450k (matches screenshot)
    if (v >= 1000) {
      return "${(v / 1000).toStringAsFixed(0)}k";
    }
    return v.toStringAsFixed(0);
  }
}

// ---------------- UI pieces ----------------

class _SmallStatBox extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;
  final Color valueColor;

  const _SmallStatBox({
    required this.title,
    required this.value,
    required this.borderColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor.withOpacity(0.65), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  const _LegendDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _TableRowLine extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _TableRowLine({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black45,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _AssetsLiabilitiesBarChart extends StatelessWidget {
  final double assets;
  final double liabilities;

  const _AssetsLiabilitiesBarChart({
    required this.assets,
    required this.liabilities,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = (assets > liabilities ? assets : liabilities) * 1.2;

    return BarChart(
      BarChartData(
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 4,
          getDrawingHorizontalLine: (value) => FlLine(
            color: const Color(0xFFEDEDED),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(color: Color(0xFFE6E6E6)),
            bottom: BorderSide(color: Color(0xFFE6E6E6)),
            right: BorderSide(color: Colors.transparent),
            top: BorderSide(color: Colors.transparent),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 34,
              interval: maxY / 4,
              getTitlesWidget: (value, meta) {
                // show like 100000, 75000 etc (simple)
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final text = value.toInt() == 0 ? "Assets" : "Liabilities";
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: assets,
                width: 34,
                borderRadius: BorderRadius.circular(2),
                color: const Color(0xFF0D6EAA),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: liabilities,
                width: 34,
                borderRadius: BorderRadius.circular(2),
                color: const Color(0xFF29B6F6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
