import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../../property investment/controller/select_custom_button_controller.dart';
import '../../property investment/widget/custom_button_widget.dart';
import '../controller/mortgage_controller.dart';
import 'mortgage_results_screen.dart';

class MortgageCalculatorScreen extends StatelessWidget {
  MortgageCalculatorScreen({super.key});

  final LoanTypeController loanTypeController = Get.put(LoanTypeController());
  final MortgageController mortgageController = Get.put(MortgageController());

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
                                  hintText: "Loan Amount (\$)",
                                ),
                                const SizedBox(height: 10),

                                _label("Interest Rate (%)"),
                                CustomInputField(
                                  controller: interestRateCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Interest Rate (%)",
                                ),
                                const SizedBox(height: 10),

                                _label("Loan Term (Months)"),
                                CustomInputField(
                                  controller: loanTermMonthsCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Loan Term (Months)",
                                ),
                                const SizedBox(height: 10),

                                _label("Deposit (\$)"),
                                CustomInputField(
                                  controller: depositCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Deposit (\$)",
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
                                  hintText: "IO period(Months)",
                                ),
                                const SizedBox(height: 10),

                                _label("Remaining term(P&I)"),
                                CustomInputField(
                                  controller: remainingTermPAndICtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Remaining term(P&I)",
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
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: mortgageController.isLoading.value
                          ? null
                          : () async {

                        final String loanType = (loanTypeController.selected.value == LoanType.interestOnly) ? "IO" : "P&I";


                        await mortgageController.calculateMortgage(
                          loanAmountCtrl: loanAmountCtrl,
                          interestRateCtrl: interestRateCtrl,
                          loanTermMonthsCtrl: loanTermMonthsCtrl,
                          depositCtrl: depositCtrl,
                          loanType: loanType,
                          ioPeriodMonthsCtrl: ioPeriodMonthsCtrl,
                        );
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
                      child: mortgageController.isLoading.value
                          ? const SizedBox(
                        height: 22,
                        width: 22,
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
