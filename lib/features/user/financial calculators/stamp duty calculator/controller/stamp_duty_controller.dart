import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../model/stamp_duty_models.dart';

class StampDutyController extends GetxController {
  final Rxn<StampDutyResponse> result = Rxn<StampDutyResponse>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  double _toDouble(String text) {
    final t = text.trim();
    if (t.isEmpty) return 0;
    return double.tryParse(t) ?? 0;
  }

  Future<void> calculateStampDuty({
    required String propertyType,
    required String buyerType,
    required String suburb, // state abbreviation like NSW
    required TextEditingController savingsController,
    required TextEditingController propertyValueController,

    // Optional inputs
    TextEditingController? loanAmountController,
    TextEditingController? interestRateController,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    result.value = null;

    try {
      final String? token = await Urls.token;
      final Uri url = Uri.parse("${Urls.baseUrl}/calculators/stamp-duty");

      final double savings = _toDouble(savingsController.text);
      final double propertyValue = _toDouble(propertyValueController.text);

      // ✅ build body with optional fields only if provided & not empty
      final Map<String, dynamic> body = {
        "propertyType": propertyType,
        "buyerType": buyerType,
        "suburb": suburb,
        "savings": savings,
        "propertyValue": propertyValue,
      };

      final loanText = loanAmountController?.text.trim() ?? '';
      if (loanText.isNotEmpty) {
        body["loanAmount"] = _toDouble(loanText);
      }

      final rateText = interestRateController?.text.trim() ?? '';
      if (rateText.isNotEmpty) {
        body["interestRate"] = _toDouble(rateText);
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      );

      print("Stamp Duty API Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final StampDutyResponse parsed = StampDutyResponse.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {
          result.value = parsed;
        } else {
          result.value = null;
          errorMessage.value = (parsed.message ?? '').trim().isNotEmpty
              ? parsed.message!.trim()
              : "No stamp duty data found.";
        }
      } else {
        result.value = null;

        // ✅ try server message
        String msg =
            "Failed to calculate stamp duty. Status code: ${response.statusCode}";
        try {
          final Map<String, dynamic> err =
          jsonDecode(response.body) as Map<String, dynamic>;
          final serverMsg = (err['message'] ?? '').toString().trim();
          if (serverMsg.isNotEmpty) msg = serverMsg;
        } catch (_) {}

        errorMessage.value = msg;
      }
    } catch (e) {
      result.value = null;
      errorMessage.value = "Error calculating stamp duty: $e";
      print("Error calculating stamp duty: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshStampDuty({
    required String propertyType,
    required String buyerType,
    required String suburb,
    required TextEditingController savingsController,
    required TextEditingController propertyValueController,
    TextEditingController? loanAmountController,
    TextEditingController? interestRateController,
  }) async {
    await calculateStampDuty(
      propertyType: propertyType,
      buyerType: buyerType,
      suburb: suburb,
      savingsController: savingsController,
      propertyValueController: propertyValueController,
      loanAmountController: loanAmountController,
      interestRateController: interestRateController,
    );
  }
}
