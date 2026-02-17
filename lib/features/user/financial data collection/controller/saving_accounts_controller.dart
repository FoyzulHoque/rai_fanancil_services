import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SavingAccountForm {
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountNo = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController interestRate = TextEditingController();
  final TextEditingController cashSaving = TextEditingController();
  final TextEditingController investment = TextEditingController();
  final TextEditingController superannuation = TextEditingController();
  final TextEditingController otherAssets = TextEditingController();

  void dispose() {
    bankName.dispose();
    accountNo.dispose();
    accountType.dispose();
    interestRate.dispose();
    cashSaving.dispose();
    investment.dispose();
    superannuation.dispose();
    otherAssets.dispose();
  }
}

class SavingAccountsController extends GetxController {
  final accounts = <SavingAccountForm>[].obs;

  @override
  void onInit() {
    super.onInit();
    addAccount(); // ✅ start minimum 1 (Saving Account 1)
  }

  void addAccount() {
    accounts.add(SavingAccountForm());
  }

  void removeAccount(int index) {
    // ✅ prevent removing last one (minimum 1)
    if (accounts.length <= 1) return;

    if (index < 0 || index >= accounts.length) return;
    final acc = accounts.removeAt(index);
    acc.dispose();
  }

  // Method to load existing account data
  void loadAccountData(List<Map<String, dynamic>> accountDataList) {
    // Clear existing accounts
    for (final a in accounts) {
      a.dispose();
    }
    accounts.clear();

    // Add accounts from data
    if (accountDataList.isNotEmpty) {
      for (var accountData in accountDataList) {
        final newAccount = SavingAccountForm();
        newAccount.bankName.text = accountData['bankName'] ?? '';
        newAccount.accountNo.text = accountData['accountNumber'] ?? '';
        newAccount.accountType.text = accountData['accountType'] ?? '';
        newAccount.interestRate.text = accountData['interestRate']?.toString() ?? '';
        newAccount.cashSaving.text = accountData['cashSaving']?.toString() ?? '';
        newAccount.investment.text = accountData['investment']?.toString() ?? '';
        newAccount.superannuation.text = accountData['superannuation']?.toString() ?? '';
        newAccount.otherAssets.text = accountData['otherAssets']?.toString() ?? '';
        accounts.add(newAccount);
      }
    } else {
      // Add default account if no data
      addAccount();
    }
  }

  @override
  void onClose() {
    for (final a in accounts) {
      a.dispose();
    }
    super.onClose();
  }
}