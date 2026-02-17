import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network_path/natwork_path.dart';
import '../model/financial_profile_model.dart';

class FinancialProfileController extends GetxController {
  final isLoading = false.obs;
  // Holds full response if you want message/statusCode too
  final financialProfileModel = Rxn<FinancialProfileModel>();

  // Holds only the nested "data" object (most UI needs this)
  final profileData = Rxn<FinancialProfileData>();

  @override
  void onInit() {
    super.onInit();
    fetchFinancialProfile();
  }

  Future<void> fetchFinancialProfile() async {
    isLoading.value = true;

    final String? token = await Urls.token;
    final Uri url = Uri.parse("${Urls.baseUrl}/financial-profile/get");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = FinancialProfileModel.fromJson(decoded);

        financialProfileModel.value = model;
        profileData.value = model.data;

        log("Financial profile loaded: ${model.data.id}");
      } else {
        // handle API error shape
        final msg = (decoded['message'] ?? 'Failed to load financial profile').toString();
        log("FinancialProfile failed: $msg");

        financialProfileModel.value = null;
        profileData.value = null;

        Get.snackbar("Error", msg);
      }
    } catch (e) {
      log("FinancialProfile exception: $e");

      financialProfileModel.value = null;
      profileData.value = null;

      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
