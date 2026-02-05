import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/features/user/searching/controller/all_properties_controller.dart';
import '../../../../core/themes/app_colors.dart';
import '../widget/search_screen_body_widget.dart';

class FilterSearchingResultScreen extends StatefulWidget {
  const FilterSearchingResultScreen({super.key});

  @override
  State<FilterSearchingResultScreen> createState() =>
      _FilterSearchingResultScreenState();
}

class _FilterSearchingResultScreenState extends State<FilterSearchingResultScreen> {
  final AllPropertiesController allPropertiesController = Get.find();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() async {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 200) {
        await allPropertiesController.loadMore();
      }
    });

    _searchCtrl.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final term = _searchCtrl.text.trim();
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
          children: const [
            Text(
              'Properties',
              style: TextStyle(color: AppColors.white, fontSize: 22),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => allPropertiesController.refreshProperties(),
        color: AppColors.primary,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                Obx(() {
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
                          final property = allPropertiesController.properties[index];

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

