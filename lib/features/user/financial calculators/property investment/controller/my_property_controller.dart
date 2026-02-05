import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../models/my_property_model.dart';

class MyPropertyController extends GetxController {
  // ✅ Single property response (API returns ONE object)
  final Rxn<MyPropertyModel> property = Rxn<MyPropertyModel>();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProperty();
  }

  Future<void> fetchProperty() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final String? token = await Urls.token;
      final url =
      Uri.parse("${Urls.baseUrl}/financial-profile/get-my-property");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("My Property API Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final parsed = MyPropertyModel.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {
          property.value = parsed;
          print(
              "Property loaded: ${parsed.data.propertyDetails.length} property detail(s)");
        } else {
          property.value = null;
          errorMessage.value =
          parsed.message.isNotEmpty ? parsed.message : "No property found.";
        }
      } else {
        property.value = null;
        errorMessage.value =
        "Failed to fetch property. Status code: ${response.statusCode}";
      }
    } catch (e) {
      property.value = null;
      errorMessage.value = "Error fetching property: $e";
      print("Error fetching property: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------ Refresh Method ------------------
  Future<void> refreshProperty() async {
    await fetchProperty();
  }
}
