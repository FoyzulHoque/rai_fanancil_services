import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../../user navbar/user_navbar_screen.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';

class LiabilitiesScreen extends StatefulWidget {
  const LiabilitiesScreen({super.key});

  @override
  State<LiabilitiesScreen> createState() => _LiabilitiesScreenState();
}

class _LiabilitiesScreenState extends State<LiabilitiesScreen> {
  // Separate lists for each section
  final List<LoanModel> _loans = [LoanModel()];
  final List<CreditCardModel> _creditCards = [CreditCardModel()];
  final List<SMSFModel> _smsfs = [SMSFModel()];

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
                    _buildSectionHeader("Loans", "+ Add Loan", _addNewLoan),
                    const SizedBox(height: 16),
                    ..._loans.asMap().entries.map((e) => _buildLoanCard(e.key, e.value)),

                    const SizedBox(height: 32),
                    // ── Credit Cards ─────────────────────────────────────────────────
                    _buildSectionHeader("Buy now pay later", "+Add others", _addNewCard),
                    const SizedBox(height: 16),
                    ..._creditCards.asMap().entries.map((e) => _buildByNowPayLater(e.key, e.value)),
                    // ── Credit Cards ─────────────────────────────────────────────────
                    _buildSectionHeader("Credit Cards", "+ Add Card", _addNewCard),
                    const SizedBox(height: 16),
                    ..._creditCards.asMap().entries.map((e) => _buildCreditCardCard(e.key, e.value)),
                    const SizedBox(height: 16),
                    // ── SMSF ─────────────────────────────────────────────────────────
                    _buildSectionHeader("SMSF", "+ Add SMSF", _addNewSMSF),
                    const SizedBox(height: 16),
                    ..._smsfs.asMap().entries.map((e) => _buildSMSFCard(e.key, e.value)),
                    const SizedBox(height:16),
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
                              keyboardType: TextInputType.number,
                              hintText: "0",
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
                Get.offAll(()=>UserBottomNavbar());
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
                  onPressed: () => _removeLoan(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Loan ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank Name", loan.bankNameController, "e.g., Commonwealth Bank", TextInputType.text),
                  _buildField("Current Balance", loan.balanceController, "0", TextInputType.number, Icons.monetization_on_outlined),
                  _buildField("Interest Rate (%)", loan.interestRateController, "0.00", TextInputType.numberWithOptions(decimal: true), Icons.percent),
                  _buildField("Months Remaining", loan.monthsRemainingController, "0", TextInputType.number),
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
                  onPressed: () => _removeCard(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Card ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank", card.bankController, "e.g., ANZ", TextInputType.text),
                  _buildField("Credit Limit", card.limitController, "0", TextInputType.number, Icons.monetization_on_outlined),
                  _buildField("Current Balance", card.balanceController, "0.00", TextInputType.number, Icons.monetization_on_outlined),
                  _buildField("Monthly Payment (%)", card.monthlyPaymentController, "What % do you pay each month?", TextInputType.number, Icons.calculate_sharp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Credit Card Card ─────────────────────────────────────────────────────────
  Widget _buildByNowPayLater(int index, CreditCardModel card) {
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
                  onPressed: () => _removeCard(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buy now pay later ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank", card.bankController, "e.g., ANZ", TextInputType.text),
                  _buildField("Credit Limit", card.limitController, "0", TextInputType.number, Icons.monetization_on_outlined),
                  _buildField("Current Balance", card.balanceController, "0.00", TextInputType.number, Icons.monetization_on_outlined),
                  _buildField("Monthly Payment (%)", card.monthlyPaymentController, "What % do you pay each month?", TextInputType.number, Icons.calculate_sharp),
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
                  onPressed: () => _removeSMSF(index),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SMSF ${index + 1}", style: _titleStyle()),
                  const SizedBox(height: 16),
                  _buildField("Bank", sms.bankController, "e.g., Westpac", TextInputType.text),
                  _buildField("Loan Balance", sms.balanceController, "0", TextInputType.number, Icons.monetization_on_outlined),
                  _buildField("Rate (%)", sms.rateController, "0.00", TextInputType.numberWithOptions(decimal: true), Icons.percent),
                  _buildField("Months Remaining", sms.monthsController, "0", TextInputType.number),
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
      [IconData? prefixIcon]
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
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ── Add / Remove Functions ───────────────────────────────────────────────────
  void _addNewLoan() => setState(() => _loans.add(LoanModel()));
  void _removeLoan(int index) {
    if (_loans.length > 1) setState(() => _loans.removeAt(index));
  }

  void _addNewCard() => setState(() => _creditCards.add(CreditCardModel()));
  void _removeCard(int index) {
    if (_creditCards.length > 1) setState(() => _creditCards.removeAt(index));
  }

  void _addNewSMSF() => setState(() => _smsfs.add(SMSFModel()));
  void _removeSMSF(int index) {
    if (_smsfs.length > 1) setState(() => _smsfs.removeAt(index));
  }

  @override
  void dispose() {
    for (var loan in _loans) loan.dispose();
    for (var card in _creditCards) card.dispose();
    for (var sms in _smsfs) sms.dispose();
    super.dispose();
  }
}

// ── Models ───────────────────────────────────────────────────────────────────

class LoanModel {
  final bankNameController = TextEditingController();
  final balanceController = TextEditingController();
  final interestRateController = TextEditingController();
  final monthsRemainingController = TextEditingController();

  void dispose() {
    bankNameController.dispose();
    balanceController.dispose();
    interestRateController.dispose();
    monthsRemainingController.dispose();
  }
}

class CreditCardModel {
  final bankController = TextEditingController();
  final limitController = TextEditingController();
  final balanceController = TextEditingController();
  final monthlyPaymentController = TextEditingController();

  void dispose() {
    bankController.dispose();
    limitController.dispose();
    balanceController.dispose();
    monthlyPaymentController.dispose();
  }
}

class SMSFModel {
  final bankController = TextEditingController();
  final balanceController = TextEditingController();
  final rateController = TextEditingController();
  final monthsController = TextEditingController();

  void dispose() {
    bankController.dispose();
    balanceController.dispose();
    rateController.dispose();
    monthsController.dispose();
  }
}