import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../controller/suburb_profile_controller.dart';

class SuburbProfileScreen extends StatelessWidget {
  SuburbProfileScreen({super.key});

  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  // ✅ Controller
  final SuburbProfileController controller = Get.put(SuburbProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header (teal)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.infoLightMore),
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
                          "Suburb Profile",
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
                    child: Obx(() {
                      final showResult = controller.showResult.value;
                      final res = controller.profile.value;
                      final d = res?.data;

                      final metrics = d?.suburbMetrics;
                      final mp = d?.marketPerformance;
                      final risk = d?.liveabilityRisk;

                      final medianPriceNum = metrics?.medianPrice ?? 0;
                      final rentalYield = metrics?.rentalYield ?? 0;
                      final growth10y = metrics?.growth10Y ?? 0;

                      final bool tenYear = controller.isTenYear.value;

                      final series = tenYear
                          ? (mp?.tenYear ?? const [])
                          : (mp?.fiveYear ?? const []);

                      final years = <int>[];
                      final marketSeriesK = <double>[];
                      for (final p in series) {
                        final y = p.year;
                        final v = p.value;
                        if (y == null || v == null) continue;
                        years.add(y);
                        marketSeriesK.add(v / 1000.0); // chart uses $k
                      }

                      final school = risk?.schoolRanking ?? "N/A";
                      final crime = risk?.crimeLevel ?? "N/A";
                      final infra = risk?.infrastructureSpend ?? "N/A";

                      final error = controller.errorMessage.value.trim();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Postcode input card
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFFBEE3F4)),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Postcode",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomInputField(
                                  controller: controller.postcodeController,
                                  keyboardType: TextInputType.number,
                                  hintText: "Type postcode to get result",
                                ),
                                if (error.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    error,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // ✅ everything below only after Calculate success
                          if (showResult) ...[
                            const SizedBox(height: 12),

                            // ✅ 3 stat boxes
                            Row(
                              children: [
                                Expanded(
                                  child: _StatBox(
                                    title: "Median Price",
                                    value: _medianPriceK(medianPriceNum),
                                    borderColor: const Color(0xFF4CAF50),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatBox(
                                    title: "Rental Yield",
                                    value: "${rentalYield.toStringAsFixed(1)}%",
                                    borderColor: const Color(0xFFFFB74D),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatBox(
                                    title: "10Y Growth",
                                    value: "${growth10y.toStringAsFixed(1)}%",
                                    borderColor: const Color(0xFF42A5F5),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // ✅ Market Performance card with segmented buttons
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFFE6E6E6)),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Market Performance",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller.setToggle(false),
                                        child: _MiniToggle(
                                            active: !tenYear, label: "5Y"),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller.setToggle(true),
                                        child: _MiniToggle(
                                            active: tenYear, label: "10Y"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: 190,
                                    child: _MarketLineChart(
                                      seriesK: marketSeriesK.isEmpty
                                          ? const [0]
                                          : marketSeriesK,
                                      years: years.isEmpty ? const [0] : years,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // ✅ Liveability & Risk
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFFE6E6E6)),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Liveability & Risk",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _RiskRow(
                                    icon: Icons.school_outlined,
                                    label: "School Ranking",
                                    tagText: school,
                                    tagColor: const Color(0xFF00A651),
                                  ),
                                  const SizedBox(height: 10),
                                  _RiskRow(
                                    icon: Icons.security_outlined,
                                    label: "Crime Level",
                                    tagText: crime,
                                    tagColor: const Color(0xFFD32F2F),
                                  ),
                                  const SizedBox(height: 10),
                                  _RiskRow(
                                    icon: Icons.apartment_outlined,
                                    label: "Infrastructure Spend",
                                    tagText: infra,
                                    tagColor: const Color(0xFF29B6F6),
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
                          ],

                          const SizedBox(height: 14),

                          // ✅ Bottom button (Calculate first, then Done)
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () async {
                                if (!controller.showResult.value) {
                                  await controller.calculate();
                                } else {
                                  navbarController.financialCalculatorsScreen();
                                  Get.back();
                                }
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
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : Text(
                                controller.showResult.value
                                    ? "Done"
                                    : "Calculate",
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ format: medianPrice -> "$1250k"
  static String _medianPriceK(double v) {
    final k = (v / 1000.0);
    return "\$${k.toStringAsFixed(0)}k";
  }
}

// ---------------- UI widgets (UNCHANGED) ----------------

class _StatBox extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;

  const _StatBox({
    required this.title,
    required this.value,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor.withOpacity(0.65), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                  fontSize: 10,
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
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

class _MiniToggle extends StatelessWidget {
  final bool active;
  final String label;

  const _MiniToggle({required this.active, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 46,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: active ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}

class _RiskRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String tagText;
  final Color tagColor;

  const _RiskRow({
    required this.icon,
    required this.label,
    required this.tagText,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tagColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            tagText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: tagColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _MarketLineChart extends StatelessWidget {
  final List<double> seriesK; // values in thousands
  final List<int> years;

  const _MarketLineChart({
    required this.seriesK,
    required this.years,
  });

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (int i = 0; i < seriesK.length; i++) {
      spots.add(FlSpot(i.toDouble(), seriesK[i]));
    }

    final maxV = seriesK.reduce((a, b) => a > b ? a : b);
    final minV = seriesK.reduce((a, b) => a < b ? a : b);

    final maxY = (maxV == 0 ? 1 : maxV) * 1.15;
    final minY = (minV == 0 ? 0 : minV) * 0.85;

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: const Color(0xFFEDEDED),
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: const Color(0xFFF3F3F3),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (value, meta) {
                final v = value.toStringAsFixed(0);
                return Text(
                  "\$${v}k",
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= years.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    years[idx].toString(),
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
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            barWidth: 2,
            color: const Color(0xFF1976D2),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 3,
                color: const Color(0xFF1976D2),
                strokeWidth: 0,
              ),
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
