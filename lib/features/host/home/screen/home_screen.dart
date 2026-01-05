import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconic/features/user/user%20navbar/navbar_controller.dart';
import '../../../auth/text editing controller/custom_text_editing_controller.dart';
import '../../profile/my_profile/controller/my_profile_controller.dart';
import '../controller/create_cart_api_controller.dart';
import '../controller/home_api_controller.dart';
import '../controller/searching_api_controller.dart';
import '../model/all_product_model.dart';
import '../widget/body_widget.dart';
import '../widget/search_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  
  final CustomTextEditingController textEditingController = Get.find<CustomTextEditingController>();
  final HomeApiController homeApiController = Get.find<HomeApiController>();
  final ProfileApiController myProfileController = Get.find<ProfileApiController>();
  final CreateCartApiController createCartApiController = Get.find<CreateCartApiController>();
  final SearchingApiController searchingApiController = Get.find<SearchingApiController>();
  
  // Create scroll controller for pagination
  final ScrollController _scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    // Set up scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (textEditingController.searchingController.text.isEmpty) {
          homeApiController.loadMoreProducts();
        }
      }
    });
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await homeApiController.refreshProducts();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Profile AppBar
              /*Obx(() {
                final data = myProfileController.userProfile.value;
                return HomeAppBarWidget(
                  name: "${data.firstName ?? ''} ${data.lastName ?? ''}".trim(),
                  imageUrl: data.profileImage ?? '',
                  notificationCount: 2,
                  onNotificationTap: () {
                    Get.to(() => NotificationScreen());
                  },
                  onProfileTap: () {},
                );
              }),*/
              
              const SizedBox(height: 20),
              
              // Search Bar
              SearchWidget(
                height: 56,
                width: double.infinity,
                searchingController: textEditingController.searchingController,
                onChanged: (value) {
                  searchingApiController.searchProducts(value.trim());
                },
                onTap: () {},
              ),
              
              const SizedBox(height: 10),
              
              // Main content with pagination
              Expanded(
                child: Obx(() {
                  final searchText = textEditingController.searchingController.text.trim();
                  
                  // Search results
                  if (searchText.isNotEmpty) {
                    if (searchingApiController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (searchingApiController.productModel.isEmpty) {
                      return _buildEmptyState("No products found", "Try searching something else");
                    }
                    return _buildProductGrid(
                      searchingApiController.productModel.toList(),
                      showPagination: false,
                    );
                  }
                  
                  // Home products with pagination
                  if (homeApiController.isLoading.value && homeApiController.productModel.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (homeApiController.errorMessage.isNotEmpty && homeApiController.productModel.isEmpty) {
                    return _buildErrorState(homeApiController.errorMessage.value);
                  }
                  
                  if (homeApiController.productModel.isEmpty) {
                    return _buildEmptyState("No products available", "Pull down to refresh");
                  }
                  
                  return _buildProductGrid(
                    homeApiController.productModel.toList(),
                    showPagination: true,
                    scrollController: _scrollController,
                    hasMore: homeApiController.hasMore.value,
                    isLoadingMore: homeApiController.isMoreLoading.value,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Grid builder with pagination support
  Widget _buildProductGrid(
    List<ProductModel> products, {
    bool showPagination = true,
    ScrollController? scrollController,
    bool hasMore = false,
    bool isLoadingMore = false,
  }) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          final maxScroll = scrollController?.position.maxScrollExtent ?? 0;
          final currentScroll = scrollController?.position.pixels ?? 0;
          
          // Load more when reaching bottom
          if (currentScroll >= maxScroll * 0.7) { // Load when 70% scrolled
            if (showPagination && hasMore && !isLoadingMore) {
              homeApiController.loadMoreProducts();
            }
          }
        }
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 178 / 320,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = products[index];
                return BodyWidget(
                  productImage: product.image ?? '',
                  productName: product.title ?? 'No Title',
                  productPrice: "\$${product.price ?? '0'}",
                  addToCard: () => _addToCart(product),
                );
              },
              childCount: products.length,
            ),
          ),
          
          // Load more indicator at the bottom
          if (showPagination && hasMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: isLoadingMore 
                    ? const CircularProgressIndicator()
                    : Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Pull up to load more",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                ),
              ),
            ),
          
          // End of list indicator
          if (showPagination && !hasMore && products.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    "No more products",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
  
  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          const Text("Something went wrong", style: TextStyle(fontSize: 18, color: Colors.red)),
          Text(error, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => homeApiController.homeApiMethod(isRefresh: true),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
  
  Future<void> _addToCart(ProductModel product) async {
    if (product.id == null) {
      Get.snackbar("Error", "Invalid product", backgroundColor: Colors.red);
      return;
    }
    
    final bool success = await createCartApiController.createCartApiMethod(
      productId: product.id.toString(),
      price: product.price.toString(),
      quantity: (product.quantity ?? 1).toString(),
    );
    
    if (success) {
      Get.find<UserBottomNavbarController>().goToCart();
     //et.snackbar("Success", "Added to cart!", backgroundColor: Colors.green);
    }
  }
}