import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import 'liabilities.dart';
import '../controller/set_up_your_financial_profile_controller.dart';

class AssetsScreen extends StatefulWidget {
  AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final SetUpYourFinancialProfileController mainCtrl = Get.find<SetUpYourFinancialProfileController>();

  @override
  void initState() {
    super.initState();
    // Ensure assets are loaded and calculated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mainCtrl.updateAssetsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          CustomAppBarSetBeforeNaveBar(
            title: "Assets",
            currentStep: 5,
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

                    // Total Assets box
                    Container(
                      height: 92,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDife,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Total Assets",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Obx(() => Text(
                              "\$ ${mainCtrl.totalAssets.value.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saving Accounts",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Add account button
                        GestureDetector(
                          onTap: mainCtrl.addSavingAccount,
                          child: Text(
                            "+ Add account",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Saving account cards
                    Obx(() {
                      return Column(
                        children: List.generate(
                          mainCtrl.savingAccounts.length,
                              (index) => _savingAccountCard(index),
                        ),
                      );
                    }),

                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
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
                // Update assets list before navigating
                mainCtrl.updateAssetsList();
                Get.to(() => LiabilitiesScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _savingAccountCard(int index) {
    final acc = mainCtrl.savingAccounts[index];

    return Column(
      children: [
        Card(
          elevation: 5,
          color: AppColors.white,
          shape: const Border(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saving Account ${index + 1}",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => mainCtrl.removeSavingAccount(index),
                      icon: Icon(Icons.delete, color: AppColors.red),
                    )
                  ],
                ),
                const SizedBox(height: 8),

                Text(
                  "Bank Name",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.account_balance_outlined),
                  controller: acc.bankName,
                  keyboardType: TextInputType.text,
                  hintText: "e.g., Commonwealth Bank",
                  onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
                ),

                const SizedBox(height: 8),
                Text(
                  "Account No.",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  controller: acc.accountNo,
                  keyboardType: TextInputType.number,
                  hintText: "e.g., 123456789",
                  onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
                ),

                const SizedBox(height: 8),
                Text(
                  "Account Type",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: acc.accountType,
                  keyboardType: TextInputType.text,
                  hintText: "e.g., Savings Account",
                  onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
                ),

                const SizedBox(height: 8),
                Text(
                  "Interest Rate",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.calculate),
                  controller: acc.interestRate,
                  keyboardType: TextInputType.number,
                  hintText: "e.g., 4.5",
                  onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        _cashAndSavingsCard(acc),
        const SizedBox(height: 8),
        _investmentsCard(acc),
        const SizedBox(height: 8),
        _superannuationCard(acc),
        const SizedBox(height: 8),
        _otherAssetsCard(acc),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _cashAndSavingsCard(SavingAccountForm acc) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 39.98,
                  width: 39.98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.infoLight,
                  ),
                  child: SizedBox(
                    height: 14,
                    width: 10,
                    child: Image.asset(
                      "assets/icons/Wallet@4x.png",
                      color: AppColors.primaryDife,
                      fit: BoxFit.cover,
                      height: 14,
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cash & Savings",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      acc.bankName.text.isEmpty ? "Bank Name" : acc.bankName.text,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomInputField(
              prefixIcon: const Icon(Icons.monetization_on_outlined),
              controller: acc.cashSaving,
              keyboardType: TextInputType.number,
              hintText: "0",
              onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _investmentsCard(SavingAccountForm acc) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 39.98,
                  width: 39.98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greenLowLight,
                  ),
                  child: SizedBox(
                    height: 14,
                    width: 10,
                    child: Image.asset(
                      "assets/icons/up_graph.png",
                      color: AppColors.greenDip,
                      fit: BoxFit.cover,
                      height: 14,
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Investments",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Shares, managed funds, ETFs",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomInputField(
              prefixIcon: const Icon(Icons.monetization_on_outlined),
              controller: acc.investment,
              keyboardType: TextInputType.number,
              hintText: "0",
              onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _superannuationCard(SavingAccountForm acc) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 39.98,
                  width: 39.98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.infoLight,
                  ),
                  child: SizedBox(
                    height: 14,
                    width: 10,
                    child: Image.asset(
                      "assets/icons/money_sine.png",
                      color: AppColors.primary,
                      fit: BoxFit.cover,
                      height: 14,
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Superannuation",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Total super balance across all funds",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomInputField(
              prefixIcon: const Icon(Icons.monetization_on_outlined),
              controller: acc.superannuation,
              keyboardType: TextInputType.number,
              hintText: "0",
              onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otherAssetsCard(SavingAccountForm acc) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 39.98,
                  width: 39.98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.infoSecondaryLight,
                  ),
                  child: SizedBox(
                    height: 14,
                    width: 10,
                    child: Image.asset(
                      "assets/icons/Package.png",
                      color: AppColors.red,
                      fit: BoxFit.cover,
                      height: 14,
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other Assets",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Vehicles, collectibles, valuables",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomInputField(
              prefixIcon: const Icon(Icons.monetization_on_outlined),
              controller: acc.otherAssets,
              keyboardType: TextInputType.number,
              hintText: "0",
              onChanged: (_) => mainCtrl.onSavingAccountFieldChanged(),
            ),
          ],
        ),
      ),
    );
  }
}