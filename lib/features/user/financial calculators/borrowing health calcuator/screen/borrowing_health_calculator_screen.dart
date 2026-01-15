import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../../property investment/controller/select_custom_button_controller.dart';
import 'borrowing_overview_result_screen.dart';

class BorrowingHealthCalculatorScreen extends StatelessWidget {
BorrowingHealthCalculatorScreen({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  final LoanTypeController loanTypeController = Get.put(LoanTypeController());
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Borrowing Health Calculator",
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

            // স্ক্রল হওয়া অংশ (Expanded দিয়ে পুরো জায়গা নেবে)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        color: AppColors.white,
                        shape: Border.all(style: BorderStyle.none),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Income Details",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Annual Income (\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "1200000",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Other income(\$/year)-Optional",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "12000",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Loan Amount(\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "12000",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        color: AppColors.white,
                        shape: Border.all(style: BorderStyle.none),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Expenses & Commitments",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Living Expenses(\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "50000",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Exiting Loan Repayments(\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "4000",
                              ),
                            /*  const SizedBox(height: 4),
                              Text(
                                "Depreciation(Optional)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "4000",
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        color: AppColors.white,
                        shape: Border.all(style: BorderStyle.none),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Financial Position",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Total Assets Value(\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "50000",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Total Liabilities Value(\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "4000",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            // বাটন — এখানে Expanded দরকার নেই
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 56, // বাটনের উচ্চতা নিজে নিয়ন্ত্রণ করো
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => BorrowingOverviewResultScreen());
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
                  child: const Text("Calculate"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
