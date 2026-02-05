import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../models/tax_summary_models.dart';
import '../screen/tax_summary_result.dart';

class TaxSummaryController extends GetxController {
  final Rxn<TaxSummaryResponse> summary = Rxn<TaxSummaryResponse>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  double _toDouble(TextEditingController c) {
    final t = c.text.trim();
    if (t.isEmpty) return 0;
    return double.tryParse(t) ?? 0;
  }

  Future<void> calculateTaxSummary({
    required TextEditingController primaryIncomeCtrl,
    required TextEditingController otherIncomeCtrl,
    required TextEditingController depreciationCtrl,
    required TextEditingController totalRentCtrl,
    required TextEditingController totalExpensesCtrl,
    required TextEditingController loanInterestCtrl,
    required TextEditingController capitalGainsCtrl,
    required TextEditingController landTaxValueCtrl,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    summary.value = null;

    try {
      final String? token = await Urls.token;
      final Uri url = Uri.parse("${Urls.baseUrl}/calculators/tax-summary");

      final body = {
        "primaryIncomeAnnual": _toDouble(primaryIncomeCtrl),
        "otherIncome": _toDouble(otherIncomeCtrl),
        "depreciation": _toDouble(depreciationCtrl),
        "totalRentalIncome": _toDouble(totalRentCtrl),
        "totalPropertyExpenses": _toDouble(totalExpensesCtrl),
        "loanInterestTotal": _toDouble(loanInterestCtrl),
        "capitalGainsAmount": _toDouble(capitalGainsCtrl),
        "landTaxValue": _toDouble(landTaxValueCtrl),
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      );

      print("Tax Summary API Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final parsed = TaxSummaryResponse.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {
          summary.value = parsed;

          // ✅ go to summary page (result page reads from controller)
          Get.to(() => TaxSummaryResult());
        } else {
          summary.value = null;
          errorMessage.value = (parsed.message ?? '').trim().isNotEmpty
              ? parsed.message!.trim()
              : "No tax summary found.";
        }
      } else {
        summary.value = null;

        String msg = "Failed. Status code: ${response.statusCode}";
        try {
          final Map<String, dynamic> err =
          jsonDecode(response.body) as Map<String, dynamic>;
          final serverMsg = (err['message'] ?? '').toString().trim();
          if (serverMsg.isNotEmpty) msg = serverMsg;
        } catch (_) {}

        errorMessage.value = msg;
      }
    } catch (e) {
      summary.value = null;
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
