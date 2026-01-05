// lib/features/home/controller/searching_api_controller.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../auth/text editing controller/custom_text_editing_controller.dart';
import '../model/all_product_model.dart';

class SearchingApiController extends GetxController {
  final RxList<ProductModel> productModel = <ProductModel>[].obs;
  final CustomTextEditingController customTextEditingController = Get.find<CustomTextEditingController>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Debounce টাইমার
  Timer? _debounce;

  Future<void> searchingApiMethod(String query) async {
    if (query.isEmpty) {
      productModel.clear();
      return;
    }

    isLoading.value = true;

    try {
      final response = await NetworkCall.getRequest(
        url: Urls.allProductSearch(query),
      ).timeout(const Duration(seconds: 30));

      if (response.isSuccess && response.responseData != null) {
        final innerData = response.responseData!['data'];

        if (innerData is Map<String, dynamic>) {
          final productResponse = ProductListResponse.fromJson(innerData);
          productModel.assignAll(productResponse.data ?? []);
        } else {
          productModel.clear();
        }
      } else {
        productModel.clear();
        errorMessage.value = response.errorMessage ?? "Search failed";
      }
    } catch (e) {
      productModel.clear();
      errorMessage.value = "Error: $e";
      debugPrint("Search Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchingApiMethod(query.trim());
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}