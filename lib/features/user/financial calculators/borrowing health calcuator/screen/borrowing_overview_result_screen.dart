import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custome_container.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../../income calculator/widget/income_cumamary_widget.dart';

class BorrowingOverviewResultScreen extends StatelessWidget {
  BorrowingOverviewResultScreen({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  final UserBottomNavbarController navbarController =
      Get.find<UserBottomNavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(color: AppColors.primaryDife),
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
                        "Borrowing Overview",
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
                          padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Estimated Borrowing Capacity",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    height: 20,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightDeepPink,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(child: Text("Week",style: TextStyle(color: AppColors.red,fontSize: 10,fontWeight: FontWeight.w700),)),
                                  )

                              ],),

                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    "\$81,873",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),

                                  Text(
                                    "-",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),

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
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Card(
                            elevation: 5,
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  /*Text(
                                    "Breakdown",
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  breakdownRow(
                                    title: "Monthly Rental Income",
                                    value: "\$2,800",
                                  ),
                                  breakdownRow(
                                    title: "Total Expenses",
                                    value: "\$930",
                                    valueColor: AppColors.warning,
                                  ),
                                  breakdownRow(
                                    title: "Loan Repayment",
                                    value: "\$2,063",
                                    valueColor: AppColors.warning,
                                  ),
                                  breakdownRow(
                                    title: "Other Income",
                                    value: "\$818",
                                  ),
                                  breakdownRow(
                                    title: "Net Cashflow",
                                    value: "\$625",
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Card(
                        elevation: 4,
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IncomeSourcesChartCard(
                            title: "Assets Vs Liabilities",
                            employmentIncomeTitle: "Assets",
                            rentalIncomeTitle: "Liabilities",
                            employmentIncome: 85000,
                            rentalIncome: 24000,
                          ),
                        ),
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

  Widget breakdownRow({
    required String title,
    required String value,
    Color valueColor = AppColors.grey,
  }) {
    return Container(
      decoration: BoxDecoration(color: AppColors.infoLight),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //const Divider(),
          ],
        ),
      ),
    );
  }
}
