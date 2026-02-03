import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';

class CashFlowResultScreen extends StatelessWidget {
  CashFlowResultScreen({super.key});

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
              // Top Bar
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.blue),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Cash Flow Results",
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
                      children: [
                        // Net Monthly Cashflow Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.blue.withOpacity(0.95),
                                AppColors.primary.withOpacity(0.80),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Net Monthly Cashflow",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "\$625",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Annual Increases Card
                        _CardBox(
                          title: "Annual Increases",
                          child: Column(
                            children: const [
                              _KVRow(label: "Rental increase per year", value: "2%"),
                              Divider(height: 18),
                              _KVRow(label: "Cash rate change", value: "0.25%"),
                              Divider(height: 18),
                              _KVRow(label: "Annual salary increase", value: "3%"),
                              Divider(height: 18),
                              _KVRow(label: "Expense inflation", value: "4%"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Asset & Liability Position Card
                        _CardBox(
                          title: "Asset & Liability Position",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),

                              // Bars section
                              _BarsPanel(
                                asset: 600000,
                                liability: 450000,
                                equity: 150000,
                              ),

                              const SizedBox(height: 14),

                              // Summary values
                              _detailRow("Property Value", "\$600,000", valueColor: Colors.black87),
                              const SizedBox(height: 6),
                              _detailRow("Total Loans", "\$450,000", valueColor: Colors.black87),
                              const SizedBox(height: 6),
                              _detailRow("Equity", "\$150,000", valueColor: AppColors.primary),
                              const SizedBox(height: 6),
                              _detailRow("LVR", "75.0%", valueColor: Colors.black87),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Export PDF Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await Future.delayed(const Duration(milliseconds: 50));
                              final imageBytes = await captureFullPage();
                              if (imageBytes != null) {
                                final pdfFile = await generatePdf(imageBytes);
                                await printPdf(pdfFile);
                              }
                            },
                            icon: const Icon(Icons.download, color: Colors.black54),
                            label: const Text(
                              "Export PDF",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primary.withOpacity(0.35), width: 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Done Button
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

  static Widget _detailRow(String label, String value, {Color valueColor = Colors.black87}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CardBox extends StatelessWidget {
  final String title;
  final Widget child;

  const _CardBox({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  final String label;
  final String value;

  const _KVRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BarsPanel extends StatelessWidget {
  final double asset;
  final double liability;
  final double equity;

  const _BarsPanel({
    required this.asset,
    required this.liability,
    required this.equity,
  });

  @override
  Widget build(BuildContext context) {
    final maxVal = [asset, liability, equity].reduce((a, b) => a > b ? a : b);
    double w(BuildContext c, double v) {
      final full = MediaQuery.of(c).size.width - 16 * 2 - 24; // padding/rough
      final ratio = maxVal == 0 ? 0 : (v / maxVal);
      return (full * 0.78) * ratio; // keep inside card nicely
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _barRow(context, "Asset", w(context, asset), AppColors.success),
        const SizedBox(height: 8),
        _barRow(context, "Liability", w(context, liability), AppColors.warning),
        const SizedBox(height: 8),
        _barRow(context, "Equity", w(context, equity), AppColors.primary),

        const SizedBox(height: 10),

        // Axis labels (simple like screenshot)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("\$0k", style: TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w600)),
            Text("\$150k", style: TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w600)),
            Text("\$300k", style: TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w600)),
            Text("\$450k", style: TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w600)),
            Text("\$600k", style: TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _barRow(BuildContext context, String label, double barWidth, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                height: 14,
                width: barWidth,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
