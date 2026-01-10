import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

import '../../../../auth/text editing controller/custom_text_editing_controller.dart';
import '../../widget/search_widget.dart';
import '../controller/pricing_controller.dart';
import '../controller/select_button_controller.dart';
import '../widget/import_property_widget.dart';
import '../widget/pricing_max_min_widget.dart';
import '../widget/row_type_custom_button.dart';
import '../widget/selectable_container_button.dart';

class SearchingFilterScreen extends StatelessWidget {
  SearchingFilterScreen({super.key}) {
    /// ✅ Put controller here
    Get.put(
      PriceRangeController(
        minLimit: 100000,
        maxLimit: 5000000,
        initialMin: 300000,
        initialMax: 1500000,
        onChanged: (min, max) {
          print("Selected Price => Min: $min , Max: $max");

          // 🔥 use for API / filter
          // filterCtrl.minPrice = min;
          // filterCtrl.maxPrice = max;
        },
      ),
      tag: priceTag,
    );
  }

  final String priceTag = "search_price";

  final CustomTextEditingController customTextEditingController =
      Get.find<CustomTextEditingController>();

  final SearchingFilterController filterCtrl = Get.put(
    SearchingFilterController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: filterCtrl.reset,
            child: Text(
              "Reset",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -----------------------------Location---------------------------
              const Text("Location"),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                ),
                child: SearchsWidget(),
              ),

              const SizedBox(height: 12),

              /// ----------------------------Import Property------------------------------
              ImportPropertyWidget(
                onTab: () => customTextEditingController.pickImage(),
              ),

              const SizedBox(height: 16),

              /// --------------------------Property Type----------------------------------
              const Text(
                "Property Type",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Obx(
                () => Container(
                  width: 272,
                   height:130 ,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filterCtrl.items.map((item) {
                      return SelectableContainerButton(
                        text: item,
                        isSelected: filterCtrl.selectedPropertyType.value == item,
                        onTap: () => filterCtrl.selectItem(item),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// -----------------------------------PRICE RANGE-----------------------------------
              /// ✅ PRICE RANGE (WORKING)
              PriceRangeWidget(tag: priceTag),
              const SizedBox(height: 20),

              ///-----------------------------ROI / Growth Filter Dropdown Button------------------------
              const Text(
                "ROI / Growth Filter",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Obx(() {
                // Ensure the value exists in the items, otherwise set it to null
                final String? currentValue =
                    customTextEditingController.growthFilter.contains(
                      customTextEditingController.selectedROIGrowthFilter.value,
                    )
                    ? customTextEditingController.selectedROIGrowthFilter.value
                    : null;

                return DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: currentValue,
                  onChanged: (value) =>
                      customTextEditingController
                              .selectedROIGrowthFilter
                              .value =
                          value!,
                  decoration: InputDecoration(
                    hintText: 'Select',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                  ),
                  items: customTextEditingController.growthFilter
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                );
              }),
              const SizedBox(height: 10),
              ////-------------------------Loan Term Dropdown Button----------------------------
              const Text(
                "Loan Term",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Obx(() {
                // Ensure the value exists in the items, otherwise set it to null
                final String? currentValue =
                    customTextEditingController.loanTerm.contains(
                      customTextEditingController.selectedROIGrowthFilter.value,
                    )
                    ? customTextEditingController.selectedLoanTerm.value
                    : null;

                return DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: currentValue,
                  onChanged: (value) =>
                      customTextEditingController.selectedLoanTerm.value =
                          value!,
                  decoration: InputDecoration(
                    hintText: 'Select',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                  ),
                  items: customTextEditingController.loanTerm
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                );
              }),
              /// ------------------Clear All & Add Property----------------------------------
              const SizedBox(height: 30),
              RowTypeCustomButton(
                borderColorLeft: AppColors.infoSecondary,
                borderColorRight: AppColors.primary,
                leftButtonText: "Clear All",
                rightButtonText: "Add property",
                leftTextColor: AppColors.infoSecondary,
                rightTextColor: AppColors.white,
                onTapAddProperty: () {},
                onTapUseInCalculator: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
