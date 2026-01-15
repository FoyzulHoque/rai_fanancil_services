import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_break_down_row_container.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../../stamp duty calculator/widget/stamp_duty_calculator_result_break_down_chart_widget.dart';
import '../widget/income_&_tax_overview_widget.dart';
import '../widget/tax_summary_result_widget1.dart';

class TaxSummaryResult extends StatelessWidget {
  TaxSummaryResult({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  final UserBottomNavbarController navbarController =
      Get.find<UserBottomNavbarController>();

  final items = [
    ChartItem(label: "Stamp Duty", value: 27500, color: Colors.blue.shade700),
    ChartItem(
      label: "Registration Fees",
      value: 7137.5,
      color: Colors.purple.shade400,
    ),
    ChartItem(
      label: "Transfer Fees",
      value: 7137.5,
      color: Colors.pink.shade400,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(color: AppColors.infoLightMore),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      "assets/icons/moves_right.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tax Summary",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: RepaintBoundary(
                  key: pageKey, // Attach the key here
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          //-------------Total Tax Payable--------------------------------
                          TaxSummaryResultWidget1(
                            incomeTax: "152,800",
                            investmentTax: "938",
                            landTax: "2",
                            netProfitAfterTax: "356259",
                            totalTaxPayable: "153,741",
                          ),
                          const SizedBox(height: 12),
                          Card(
                            elevation: 5,
                            color: AppColors.white,
                            shape: Border.all(style: BorderStyle.none),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IncomeTaxOverviewChart(
                                grossIncome: 450000,
                                deductions: 120000,
                                taxableIncome: 380000,
                                taxPayable: 145000,
                                netAfterTax: 355000,
                                // optional: maxY: 700000, barWidth: 45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Capital Growth Forecast

                              //------------------------------------Insurance Estimate--------------
                              Text(
                                "Detailed Breakdown",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Gross Income",
                                value: "\$510,000",
                                valueColor: AppColors.black,
                              ),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Deductible Expenses",
                                value: "\$111,515",
                                valueColor: AppColors.red,
                              ),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Taxable Income",
                                value: "\$404,741",
                                valueColor: AppColors.black,
                              ),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Tax Rate Applied",
                                value: "\$37.98",
                                valueColor: AppColors.black,
                              ),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Final Payable Amount",
                                value: "\$153,741",
                                valueColor: AppColors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              // Add a small delay to ensure the UI is stable
                              await Future.delayed(
                                const Duration(milliseconds: 50),
                              );
                              final imageBytes = await captureFullPage();
                              if (imageBytes != null) {
                                final pdfFile = await generatePdf(imageBytes);
                                await printPdf(pdfFile);
                              }
                            },
                            icon: const Icon(Icons.print, color: Colors.blue),
                            label: const Text("Print Full Page"),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              navbarController.financialCalculatorsScreen();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text("Down"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
