import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/network_path/natwork_path.dart';
import '../models/borrowing_overview_models.dart';

class BorrowingController extends GetxController {
  final Rxn<BorrowingOverviewResponse> borrowing =
  Rxn<BorrowingOverviewResponse>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBorrowingOverview();
  }

  Future<void> fetchBorrowingOverview() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final String? token = await Urls.token;
      final Uri url = Uri.parse("${Urls.baseUrl}/calculators/borrowing-overview");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print(
          "Borrowing Overview API Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final BorrowingOverviewResponse parsed =
        BorrowingOverviewResponse.fromJson(jsonMap);

        final bool ok = parsed.success == true && parsed.data != null;

        if (ok) {
          borrowing.value = parsed;
        } else {
          borrowing.value = null;
          errorMessage.value = (parsed.message ?? '').trim().isNotEmpty
              ? parsed.message!.trim()
              : "No borrowing overview data found.";
        }
      } else {
        borrowing.value = null;

        String msg =
            "Failed to fetch borrowing overview. Status code: ${response.statusCode}";
        try {
          final Map<String, dynamic> err =
          jsonDecode(response.body) as Map<String, dynamic>;
          final String serverMsg = (err['message'] ?? '').toString().trim();
          if (serverMsg.isNotEmpty) msg = serverMsg;
        } catch (_) {}

        errorMessage.value = msg;
      }
    } catch (e) {
      borrowing.value = null;
      errorMessage.value = "Error fetching borrowing overview: $e";
      print("Error fetching borrowing overview: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshBorrowingOverview() async {
    await fetchBorrowingOverview();
  }
}
