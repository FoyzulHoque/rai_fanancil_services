import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../modal/all_properties_modal.dart';

class AllPropertiesController extends GetxController {
  // ✅ Full response (meta + list)
  final Rxn<AllPropetyResponse> responseModel = Rxn<AllPropetyResponse>();

  // ✅ List for UI
  final RxList<AllPropertyResult> properties = <AllPropertyResult>[].obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // ✅ Pagination
  final RxInt page = 1.obs;
  final RxInt limit = 10.obs;
  final RxInt total = 0.obs;
  final RxBool hasMore = true.obs;

  // ✅ Filters
  final RxString searchTerm = ''.obs;
  final RxDouble minPrice = 1.0.obs;
  final RxDouble maxPrice = 1000000.0.obs;
  final RxString bedrooms = ''.obs;
  final RxString bathrooms = ''.obs;
  final RxString type = ''.obs;
  final RxString roiGrowth = ''.obs;
  final RxString loanTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProperties(reset: true);
  }

  /// ✅ Main fetch method
  /// reset=true -> clears list, sets page=1
  Future<void> fetchAllProperties({
    bool reset = false,
    bool append = false,
    String? search,
    num? min,
    num? max,
    String? bed,
    String? bath,
    String? propertyType,
    String? roiGrowthValue,
    String? loanTermValue,
    int? pageNumber,
    int? limitNumber,
  }) async {
    if (isLoading.value) return;

    if (reset) {
      page.value = 1;
      hasMore.value = true;
      properties.clear();
    }

    // update filters if passed
    if (search != null) searchTerm.value = search.trim();
    if (min != null) minPrice.value = min.toDouble();
    if (max != null) maxPrice.value = max.toDouble();
    if (bed != null) bedrooms.value = bed.trim();
    if (bath != null) bathrooms.value = bath.trim();
    if (propertyType != null) type.value = propertyType.trim();
    if (roiGrowthValue != null) roiGrowth.value = roiGrowthValue.trim();
    if (loanTermValue != null) loanTerm.value = loanTermValue.trim();
    if (pageNumber != null) page.value = pageNumber;
    if (limitNumber != null) limit.value = limitNumber;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final String? token = await Urls.token;

      // ✅ query params (include page + limit)
      final Map<String, String> qp = {
        "minPrice": minPrice.value.toStringAsFixed(0),
        "maxPrice": maxPrice.value.toStringAsFixed(0),
        "bedrooms": bedrooms.value,       // can be ""
        "bathrooms": bathrooms.value,     // can be ""
        "type": type.value,
        "roiGrowth": roiGrowth.value,
        "loanTerm": loanTerm.value,
        "page": page.value.toString(),
        "limit": limit.value.toString(),
      };

      // optional searchTerm
      final st = searchTerm.value.trim();
      if (st.isNotEmpty) {
        qp["searchTerm"] = st;
      }

      // Optional: remove empty filters so backend doesn’t confuse
      qp.removeWhere((k, v) => v.trim().isEmpty && k != "bedrooms" && k != "bathrooms");

      final uri = Uri.parse("${Urls.baseUrl}/properties/all")
          .replace(queryParameters: qp);

      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        final parsed = AllPropetyResponse.fromJson(jsonMap);

        if (parsed.success == true && parsed.data != null) {
          responseModel.value = parsed;

          // ✅ read meta
          final meta = parsed.data?.meta;
          total.value = (meta?.total ?? 0).toInt();
          page.value = (meta?.page ?? page.value).toInt();
          limit.value = (meta?.limit ?? limit.value).toInt();

          final fetched = parsed.data?.data ?? <AllPropertyResult>[];

          // ✅ if backend returns empty -> no more pages
          if (fetched.isEmpty) {
            hasMore.value = false;
          }

          if (append) {
            // ✅ merge uniquely by id (prevents duplicates)
            final existingIds = properties.map((e) => e.id.toString()).toSet();
            final uniqueToAdd = fetched
                .where((e) => !existingIds.contains(e.id.toString()))
                .toList();
            properties.addAll(uniqueToAdd);
          } else {
            properties.assignAll(fetched);
          }

          // ✅ If we already loaded all
          if (total.value > 0 && properties.length >= total.value) {
            hasMore.value = false;
          }
        } else {
          responseModel.value = null;
          if (!append) properties.clear();
          errorMessage.value = parsed.message ?? "No property found.";
          hasMore.value = false;
        }
      } else {
        responseModel.value = null;
        if (!append) properties.clear();
        errorMessage.value = "Failed to fetch properties. Status code: ${res.statusCode}";
        hasMore.value = false;
      }
    } catch (e) {
      responseModel.value = null;
      if (!append) properties.clear();
      errorMessage.value = "Error fetching properties: $e";
      hasMore.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ realtime typing search
  Future<void> setSearchTerm(String term) async {
    searchTerm.value = term.trim();
    await fetchAllProperties(reset: true, append: false);
  }

  /// ✅ Refresh
  Future<void> refreshProperties() async {
    await fetchAllProperties(reset: true, append: false);
  }

  /// ✅ Load more (pagination)
  Future<void> loadMore() async {
    if (isLoading.value) return;
    if (!hasMore.value) return;

    // ✅ if total known and already loaded all
    if (total.value > 0 && properties.length >= total.value) {
      hasMore.value = false;
      return;
    }

    // ✅ next page
    final nextPage = page.value + 1;
    await fetchAllProperties(
      pageNumber: nextPage,
      append: true,
    );
  }

  /// ✅ Apply filters
  Future<void> applyFilters({
    required String search,
    required num min,
    required num max,
    String bed = "",
    String bath = "",
    String propertyType = "",
    String roiGrowthValue = "",
    String loanTermValue = "",
  }) async {
    await fetchAllProperties(
      reset: true,
      append: false,
      search: search,
      min: min,
      max: max,
      bed: bed,
      bath: bath,
      propertyType: propertyType,
      roiGrowthValue: roiGrowthValue,
      loanTermValue: loanTermValue,
    );
  }

  /// ✅ Save property
  /// ⚠️ You MUST replace endpoint with correct one (your current one is wrong).
  Future<void> saveProperty(String propertyId) async {
    if (propertyId.trim().isEmpty) return;

    try {
      final String? token = await Urls.token;

      // ❌ WRONG: /properties/all
      // ✅ TODO: PUT your real save endpoint here:
      final uri = Uri.parse("${Urls.baseUrl}/properties/save"); // <-- CHANGE

      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode({"propertyId": propertyId}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        final ok = jsonMap["success"] == true;
        final msg = (jsonMap["message"] ?? "Saved").toString();

        if (ok) {
          final index = properties.indexWhere((p) => p.id.toString() == propertyId);
          if (index != -1) {
            final old = properties[index];
            properties[index] = AllPropertyResult(
              id: old.id,
              price: old.price,
              address: old.address,
              beds: old.beds,
              baths: old.baths,
              propertyType: old.propertyType,
              imageUrl: old.imageUrl,
              isSaved: true,
              roi: old.roi,
              growthRate: old.growthRate,
            );
          }
          Get.snackbar("Success", msg, snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Error", msg, snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to save property. Status code: ${res.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Error saving property: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
