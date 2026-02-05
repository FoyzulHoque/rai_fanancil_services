import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/network_path/natwork_path.dart';
import '../models/suburb_profile_models.dart';

class SuburbProfileController extends GetxController {
  final TextEditingController postcodeController = TextEditingController();

  final Rxn<SuburbProfileResponse> profile = Rxn<SuburbProfileResponse>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ✅ UI state: initially false -> only input + Calculate
  final RxBool showResult = false.obs;

  // ✅ chart toggle: 5Y default
  final RxBool isTenYear = false.obs;

  @override
  void onClose() {
    postcodeController.dispose();
    super.onClose();
  }

  void setToggle(bool tenYear) {
    isTenYear.value = tenYear;
  }

  Future<void> calculate() async {
    final postcode = postcodeController.text.trim();

    if (postcode.isEmpty) {
      errorMessage.value = "Please enter postcode.";
      showResult.value = false;
      profile.value = null;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    profile.value = null;

    try {
      final String? token = await Urls.token;
      final Uri url = Uri.parse("${Urls.baseUrl}/calculators/suburb-profile");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode({"postcode": postcode}),
      );

      print("Suburb Profile API Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final parsed = SuburbProfileResponse.fromJson(jsonMap);

        final ok = parsed.success == true && parsed.data != null;

        if (ok) {
          profile.value = parsed;
          showResult.value = true;
        } else {
          showResult.value = false;
          profile.value = null;
          errorMessage.value = (parsed.message ?? '').trim().isNotEmpty
              ? parsed.message!.trim()
              : "No suburb profile found.";
        }
      } else {
        showResult.value = false;
        profile.value = null;

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
      showResult.value = false;
      profile.value = null;
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
