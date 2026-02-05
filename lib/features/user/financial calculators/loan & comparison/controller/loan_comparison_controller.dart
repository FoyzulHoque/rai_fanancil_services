import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../model/loan_comparison_model.dart';

class LoanComparisonController extends GetxController {
  final Rxn<LoanComparisonResponse> comparison = Rxn<LoanComparisonResponse>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ✅ UI control: show only dropdown + calculate first
  final RxBool showFullUI = false.obs;

  Future<void> calculateLoanComparison({
    required String propertyId,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    showFullUI.value = false; // until success

    try {
      final String? token = await Urls.token;
      final Uri url = Uri.parse("${Urls.baseUrl}/calculators/loan-comparison");

      final body = jsonEncode({
        "propertyId": propertyId,
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: body,
      );

      print("Loan Comparison API (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final parsed = LoanComparisonResponse.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {
          comparison.value = parsed;
          showFullUI.value = true;
        } else {
          comparison.value = null;
          errorMessage.value = parsed.message.trim().isNotEmpty
              ? parsed.message.trim()
              : "No loan comparison data found.";
        }
      } else {
        comparison.value = null;

        String msg = "Failed to calculate loan comparison. Status: ${response.statusCode}";
        try {
          final Map<String, dynamic> err =
          jsonDecode(response.body) as Map<String, dynamic>;
          final String serverMsg = (err['message'] ?? '').toString().trim();
          if (serverMsg.isNotEmpty) msg = serverMsg;
        } catch (_) {}

        errorMessage.value = msg;
      }
    } catch (e) {
      comparison.value = null;
      errorMessage.value = "Error calculating loan comparison: $e";
      print("Error calculating loan comparison: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
