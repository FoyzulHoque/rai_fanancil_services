import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../model/insurance_council_models.dart';
import '../screen/cost_estimates_screen.dart';

class InsuranceCouncilController extends GetxController {
  final Rxn<InsuranceCouncilResponse> result = Rxn<InsuranceCouncilResponse>();

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

  Future<void> calculateInsuranceCouncil({
    required String suburb,
    required String propertyType,
    required TextEditingController bedroomsCtrl,
    required TextEditingController bathroomsCtrl,
    required TextEditingController buildingAreaCtrl,
    required String buildType,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    result.value = null;

    try {
      final String? token = await Urls.token;
      final Uri url =
      Uri.parse("${Urls.baseUrl}/calculators/insurance-council");

      final body = {
        "suburb": suburb.trim(),
        "propertyType": propertyType.trim(),
        "bedrooms": _toInt(bedroomsCtrl.text),
        "bathrooms": _toInt(bathroomsCtrl.text),
        "buildingAreaSqm": _toDouble(buildingAreaCtrl.text),
        // API expects "New" or "Established"
        "buildType": buildType.trim(),
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      );

      print(
          "Insurance Council API Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final parsed = InsuranceCouncilResponse.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {

          Get.to(() => CostEstimatesScreen());
          result.value = parsed;
        } else {
          result.value = null;
          errorMessage.value = (parsed.message ?? '').trim().isNotEmpty
              ? parsed.message!.trim()
              : "No cost estimate data found.";
        }
      } else {
        result.value = null;

        String msg =
            "Failed to calculate. Status code: ${response.statusCode}";
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
      errorMessage.value = "Error: $e";
      print("Insurance council error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
