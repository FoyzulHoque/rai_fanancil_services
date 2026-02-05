import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/network_path/natwork_path.dart';
import '../model/mortgage_models.dart';
import '../screen/mortgage_results_screen.dart';

class MortgageController extends GetxController {
  final Rxn<MortgageResponse> mortgage = Rxn<MortgageResponse>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  int _toInt(String s) {
    final t = s.trim();
    if (t.isEmpty) return 0;
    return int.tryParse(t) ?? 0;
  }

  double _toDouble(String s) {
    final t = s.trim();
    if (t.isEmpty) return 0;
    return double.tryParse(t) ?? 0;
  }

  Future<void> calculateMortgage({
    required TextEditingController loanAmountCtrl,
    required TextEditingController interestRateCtrl,
    required TextEditingController loanTermMonthsCtrl,
    required TextEditingController depositCtrl,
    required String loanType, // "IO" or "P&I"
    required TextEditingController ioPeriodMonthsCtrl,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    mortgage.value = null;

    try {
      final String? token = await Urls.token;
      final Uri url = Uri.parse("${Urls.baseUrl}/calculators/mortgage");

      final body = <String, dynamic>{
        "loanAmount": _toInt(loanAmountCtrl.text),
        "interestRate": _toDouble(interestRateCtrl.text),
        "loanTermMonths": _toInt(loanTermMonthsCtrl.text),
        "deposit": _toInt(depositCtrl.text),
        "loanType": loanType,
      };

      // ✅ interestOnlyMonths only when IO
      if (loanType == "IO") {
        final ioMonths = _toInt(ioPeriodMonthsCtrl.text);
        body["interestOnlyMonths"] = ioMonths == 0 ? 60 : ioMonths; // default 60
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      );

      print("Mortgage API Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final parsed = MortgageResponse.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {
          Get.to(() => MortgageResultScreen());
          mortgage.value = parsed;
        } else {
          mortgage.value = null;
          errorMessage.value = (parsed.message ?? '').trim().isNotEmpty
              ? parsed.message!.trim()
              : "No mortgage data found.";
        }
      } else {
        mortgage.value = null;

        String msg = "Failed to calculate mortgage. Status code: ${response.statusCode}";
        try {
          final Map<String, dynamic> err =
          jsonDecode(response.body) as Map<String, dynamic>;
          final serverMsg = (err['message'] ?? '').toString().trim();
          if (serverMsg.isNotEmpty) msg = serverMsg;
        } catch (_) {}

        errorMessage.value = msg;
      }
    } catch (e) {
      mortgage.value = null;
      errorMessage.value = "Error: $e";
      print("Mortgage error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
