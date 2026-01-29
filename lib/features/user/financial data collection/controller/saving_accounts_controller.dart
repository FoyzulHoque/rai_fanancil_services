import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SavingAccountForm {
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountNo = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController interestRate = TextEditingController();

  void dispose() {
    bankName.dispose();
    accountNo.dispose();
    accountType.dispose();
    interestRate.dispose();
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

  @override
  void onClose() {
    for (final a in accounts) {
      a.dispose();
    }
    super.onClose();
  }
}
