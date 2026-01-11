import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../controller/property_dropdown_controller.dart';
import '../widget/castom_chart_widget.dart';

class CashFlowResultScreen extends StatelessWidget {
  CashFlowResultScreen({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  TextEditingController propertyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(color: AppColors.blue),
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Cash Flow Result",
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
                              "Net Monthly Cashflow",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$625",
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
                                Text(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CashflowBarChart(
                      title: "6-Month Cashflow Trend",
                      months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                      incomeData: [2800, 3000, 2900, 2700, 2900, 2850],
                      expenseData: [2200, 2100, 2300, 2150, 2200, 2350],
                      incomeColor: AppColors.success,
                      expenseColor: AppColors.warning,
                    ),
                    const SizedBox(height: 20),

                    // বাটন — এখানে Expanded দরকার নেই
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56, // বাটনের উচ্চতা নিজে নিয়ন্ত্রণ করো
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // ক্যালকুলেশন লজিক
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary, width: 1),
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.black,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          icon: Icon(
                            Icons.picture_as_pdf,
                            color: AppColors.primary,
                          ),
                          label: const Text("Export PDF"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56, // বাটনের উচ্চতা নিজে নিয়ন্ত্রণ করো
                        child: ElevatedButton(
                          onPressed: () {
                            // ক্যালকুলেশন লজিক
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
    return Column(
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
        const Divider(),
      ],
    );
  }
}
