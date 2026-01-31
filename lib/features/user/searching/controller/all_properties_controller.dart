import 'dart:developer';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/network_musfik/service.dart';
import 'package:rai_fanancil_services/core/network_path/natwork_path.dart';
import '../modal/all_properties_modal.dart';

class AllPropertiesController extends GetxController {
  final isLoading = false.obs;
  final networkCaller = NetworkCaller();
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NmRiYzU5ZmFhN2U2MmM4OTk0Mzk3NiIsImVtYWlsIjoicmFmc2Fuc2F5ZWQxMzJAZ21haWwuY29tIiwicm9sZSI6IlVzZXIiLCJlbWFpbFZlcmlmaWNhdGlvbiI6dHJ1ZSwiaXNGaW5hbmNpYWxQcm9maWxlQ29tcGxldGUiOnRydWUsImlhdCI6MTc2OTg0MTYzOCwiZXhwIjoxODAxMzc3NjM4fQ.Ci57ZPiOMWraRRd4XcAQZBnv5Yj4vFGLpyiBkixkIRo";

  final allPropertiesData = <AllPropertiesDatum>[].obs;
  Meta? meta; // store pagination info if needed

  @override
  void onInit() {
    fetchAllProperties();
    super.onInit();
  }

  Future<void> fetchAllProperties() async {
    try {
      isLoading.value = true;
      final response = await networkCaller.getRequest(
        Urls.allProperties,
        token: token,
      );

      log(response.responseData.toString());

      if (response.statusCode == 200 || response.isSuccess) {
        final parsed = AllPropertiesResponse.fromJson(
          response.responseData as Map<String, dynamic>,
        );

        allPropertiesData.assignAll(parsed.data?.data ?? []);
        // meta = parsed.data?.meta;
      } else {
        log("Error: ${response.errorMessage}");
      }
    } catch (e) {
      log("Fetching all error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async => fetchAllProperties();
}
