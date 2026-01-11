import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/property_dropdown_controller.dart';
import 'cash_flow_result_screen.dart';

class CashFlowCalculatorScreen extends StatelessWidget {
  CashFlowCalculatorScreen({super.key});

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
                        "Cash Flow Calculator",
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Input property",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              // Obx দিয়ে রিয়েক্টিভ করা হলো
                                  () => DropdownButtonFormField<String>(
                                value: propertyDropdownController
                                    .selectedProperty
                                    .value,
                                decoration: InputDecoration(
                                  // labelText: 'Select Property',
                                  //labelStyle: const TextStyle(color: Colors.blueGrey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.blueGrey,
                                ),
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                isExpanded: true,
                                items: propertyDropdownController.properties.map((
                                    String value,
                                    ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged:
                                propertyDropdownController.changeProperty,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        color: AppColors.white,
                        shape: Border.all(style: BorderStyle.none),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Income",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Monthly Rental Income",
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
                              "Other Monthly Income",
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
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        color: AppColors.white,
                        shape: Border.all(style: BorderStyle.none),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Monthly Expenses",
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
                              "Loan Details",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Loan Amount",
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
                            const SizedBox(height: 4),
                            Text(
                              "Interest Rate (%)",
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
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
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
                    Get.to(()=>CashFlowResultScreen());
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
