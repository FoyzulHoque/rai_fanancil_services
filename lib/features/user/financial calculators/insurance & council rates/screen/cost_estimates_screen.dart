import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../widget/cost_distribution_chat_widget.dart';

class CostEstimatesScreen extends StatelessWidget {
  CostEstimatesScreen({super.key});

  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.lightBlueSolid),
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
                          "Cost Estimates",
                          style: TextStyle(
                            color: AppColors.white,
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
                        // ✅ Total Annual Costs
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
                            children: const [
                              Text(
                                "Total Annual Costs",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "\$5,880",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Cost Distribution (chart + legend)
                        Card(
                          elevation: 2,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: const BorderSide(color: Color(0xFFE6E6E6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: CostDistributionChart(
                              title: "Cost Distribution",
                              chartSize: 240,
                              holeRadiusFactor: 0.70,
                              items: [
                                CostItem(
                                  label: "Building Insurance",
                                  amount: 1850,
                                  color: const Color(0xFF1976D2),
                                ),
                                CostItem(
                                  label: "Council Rates",
                                  amount: 1920,
                                  color: const Color(0xFF4CAF50),
                                ),
                                CostItem(
                                  label: "Water Charges",
                                  amount: 980,
                                  color: const Color(0xFF03A9F4),
                                ),
                                CostItem(
                                  label: "Contents Insurance",
                                  amount: 650,
                                  color: const Color(0xFF9C27B0),
                                ),
                                CostItem(
                                  label: "Landlord Insurance",
                                  amount: 480,
                                  color: const Color(0xFFFF9800),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Detailed Breakdown
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9EEF8),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Detailed Breakdown",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              _LineRow(label: "Annual Total", value: "\$5,880"),
                              SizedBox(height: 6),
                              _LineRow(label: "Monthly Payment", value: "\$490"),
                              SizedBox(height: 6),
                              _LineRow(label: "Weekly Payment", value: "\$113"),
                              SizedBox(height: 6),
                              _LineRow(label: "Daily Cost", value: "\$16"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ✅ Export PDF
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
                                color: Colors.black54),
                            label: const Text(
                              "Export PDF",
                              style: TextStyle(
                                fontSize: 14,
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
                              navbarController.financialCalculatorsScreen();
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
                                fontSize: 14,
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
}

class _LineRow extends StatelessWidget {
  final String label;
  final String value;
  const _LineRow({required this.label, required this.value});

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
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
