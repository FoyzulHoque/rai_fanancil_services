import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../controllers/income_result_controller.dart';

class IncomeSummaryScreen extends StatelessWidget {
  IncomeSummaryScreen({super.key});

  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  final IncomeResultController resultController =
  Get.find<IncomeResultController>();

  String _money(double v) {
    final s = v.toStringAsFixed(0);
    final chars = s.split('');
    final out = <String>[];
    for (int i = 0; i < chars.length; i++) {
      final posFromEnd = chars.length - i;
      out.add(chars[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) out.add(',');
    }
    return "\$${out.join()}";
  }

  String _percent(double v) => "${v.toStringAsFixed(2)}%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // Header (green)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.greenDip),
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
                          "Income Summary",
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
                    child: Obx(() {
                      final r = resultController.result.value;

                      if (r == null) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              "No result data found.",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }

                      final tax = r.taxBreakdown;
                      final payable = r.potentialTaxPayable;
                      final src = r.incomeSources;

                      // ✅ for chart scaling: keep same maxY as your UI (100000)
                      final double employment = src.employmentIncome;
                      final double rental = src.rentalIncome;
                      final double maxY = 100000;

                      return Column(
                        children: [
                          // Net Annual Income card (gradient like screenshot)
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
                                const Text(
                                  "Net Annual Income",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _money(r.netAnnualIncome),
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

                          // Gross Income + Tax Rate boxes row (✅ overflow fixed)
                          Row(
                            children: [
                              Expanded(
                                child: _SmallStatBox(
                                  title: "Gross Income",
                                  value: _money(r.grossAnnualIncome),
                                  borderColor: AppColors.greenDip,
                                  valueColor: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SmallStatBox(
                                  title: "Tax Rate",
                                  value: _percent(r.taxRatePercent),
                                  borderColor: AppColors.warning,
                                  valueColor: Colors.black87,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Tax Breakdown box (blue light background)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9EEF8),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Tax Breakdown",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _TaxRow(
                                  label: "Income Tax",
                                  value: "-${_money(tax.incomeTax)}",
                                ),
                                const SizedBox(height: 8),
                                _TaxRow(
                                  label: "Medicare Levy (2%)",
                                  value: "-${_money(tax.medicareLevy)}",
                                ),
                                const Divider(height: 18),
                                _TaxRow(
                                  label: "Total Tax",
                                  value: "-${_money(tax.totalTax)}",
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Potential Tax Payable box (pink background)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE7E7),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.info_outline,
                                        color: Colors.red, size: 18),
                                    SizedBox(width: 6),
                                    Text(
                                      "Potential Tax Payable",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _money(payable.totalPayable),
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _PayableRow(
                                  label: "Income Tax",
                                  value: _money(payable.incomeTax),
                                ),
                                const SizedBox(height: 4),
                                _PayableRow(
                                  label: "Medicare Levy (2%)",
                                  value: _money(payable.medicareLevy),
                                ),
                                const SizedBox(height: 4),
                                _PayableRow(
                                  label: "Effective Tax Rate",
                                  value: _percent(payable.effectiveTaxRate),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ✅ Income Sources card (matches screenshot)
                          Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Income Sources",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFE5E5E5),
                                          width: 1),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 140,
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: [
                                              // Y axis labels (same UI)
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: const [
                                                  Text("100000",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                          Colors.black38,
                                                          fontWeight:
                                                          FontWeight.w600)),
                                                  Text("75000",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                          Colors.black38,
                                                          fontWeight:
                                                          FontWeight.w600)),
                                                  Text("50000",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                          Colors.black38,
                                                          fontWeight:
                                                          FontWeight.w600)),
                                                  Text("25000",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                          Colors.black38,
                                                          fontWeight:
                                                          FontWeight.w600)),
                                                  Text("0",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                          Colors.black38,
                                                          fontWeight:
                                                          FontWeight.w600)),
                                                ],
                                              ),

                                              const SizedBox(width: 8),

                                              // Grid + Bars
                                              Expanded(
                                                child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    double barHeight(double v) {
                                                      final clamped =
                                                      v.clamp(0, maxY);
                                                      return (clamped / maxY) *
                                                          (constraints
                                                              .maxHeight);
                                                    }

                                                    return Stack(
                                                      children: [
                                                        // Grid lines (same UI)
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children:
                                                          List.generate(
                                                            5,
                                                                (_) => Container(
                                                              height: 1,
                                                              color: const Color(
                                                                  0xFFEFEFEF),
                                                            ),
                                                          ),
                                                        ),

                                                        // Bars (same UI)
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            children: [
                                                              _Bar(
                                                                height: barHeight(
                                                                    employment),
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                              _Bar(
                                                                height: barHeight(
                                                                    rental),
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                    0.75),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        // X labels (same UI)
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text(
                                              "Employment",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "Rental",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // legend + values (same UI, dynamic values)
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.circle,
                                              size: 8,
                                              color: AppColors.primary),
                                          SizedBox(width: 6),
                                          Text(
                                            "Employment Income",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _money(src.employmentIncome),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.circle,
                                              size: 8,
                                              color: AppColors.primary),
                                          SizedBox(width: 6),
                                          Text(
                                            "Rental Income",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _money(src.rentalIncome),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Export PDF button (outlined)
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
                                    width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Done button
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
}

// ---------- Widgets ----------

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
        border: Border.all(color: borderColor.withOpacity(0.55), width: 1.2),
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

class _TaxRow extends StatelessWidget {
  final String label;
  final String value;
  const _TaxRow({required this.label, required this.value});

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
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _PayableRow extends StatelessWidget {
  final String label;
  final String value;
  const _PayableRow({required this.label, required this.value});

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

class _Bar extends StatelessWidget {
  final double height;
  final Color color;

  const _Bar({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: height.clamp(0, 9999),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
