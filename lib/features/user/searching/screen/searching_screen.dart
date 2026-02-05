import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/features/user/searching/controller/all_properties_controller.dart';
import '../../../../core/themes/app_colors.dart';
import '../searching filter/screen/searching_filter_screen.dart';
import '../widget/search_screen_body_widget.dart';
import '../widget/searching_body_head_widget.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  final AllPropertiesController allPropertiesController = Get.find();

  final ScrollController _scrollController = ScrollController();

  // ✅ realtime search
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // ✅ load more when reaching bottom
    _scrollController.addListener(() async {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 200) {
        await allPropertiesController.loadMore();
      }
    });

    // ✅ realtime search listener
    _searchCtrl.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // debounce so API doesn't spam
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final term = _searchCtrl.text.trim();

      // ✅ this method should trigger API reload (page=1)
      await allPropertiesController.setSearchTerm(term);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.secondaryColors,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Property Search',
              style: TextStyle(color: AppColors.white, fontSize: 22),
            ),
            const SizedBox(height: 12),

            // ✅ UI same: Search + Filter icon
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: _SearchField(
                      controller: _searchCtrl,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SearchingFilterScreen());
                    },
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: Image.asset(
                        "assets/icons/Scan.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return allPropertiesController.refreshProperties();
        },
        color: AppColors.primary,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchingBodyHeadWidget(
                  price1: "500",
                  price2: "1",
                  apartment: "Apartment",
                ),
                const SizedBox(height: 10),

                Obx(() {
                  // first loading
                  if (allPropertiesController.isLoading.value &&
                      allPropertiesController.properties.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (allPropertiesController.properties.isEmpty) {
                    final msg = allPropertiesController.errorMessage.value.trim().isEmpty
                        ? "No properties found"
                        : allPropertiesController.errorMessage.value;
                    return Center(child: Text(msg));
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allPropertiesController.properties.length,
                        itemBuilder: (context, index) {
                          final property =
                          allPropertiesController.properties[index];

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SearchScreenBodyWidget(
                              image: property.imageUrl ?? "",
                              baths: property.baths?.toString() ?? "0",
                              beds: property.beds?.toString() ?? "0",
                              location: property.address ?? "",
                              price: property.price?.toString() ?? "",
                              leftButtonText: '+Add property',
                              leftTextColor: AppColors.black,
                              onTapAddProperty: () {
                                allPropertiesController.saveProperty(
                                  property.id.toString(),
                                );
                              },
                              borderColorLeft: AppColors.grey,
                              rightButtonText: 'Use in Calculator',
                              rightTextColor: AppColors.white,
                              onTapUseInCalculator: () {},
                              borderColorRight: AppColors.primary,
                            ),
                          );
                        },
                      ),

                      // load more loader
                      if (allPropertiesController.isLoading.value)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                }),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ Search input (keeps same UI height/shape)
class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search property...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
