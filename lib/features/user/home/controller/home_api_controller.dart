import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../model/all_product_model.dart';

class HomeApiController extends GetxController {
  final RxList<ProductModel> productModel = <ProductModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isMoreLoading = false.obs; // For pagination loading
  final RxString errorMessage = ''.obs;
  final RxBool hasMore = true.obs; // To check if more data is available
  
  // Pagination variables
  int currentPage = 1;
  int limit = 10; // Should match your API limit
  
  // Initial fetch
  Future<void> homeApiMethod({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        // Reset for pull-to-refresh
        currentPage = 1;
        productModel.clear();
        hasMore.value = true;
      }
      
      isLoading.value = true;
      errorMessage.value = '';
      
      final response = await NetworkCall.getRequest(
        url: '${Urls.allProduct}?page=$currentPage&limit=$limit'
      ).timeout(const Duration(seconds: 30));
      
      if (response.isSuccess && response.responseData != null) {
        final innerData = response.responseData!['data'];
        
        if (innerData is Map<String, dynamic>) {
          final productResponse = ProductListResponse.fromJson(innerData);
          
          // Check if we got products
          if (productResponse.data != null && productResponse.data!.isNotEmpty) {
            if (isRefresh) {
              productModel.assignAll(productResponse.data!);
            } else {
              productModel.addAll(productResponse.data!);
            }
            
            // Check if there are more pages
            final totalPages = productResponse.meta?.totalPage ?? 0;
            hasMore.value = currentPage < totalPages;
            
            debugPrint("Loaded ${productResponse.data!.length} products from page $currentPage");
            debugPrint("Total products: ${productModel.length}");
          } else {
            if (isRefresh) productModel.clear();
            if (!hasMore.value) errorMessage.value = "No more products";
          }
        } else {
          errorMessage.value = "Invalid data structure";
        }
      } else {
        errorMessage.value = response.errorMessage ?? "Failed to load products";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
      debugPrint("Home API Error: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }
  
  // Load more products for pagination
  Future<void> loadMoreProducts() async {
    // Don't load if already loading or no more data
    if (isMoreLoading.value || !hasMore.value) return;
    
    try {
      isMoreLoading.value = true;
      currentPage++;
      
      final response = await NetworkCall.getRequest(
        url: '${Urls.allProduct}?page=$currentPage&limit=$limit'
      ).timeout(const Duration(seconds: 30));
      
      if (response.isSuccess && response.responseData != null) {
        final innerData = response.responseData!['data'];
        
        if (innerData is Map<String, dynamic>) {
          final productResponse = ProductListResponse.fromJson(innerData);
          
          if (productResponse.data != null && productResponse.data!.isNotEmpty) {
            productModel.addAll(productResponse.data!);
            
            // Update hasMore based on pagination
            final totalPages = productResponse.meta?.totalPage ?? 0;
            hasMore.value = currentPage < totalPages;
            
            debugPrint("Loaded more ${productResponse.data!.length} products from page $currentPage");
          } else {
            hasMore.value = false;
          }
        }
      }
    } catch (e) {
      debugPrint("Load more error: $e");
      currentPage--; // Rollback page on error
    } finally {
      isMoreLoading.value = false;
    }
  }
  
  // Refresh function
  Future<void> refreshProducts() async {
    await homeApiMethod(isRefresh: true);
  }
  
  @override
  void onInit() {
    super.onInit();
    homeApiMethod();
  }
}