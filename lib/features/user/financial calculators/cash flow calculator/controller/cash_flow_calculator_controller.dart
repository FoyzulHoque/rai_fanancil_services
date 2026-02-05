import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../model/cashflow_scenario_model.dart';
import '../screen/cash_flow_result_screen.dart';
import 'cashflow_result_controller.dart';

class CashFlowLoanForm {
  final TextEditingController loanNameController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController termYearsController = TextEditingController();

  Map<String, dynamic> toJson() => {
    "loanName": loanNameController.text.trim(),
    "loanAmount": double.tryParse(loanAmountController.text.trim()) ?? 0,
    "interestRate": double.tryParse(interestRateController.text.trim()) ?? 0,
    "termYears": int.tryParse(termYearsController.text.trim()) ?? 0,
  };

  void dispose() {
    loanNameController.dispose();
    loanAmountController.dispose();
    interestRateController.dispose();
    termYearsController.dispose();
  }
}

class CashFlowCalculatorController extends GetxController {
  // Cash flow specific controllers (NO initial values)
  var positionController = TextEditingController(); // will be set from dropdown
  var rentalIncreasePerYearController = TextEditingController();
  var cashRateChangeController = TextEditingController();
  var annualSalaryIncreaseController = TextEditingController();
  var expenseInflationController = TextEditingController();

  // Loans list (dynamic)
  var loans = <CashFlowLoanForm>[].obs;

  // Loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addInitialLoan(); // only adds empty loan block (no values)
  }

  void addInitialLoan() {
    if (loans.isEmpty) {
      loans.add(CashFlowLoanForm());
    }
  }

  void addLoan() {
    loans.add(CashFlowLoanForm());
  }

  void removeLoan(int index) {
    // ✅ minimum 1 loan always থাকবে
    if (loans.length <= 1) return;

    loans[index].dispose();
    loans.removeAt(index);
  }

  double _parseDouble(TextEditingController c) =>
      double.tryParse(c.text.trim()) ?? 0;

  int _parseInt(TextEditingController c) => int.tryParse(c.text.trim()) ?? 0;

  Future<void> createCashFlowCalculator() async {
    // ✅ simple validations (optional but recommended)
    final pos = positionController.text.trim();
    if (pos.isEmpty) {
      Get.snackbar("Error", "Please select cashflow position.");
      return;
    }

    for (int i = 0; i < loans.length; i++) {
      final loan = loans[i];

      if (loan.loanNameController.text.trim().isEmpty ||
          loan.loanAmountController.text.trim().isEmpty ||
          loan.interestRateController.text.trim().isEmpty ||
          loan.termYearsController.text.trim().isEmpty) {
        Get.snackbar("Error", "Please fill all loan fields for loan #${i + 1}");
        return;
      }
    }

    isLoading.value = true;

    try {
      String? token = await Urls.token;
      final url = Uri.parse("${Urls.baseUrl}/calculators/cashflow/scenario");

      // ✅ API payload EXACT
      final payload = {
        "position": pos,
        "rentalIncreasePerYear": _parseDouble(rentalIncreasePerYearController),
        "cashRateChange": _parseDouble(cashRateChangeController),
        "annualSalaryIncrease": _parseDouble(annualSalaryIncreaseController),
        "expenseInflation": _parseDouble(expenseInflationController),
        "loans": loans.map((l) => l.toJson()).toList(),
      };

      debugPrint("Create Cash Flow Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(payload),
      );

      debugPrint("Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final parsed = CashflowScenarioResponse.fromJson(jsonDecode(response.body));

        // ✅ store result in controller
        final resultController = Get.find<CashFlowResultController>();
        resultController.setResult(parsed.data);

        Get.snackbar("Success", parsed.message);

        // ✅ go to result screen
        Get.to(() => CashFlowResultScreen());

        // ✅ Clear all fields (NO defaults)
        positionController.clear();
        rentalIncreasePerYearController.clear();
        cashRateChangeController.clear();
        annualSalaryIncreaseController.clear();
        expenseInflationController.clear();

        for (final l in loans) {
          l.dispose();
        }
        loans.clear();
        addInitialLoan();
      } else {
        String msg = "Failed to create calculator";
        try {
          final data = jsonDecode(response.body);
          msg = data["message"]?.toString() ?? msg;
        } catch (_) {}
        Get.snackbar("Error", msg);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to create calculator: $e");
      debugPrint("Create cash flow calculator error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    positionController.dispose();
    rentalIncreasePerYearController.dispose();
    cashRateChangeController.dispose();
    annualSalaryIncreaseController.dispose();
    expenseInflationController.dispose();

    for (final l in loans) {
      l.dispose();
    }
    super.onClose();
  }
}
