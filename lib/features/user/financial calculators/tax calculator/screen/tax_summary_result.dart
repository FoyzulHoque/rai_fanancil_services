import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../widget/income_&_tax_overview_widget.dart';

class TaxSummaryResult extends StatelessWidget {
  TaxSummaryResult({super.key});

  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  // demo values
  final double totalTaxPayable = 153741;
  final double netProfitAfterTax = 356259;

  final double incomeTax = 152800;
  final double investmentTax = 938;
  final double landTax = 2;

  // Detailed Breakdown
  final double grossIncome = 510000;
  final double deductibleExpenses = 111515;
  final double taxableIncome = 404741;
  final double taxRateApplied = 37.98;

  // Negative Gearing Benefit
  final double rentalIncome = 35000;
  final double propertyExpenses = 45000;
  final double depreciation = 8500;
  final double propertyLoss = 18500;
  final double taxBenefit = 6013;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // Header (teal)
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
                          "Tax Summary",
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
                        // Top summary card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFBEE3F4)),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Total Tax Payable",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "\$${_money(totalTaxPayable)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Net Profit After Tax  \$${_money(netProfitAfterTax)}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 18),
                              _miniRow("Income Tax", "\$${_money(incomeTax)}"),
                              const SizedBox(height: 10),
                              _miniRow("Investment Tax", "\$${_money(investmentTax)}"),
                              const SizedBox(height: 10),
                              _miniRow("Land Tax", "\$${_money(landTax)}"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Chart card (FIXED height-safe)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE6E6E6)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Income & Tax Overview",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              // The chart widget is already height constrained internally
                            ],
                          ),
                        ),

                        // Put chart OUTSIDE const block to pass values
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: IncomeTaxOverviewChart(
                            grossIncome: 450000,
                            deductions: 120000,
                            taxableIncome: 380000,
                            taxPayable: 145000,
                            netAfterTax: 355000,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Detailed Breakdown (blue)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9EEF8),
                            border: Border.all(color: const Color(0xFFE6E6E6)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Detailed Breakdown",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _lineRow("Gross Income", "\$${_money(grossIncome)}"),
                              const SizedBox(height: 8),
                              _lineRow(
                                "Deductible Expenses",
                                "-\$${_money(deductibleExpenses)}",
                                valueColor: Colors.red,
                              ),
                              const SizedBox(height: 8),
                              _lineRow("Taxable Income", "\$${_money(taxableIncome)}"),
                              const SizedBox(height: 8),
                              _lineRow("Tax Rate Applied",
                                  "${taxRateApplied.toStringAsFixed(2)}%"),
                              const SizedBox(height: 10),
                              const Divider(height: 16),
                              _lineRow(
                                "Final Payable Amount",
                                "\$${_money(totalTaxPayable)}",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Negative Gearing Benefit (green)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9FFF2),
                            border: Border.all(color: const Color(0xFFE6E6E6)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Negative Gearing Benefit",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _lineRow("Rental Income", "\$${_money(rentalIncome)}"),
                              const SizedBox(height: 6),
                              _lineRow(
                                "Property Expenses",
                                "-\$${_money(propertyExpenses)}",
                                valueColor: Colors.red,
                              ),
                              const SizedBox(height: 6),
                              _lineRow(
                                "Depreciation",
                                "-\$${_money(depreciation)}",
                                valueColor: Colors.red,
                              ),
                              const SizedBox(height: 6),
                              _lineRow(
                                "Property Loss",
                                "-\$${_money(propertyLoss)}",
                                valueColor: Colors.red,
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 16),
                              _lineRow(
                                "Tax Benefit",
                                "\$${_money(taxBenefit)}",
                                valueColor: const Color(0xFF00A651),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Export PDF
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

                        const SizedBox(height: 12),

                        // Done
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

  static Widget _miniRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black38,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          right,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black54,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  static Widget _lineRow(
      String label,
      String value, {
        Color valueColor = Colors.black87,
      }) {
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

  static String _money(num v) {
    final s = v.toStringAsFixed(0);
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(reg, (m) => ',');
  }
}
