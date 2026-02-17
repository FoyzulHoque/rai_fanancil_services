import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network_path/natwork_path.dart';

import '../model/user_property_value_trend_modal.dart';

class UserPropertyValueController extends GetxController {
  final selectedTrendType = 'monthly'.obs;
  final propertyValue = <UserPropertyValueDetum>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    userPropertyValue("monthly");
    super.onInit();
  }

  Future<void> userPropertyValue(String type) async {
    isLoading.value = true;
    final String? token = await Urls.token;
    final Uri url = Uri.parse(
      "${Urls.baseUrl}/dashboard/user-property-value-trend?type=$type",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decoded =
        jsonDecode(response.body) as Map<String, dynamic>;

        final List list = (decoded['data'] as List?) ?? [];

        final parsed = list
            .map((e) => UserPropertyValueDetum.fromJson((e as Map<String, dynamic>)))
            .toList();

        propertyValue.assignAll(parsed);
      } else {
        try {
          final Map<String, dynamic> decoded =
          jsonDecode(response.body) as Map<String, dynamic>;
          log("cashFlowTrend failed: ${decoded['message']}");
        } catch (_) {
          log("cashFlowTrend failed: ${response.body}");
        }

        // ✅ keep UI consistent
        propertyValue.clear();
      }
    } catch (e) {
      log(e.toString());
      propertyValue.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
