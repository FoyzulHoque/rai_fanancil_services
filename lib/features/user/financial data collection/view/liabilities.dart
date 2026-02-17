import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../../user navbar/user_navbar_screen.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import '../controller/set_up_your_financial_profile_controller.dart';

class LiabilitiesScreen extends StatefulWidget {
  const LiabilitiesScreen({super.key});

  @override
  State<LiabilitiesScreen> createState() => _LiabilitiesScreenState();
}

class _LiabilitiesScreenState extends State<LiabilitiesScreen> {
  final SetUpYourFinancialProfileController controller = Get.find<SetUpYourFinancialProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          CustomAppBarSetBeforeNaveBar(
            title: "Liabilities",
            currentStep: 6,
            totalSteps: 6,
            appBarColor: AppColors.secondaryColors,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // ── Loans ────────────────────────────────────────────────────────
                    _buildSectionHeader("Loans", "+ Add Loan", controller.addLoan),
                    const SizedBox(height: 16),
                    Obx(() => Column(
                      children: List.generate(
                        controller.loans.length,
                            (index) => _buildLoanCard(index, controller.loans[index]),
                      ),
                    )),

                    const SizedBox(height: 32),
                    // ── Buy now pay later ────────────────────────────────────────────
                    _buildSectionHeader("Buy now pay later", "+ Add others", controller.addBuyNowPayLater),
                    const SizedBox(height: 16),
                    Obx(() => Column(
                      children: List.generate(
                        controller.buyNowPayLaters.length,
                            (index) => _buildByNowPayLater(index, controller.buyNowPayLaters[index]),
                      ),
                    )),

                    const SizedBox(height: 32),
                    // ── Credit Cards ─────────────────────────────────────────────────
                    _buildSectionHeader("Credit Cards", "+ Add Card", controller.addCreditCard),
                    const SizedBox(height: 16),
                    Obx(() => Column(
                      children: List.generate(
                        controller.creditCards.length,
                            (index) => _buildCreditCardCard(index, controller.creditCards[index]),
                      ),
                    )),

                    const SizedBox(height: 32),
                    // ── SMSF ─────────────────────────────────────────────────────────
                    _buildSectionHeader("SMSF", "+ Add SMSF", controller.addSMSF),
                    const SizedBox(height: 16),
                    Obx(() => Column(
                      children: List.generate(
                        controller.smsfs.length,
                            (index) => _buildSMSFCard(index, controller.smsfs[index]),
                      ),
                    )),

                    const SizedBox(height:32),
                    _buildSectionHeader("HECS Debt", "", (){}),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.monetization_on_outlined),
                              controller: controller.hecsDebtController,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                              onChanged: (value) => controller.onHecsDebtChanged(value),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),

          // Bottom button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Update liabilities before saving
                controller.updateLiabilitiesList();
                // Submit financial profile
                controller.submitFinancialProfile();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              child: const Text("Save & Go to Dashboard"),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Header ───────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title, String addText, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: onAdd,
          child: Text(
            addText,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ── Loan Card ────────────────────────────────────────────────────────────────
  Widget _buildLoanCard(int index, LoanModel loan) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.delete, color: AppColors.red, size: 20),
                  onPressed: () => controller.removeLoan(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Loan ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank Name", loan.bankNameController, "e.g., Commonwealth Bank", TextInputType.text, null, controller.onLiabilityFieldChanged),
                  _buildField("Current Balance", loan.balanceController, "0", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Interest Rate (%)", loan.interestRateController, "0.00", TextInputType.numberWithOptions(decimal: true), Icons.percent, controller.onLiabilityFieldChanged),
                  _buildField("Monthly Payment", loan.monthlyPaymentController, "0", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Months Remaining", loan.monthsRemainingController, "0", TextInputType.number, null, controller.onLiabilityFieldChanged),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Credit Card Card ─────────────────────────────────────────────────────────
  Widget _buildCreditCardCard(int index, CreditCardModel card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.delete, color: AppColors.red, size: 20),
                  onPressed: () => controller.removeCreditCard(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Card ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank", card.bankController, "e.g., ANZ", TextInputType.text, null, controller.onLiabilityFieldChanged),
                  _buildField("Credit Limit", card.limitController, "0", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Current Balance", card.balanceController, "0.00", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Monthly Payment (%)", card.monthlyPaymentController, "What % do you pay each month?", TextInputType.number, Icons.calculate_sharp, controller.onLiabilityFieldChanged),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Buy Now Pay Later Card ───────────────────────────────────────────────────
  Widget _buildByNowPayLater(int index, BuyNowPayLaterModel bnpl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.delete, color: AppColors.red, size: 20),
                  onPressed: () => controller.removeBuyNowPayLater(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buy now pay later ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank", bnpl.bankController, "e.g., ANZ", TextInputType.text, null, controller.onLiabilityFieldChanged),
                  _buildField("Current Balance", bnpl.balanceController, "0.00", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Interest Rate (%)", bnpl.interestRateController, "0", TextInputType.number, Icons.percent, controller.onLiabilityFieldChanged),
                  _buildField("Monthly Payment", bnpl.monthlyPaymentController, "0", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Months Remaining", bnpl.monthsRemainingController, "0", TextInputType.number, null, controller.onLiabilityFieldChanged),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── SMSF Card ────────────────────────────────────────────────────────────────
  Widget _buildSMSFCard(int index, SMSFModel sms) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.delete, color: AppColors.red, size: 20),
                  onPressed: () => controller.removeSMSF(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SMSF ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank", sms.bankController, "e.g., Westpac", TextInputType.text, null, controller.onLiabilityFieldChanged),
                  _buildField("Loan Balance", sms.balanceController, "0", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Rate (%)", sms.rateController, "0.00", TextInputType.numberWithOptions(decimal: true), Icons.percent, controller.onLiabilityFieldChanged),
                  _buildField("Monthly Amount", sms.monthlyAmountController, "0", TextInputType.number, Icons.monetization_on_outlined, controller.onLiabilityFieldChanged),
                  _buildField("Months Remaining", sms.monthsController, "0", TextInputType.number, null, controller.onLiabilityFieldChanged),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helper Widgets ───────────────────────────────────────────────────────────
  TextStyle _titleStyle() => TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  Widget _buildField(
      String label,
      TextEditingController controller,
      String hint,
      TextInputType keyboardType,
      [IconData? prefixIcon,
        VoidCallback? onChanged]
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        CustomInputField(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          controller: controller,
          hintText: hint,
          keyboardType: keyboardType,
          onChanged: (value) {
            if (onChanged != null) onChanged();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}