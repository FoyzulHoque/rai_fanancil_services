import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../model/income_summary_model.dart';
import '../screen/income_summary_screen.dart';
import 'income_result_controller.dart';

class IncomeCalculatorController extends GetxController {
  var incomeFrequencyController = TextEditingController();
  var primaryIncomeController = TextEditingController();
  var rentalIncomeController = TextEditingController();
  var businessOrSideIncomeController = TextEditingController();
  var otherIncomeController = TextEditingController();
  var residencyStatusController = TextEditingController(); // taxRegion

  var isLoading = false.obs;

  double _parseDouble(TextEditingController c) =>
      double.tryParse(c.text.trim()) ?? 0;

  Future<void> createIncomeCalculator() async {
    final freq = incomeFrequencyController.text.trim();
    final taxRegion = residencyStatusController.text.trim();

    if (freq.isEmpty) {
      Get.snackbar("Error", "Please select income frequency.");
      return;
    }

    if (taxRegion.isEmpty) {
      Get.snackbar("Error", "Please enter residency status (tax region).");
      return;
    }

    isLoading.value = true;

    try {
      String? token = await Urls.token;
      final url = Uri.parse("${Urls.baseUrl}/calculators/income");

      final payload = {
        "incomeFrequency": freq,
        "primaryIncome": _parseDouble(primaryIncomeController),
        "rentalIncome": _parseDouble(rentalIncomeController),
        "businessIncome": _parseDouble(businessOrSideIncomeController),
        "otherIncome": _parseDouble(otherIncomeController),
        "taxRegion": taxRegion,
      };

      debugPrint("Create Income Payload: ${jsonEncode(payload)}");

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
        final parsed =
        IncomeSummaryResponse.fromJson(jsonDecode(response.body));

        final resultController = Get.find<IncomeResultController>();
        resultController.setResult(parsed.data);

        Get.snackbar("Success", parsed.message);

        Get.to(() => IncomeSummaryScreen());

        // ✅ Clear fields
        incomeFrequencyController.clear();
        primaryIncomeController.clear();
        rentalIncomeController.clear();
        businessOrSideIncomeController.clear();
        otherIncomeController.clear();
        residencyStatusController.clear();
      } else {
        String msg = "Failed to calculate income";
        try {
          final data = jsonDecode(response.body);
          msg = data["message"]?.toString() ?? msg;
        } catch (_) {}
        Get.snackbar("Error", msg);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to calculate income: $e");
      debugPrint("Create income calculator error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    incomeFrequencyController.dispose();
    primaryIncomeController.dispose();
    rentalIncomeController.dispose();
    businessOrSideIncomeController.dispose();
    otherIncomeController.dispose();
    residencyStatusController.dispose();
    super.onClose();
  }
}
