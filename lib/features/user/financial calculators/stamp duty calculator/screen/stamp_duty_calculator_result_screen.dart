import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_break_down_row_container.dart';
import '../../../../../core/widgets/custome_container.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../widget/stamp_duty_calculator_result_break_down_chart_widget.dart';

class StampDutyCalculatorResultScreen extends StatelessWidget {
  StampDutyCalculatorResultScreen({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  final items = [
    ChartItem(
      label: "Stamp Duty",
      value: 27500,
      color: Colors.blue.shade700,
    ),
    ChartItem(
      label: "Registration Fees",
      value: 7137.5,
      color: Colors.purple.shade400,
    ),
    ChartItem(
      label: "Transfer Fees",
      value:7137.5,
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
              decoration: BoxDecoration(color: AppColors.indicator),
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
                        "Investment Results",
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
                      Container(
                        height: 78.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.colorList[0],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Net Annual Income",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$81,873",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              customContainer(
                                AppColors.greenDip,
                                1,
                                "Gross Income",
                                "\$109,000",
                                70,
                                173,
                              ),
                              const SizedBox(width: 10),
                              customContainer(
                                AppColors.warning,
                                1,
                                "Tax Rate",
                                "\$24.89%",
                                70,
                                163,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),


                          Card(
                            elevation: 5,
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const Text(
                                    "Duty Breakdown",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  StampDutyCalculatorResultBreakDownChartWidget(
                                    totalAmount: 41775, // 27500 + 150 + 200
                                    items: items,
                                  ),
                                ],
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
                                title: "Stamp Duty Amount",
                                value: "\$27500",
                              ),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Registration Fees",
                                value: "\$7,137.5",
                                valueColor: AppColors.warning,
                              ),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Transfer Fees",
                                value: "\$7,137.5",
                                valueColor: AppColors.warning,
                              ),
                              Divider(),
                              breakdownRow(
                                containerColors: AppColors.infoLight,
                                title: "Total Taxes & Fees",
                                value: "\$41,775",
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
