import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/tax_summary_controller.dart';

class TaxCalculatorScreen extends StatelessWidget {
  TaxCalculatorScreen({super.key});

  // ✅ controllers (NO initial value, only from input)
  final TextEditingController primaryIncomeCtrl = TextEditingController();
  final TextEditingController otherIncomeCtrl = TextEditingController();
  final TextEditingController depreciationCtrl = TextEditingController();

  final TextEditingController totalRentCtrl = TextEditingController();
  final TextEditingController totalExpensesCtrl = TextEditingController();
  final TextEditingController loanInterestCtrl = TextEditingController();

  final TextEditingController capitalGainsCtrl = TextEditingController();
  final TextEditingController landTaxValueCtrl = TextEditingController();

  // ✅ GetX controller
  final TaxSummaryController controller = Get.put(TaxSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header (teal like screenshot)
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
                          "Tax Calculator",
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
                  child: Column(
                    children: [
                      // ✅ Income Sources
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(color: Color(0xFFE6E6E6)),
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

                              const Text(
                                "Primary Income (Annual)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: primaryIncomeCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Primary Income (Annual)",
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Other Income",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: otherIncomeCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Other Income",
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Depreciation (\$)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: depreciationCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Depreciation",
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ✅ Property Portfolio
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(color: Color(0xFFE6E6E6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Property Portfolio",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Total Rental Income (all properties)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: totalRentCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Total Rental Income (all properties)",
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Total Property Expenses",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: totalExpensesCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Total Property Expenses",
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Loan Interest (total)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: loanInterestCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Loan Interest (total)",
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ✅ Investment Details
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(color: Color(0xFFE6E6E6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Investment Details",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Capital Gains Amount (if any)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: capitalGainsCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Capital Gains Amount (if any)",
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "Land Tax Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              CustomInputField(
                                controller: landTaxValueCtrl,
                                keyboardType: TextInputType.number,
                                hintText: "Land Tax Value",
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),

              // ✅ Bottom Calculate button (full width)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                        await controller.calculateTaxSummary(
                          primaryIncomeCtrl: primaryIncomeCtrl,
                          otherIncomeCtrl: otherIncomeCtrl,
                          depreciationCtrl: depreciationCtrl,
                          totalRentCtrl: totalRentCtrl,
                          totalExpensesCtrl: totalExpensesCtrl,
                          loanInterestCtrl: loanInterestCtrl,
                          capitalGainsCtrl: capitalGainsCtrl,
                          landTaxValueCtrl: landTaxValueCtrl,
                        );
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
                      child: controller.isLoading.value
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Calculate"),
                    );
                  }),
                ),
              ),

              // ✅ error (doesn't change layout, just shows when needed)
              Obx(() {
                final msg = controller.errorMessage.value.trim();
                if (msg.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    msg,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
