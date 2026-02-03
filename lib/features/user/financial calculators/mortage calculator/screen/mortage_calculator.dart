import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../../property investment/controller/select_custom_button_controller.dart';
import '../../property investment/widget/custom_button_widget.dart';
import 'mortgage_results_screen.dart';

class MortgageCalculatorScreen extends StatelessWidget {
  MortgageCalculatorScreen({super.key});

  final LoanTypeController loanTypeController = Get.put(LoanTypeController());

  // ✅ separate controllers (no initial values; hintText is used like screenshot)
  final TextEditingController loanAmountCtrl = TextEditingController();
  final TextEditingController interestRateCtrl = TextEditingController();
  final TextEditingController loanTermMonthsCtrl = TextEditingController();
  final TextEditingController depositCtrl = TextEditingController();

  // ✅ extra fields for Interest Only (same screenshot)
  final TextEditingController ioPeriodMonthsCtrl = TextEditingController();
  final TextEditingController remainingTermPAndICtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header (orange)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.warningSecondary),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Mortgage Calculator",
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

              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // ✅ Loan Details card
                        Card(
                          elevation: 5,
                          color: AppColors.white,
                          shape: Border.all(style: BorderStyle.none),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Loan Details",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                _label("Loan Amount (\$)"),
                                CustomInputField(
                                  controller: loanAmountCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "120000",
                                ),
                                const SizedBox(height: 10),

                                _label("Interest Rate (%)"),
                                CustomInputField(
                                  controller: interestRateCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "10",
                                ),
                                const SizedBox(height: 10),

                                _label("Loan Term (Months)"),
                                CustomInputField(
                                  controller: loanTermMonthsCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "360",
                                ),
                                const SizedBox(height: 10),

                                _label("Deposit (\$)"),
                                CustomInputField(
                                  controller: depositCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "50000",
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Loan Type card (with extra fields like screenshot)
                        Card(
                          elevation: 5,
                          color: AppColors.white,
                          shape: Border.all(style: BorderStyle.none),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Loan Type",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                CustomSegmentSelector(
                                  height: 42,
                                  borderRadius: 6,
                                  backgroundColor: AppColors.btncolor,
                                  selectedColor: AppColors.primary,
                                  selectedTextColor: Colors.white,
                                  unSelectedTextColor: Colors.grey,
                                ),

                                const SizedBox(height: 12),

                                _label("IO period(Months)"),
                                CustomInputField(
                                  controller: ioPeriodMonthsCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "60",
                                ),
                                const SizedBox(height: 10),

                                _label("Remaining term(P&I)"),
                                CustomInputField(
                                  controller: remainingTermPAndICtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "300",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ✅ Bottom Calculate button (blue)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => MortgageResultScreen()),
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
      ),
    );
  }

  Widget _label(String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        t,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
