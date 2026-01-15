import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../../property investment/controller/select_custom_button_controller.dart';
import 'cost_estimates_screen.dart';

class InsuranceAndCouncilRatesScreen extends StatelessWidget {
  InsuranceAndCouncilRatesScreen({super.key});

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
              decoration: BoxDecoration(color: AppColors.lightBlueSolid),
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
                        "Insurance & Council Rates",
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
                                "Property Details",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Property Value(\$)",
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
                                "State",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "Victoria",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Building Area(sqm)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "1254",
                              ),
                            ],
                          ),
                        ),
                      ),
                     /* const SizedBox(height: 10),
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
                                "Loan Structure",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Interest Type",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomSegmentSelector(
                                height: 42,
                                borderRadius: 6,
                                backgroundColor: AppColors.btncolor,
                                selectedColor: AppColors.primary,
                                selectedTextColor: Colors.white,
                                unSelectedTextColor: Colors.grey,
                              ),

                              const SizedBox(height: 4),
                              Text(
                                "Remaining Loan Term (Years)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "5",
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
                                "Other Income(\$)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "5000",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Income Frequency)",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "Monthly",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Tax Settings",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Residency Status",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              CustomInputField(
                                controller: propertyController,
                                keyboardType: TextInputType.text,
                                hintText: "Own",
                              ),
                            ],
                          ),
                        ),
                      ),*/
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
                    Get.to(() => CostEstimatesScreen());
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
