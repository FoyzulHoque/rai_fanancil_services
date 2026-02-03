import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/cash_flow_calculator_controller.dart';
import 'cash_flow_result_screen.dart';

class CashFlowCalculatorScreen extends StatefulWidget {
  const CashFlowCalculatorScreen({super.key});

  @override
  State<CashFlowCalculatorScreen> createState() =>
      _CashFlowCalculatorScreenState();
}

class _CashFlowCalculatorScreenState extends State<CashFlowCalculatorScreen> {
  final CashFlowCalculatorController controller =
  Get.put(CashFlowCalculatorController());

  // Dropdown options
  final List<String> _positions = const ["Annually", "Monthly", "Weekly"];
  String? _selectedPosition; // ✅ no default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              width: double.infinity,
              color: AppColors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Cash Flow Calculator",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 34),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select cashflow position",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: _selectedPosition,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: _positions
                          .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => _selectedPosition = v);
                        controller.positionController.text = v;
                      },
                    ),

                    const SizedBox(height: 14),

                    _SectionCard(
                      title: "Annual Increases",
                      subtitle: "Impact of additional loan",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Label("Rental increase per year (%)"),
                          CustomInputField(
                            controller: controller.rentalIncreasePerYearController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                          ),
                          const SizedBox(height: 10),

                          _Label("Cash rate change (%)"),
                          CustomInputField(
                            controller: controller.cashRateChangeController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                          ),
                          const SizedBox(height: 10),

                          _Label("Annual salary increase (%)"),
                          CustomInputField(
                            controller: controller.annualSalaryIncreaseController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                          ),
                          const SizedBox(height: 10),

                          _Label("Expense inflation (%)"),
                          CustomInputField(
                            controller: controller.expenseInflationController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    _SectionCard(
                      title: "Loans & Mortgages",
                      rightAction: GestureDetector(
                        onTap: () => controller.addLoan(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.add, size: 18, color: Colors.blue),
                            SizedBox(width: 4),
                            Text(
                              "Add Loan",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          List.generate(controller.loans.length, (index) {
                            final loan = controller.loans[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Loan ${index + 1}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    if (controller.loans.length > 1)
                                      GestureDetector(
                                        onTap: () => controller.removeLoan(index),
                                        child: const Icon(Icons.delete_outline,
                                            color: Colors.red, size: 20),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                _Label("Loan Name"),
                                CustomInputField(
                                  controller: loan.loanNameController,
                                  keyboardType: TextInputType.text,
                                  hintText: "",
                                ),
                                const SizedBox(height: 10),

                                _Label("Loan Amount (\$)"),
                                CustomInputField(
                                  controller: loan.loanAmountController,
                                  keyboardType: TextInputType.number,
                                  hintText: "",
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          _Label("Interest Rate (%)"),
                                          CustomInputField(
                                            controller: loan.interestRateController,
                                            keyboardType: TextInputType.number,
                                            hintText: "",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          _Label("Term (years)"),
                                          CustomInputField(
                                            controller: loan.termYearsController,
                                            keyboardType: TextInputType.number,
                                            hintText: "",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),
                                if (index != controller.loans.length - 1)
                                  const Divider(height: 20, thickness: 1),
                              ],
                            );
                          }),
                        );
                      }),
                    ),

                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                    await controller.createCashFlowCalculator();
                    Get.to(() => CashFlowResultScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text("Calculate"),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- your existing widgets unchanged ---
class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? rightAction;

  const _SectionCard({
    required this.title,
    required this.child,
    this.subtitle,
    this.rightAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (rightAction != null) rightAction!,
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
