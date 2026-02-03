import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/features/user/searching/controller/all_properties_controller.dart';
import '../../../../core/themes/app_colors.dart';
import '../searching filter/screen/searching_filter_screen.dart';
import '../widget/search_screen_body_widget.dart';
import '../widget/search_widget.dart';
import '../widget/searching_body_head_widget.dart';

class SearchingScreen extends StatelessWidget {
  SearchingScreen({super.key});
  final AllPropertiesController allPropertiesController = Get.find();

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

            // ✅ FIX
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(child: SearchsWidget()),
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
          return allPropertiesController.refreshData();
        },
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                  if (allPropertiesController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (allPropertiesController.allPropertiesData.isEmpty) {
                    return const Center(child: Text("No properties found"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allPropertiesController.allPropertiesData.length,
                    itemBuilder: (context, index) {
                      final property =
                          allPropertiesController.allPropertiesData[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SearchScreenBodyWidget(
                          image: property.imageUrl,
                          baths: property.baths?.toString() ?? "0",
                          beds: property.beds?.toString() ?? "0",
                          location: property.address ?? "",
                          price: property.price?.toString() ?? "",
                          leftButtonText: '+Add property',
                          leftTextColor: AppColors.black,
                          onTapAddProperty: () {},
                          borderColorLeft: AppColors.grey,
                          rightButtonText: 'Use in Calculator',
                          rightTextColor: AppColors.white,
                          onTapUseInCalculator: () {},
                          borderColorRight: AppColors.primary,
                        ),
                      );
                    },
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
