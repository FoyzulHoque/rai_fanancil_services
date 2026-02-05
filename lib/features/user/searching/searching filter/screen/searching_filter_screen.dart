import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

import '../../../../auth/text editing controller/custom_text_editing_controller.dart';
import '../../controller/all_properties_controller.dart';
import '../../screen/filtter_searching_screen.dart';
import '../../widget/search_widget.dart';
import '../controller/pricing_controller.dart';
import '../controller/select_button_controller.dart';
import '../widget/pricing_max_min_widget.dart';
import '../widget/row_type_custom_button.dart';
import '../widget/selectable_container_button.dart';

class SearchingFilterScreen extends StatelessWidget {
  SearchingFilterScreen({super.key}) {
    // ✅ ensure global controller exists
    CustomTextEditingController.initialize();

    // ✅ create PriceRangeController once (tag)
    if (!Get.isRegistered<PriceRangeController>(tag: priceTag)) {
      Get.put(
        PriceRangeController(
          minLimit: 100000,
          maxLimit: 5000000,
          initialMin: 300000,
          initialMax: 1500000,
          onChanged: (min, max) {
            selectedMin.value = min.round();
            selectedMax.value = max.round();
          },
        ),
        tag: priceTag,
      );
    }

    selectedMin.value = 300000;
    selectedMax.value = 1500000;
  }

  final String priceTag = "search_price";

  final RxInt selectedMin = 300000.obs;
  final RxInt selectedMax = 1500000.obs;

  final CustomTextEditingController customTextEditingController =
  Get.find<CustomTextEditingController>();

  final SearchingFilterController filterCtrl =
  Get.put(SearchingFilterController());

  final AllPropertiesController allPropertiesController =
  Get.find<AllPropertiesController>();

  void _resetAll() {
    // ✅ property type reset
    filterCtrl.reset();

    // ✅ dropdown reset to default
    customTextEditingController.selectedROIGrowthFilter.value = 'Select';
    customTextEditingController.selectedLoanTerm.value = 'Select';

    // ✅ location reset
    customTextEditingController.clearLocationIfAny();

    // ✅ price reset local
    selectedMin.value = 300000;
    selectedMax.value = 1500000;

    // ✅ reset slider widget without UI change
    if (Get.isRegistered<PriceRangeController>(tag: priceTag)) {
      Get.delete<PriceRangeController>(tag: priceTag, force: true);
    }
    Get.put(
      PriceRangeController(
        minLimit: 100000,
        maxLimit: 5000000,
        initialMin: 300000,
        initialMax: 1500000,
        onChanged: (min, max) {
          selectedMin.value = min.round();
          selectedMax.value = max.round();
        },
      ),
      tag: priceTag,
    );
  }

  Future<void> _applyAndGo() async {
    final location = customTextEditingController.getLocationText().trim();
    final propertyType = filterCtrl.selectedPropertyType.value.trim();

    final roiGrowth = customTextEditingController.selectedROIGrowthFilter.value;
    final loanTerm = customTextEditingController.selectedLoanTerm.value;

    // ✅ convert "Select" -> ""
    final roi = (roiGrowth == 'Select') ? "" : roiGrowth.trim();
    final loan = (loanTerm == 'Select') ? "" : loanTerm.trim();

    await allPropertiesController.applyFilters(
      search: location,
      min: selectedMin.value,
      max: selectedMax.value,
      propertyType: propertyType,
      roiGrowthValue: roi,
      loanTermValue: loan,
      bed: "",
      bath: "",
    );
    Get.to(() => const FilterSearchingResultScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _resetAll,
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
              const Text("Location"),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                ),
                child: SearchsWidget(), // ✅ unchanged UI (but must use permanent controller)
              ),

              const SizedBox(height: 12),

              const Text(
                "Property Type",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Obx(
                    () => Container(
                  width: 272,
                  height: 130,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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

              PriceRangeWidget(tag: priceTag), // ✅ unchanged
              const SizedBox(height: 20),

              const Text(
                "ROI / Growth Filter",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Obx(() {
                final selected =
                    customTextEditingController.selectedROIGrowthFilter.value;

                final currentValue =
                customTextEditingController.growthFilter.contains(selected)
                    ? selected
                    : null;

                return DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: currentValue,
                  onChanged: (value) {
                    customTextEditingController.selectedROIGrowthFilter.value =
                        value ?? 'Select';
                  },
                  decoration: InputDecoration(
                    hintText: 'Select',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                  items: customTextEditingController.growthFilter
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                );
              }),

              const SizedBox(height: 10),

              const Text(
                "Loan Term",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Obx(() {
                final selected =
                    customTextEditingController.selectedLoanTerm.value;

                final currentValue =
                customTextEditingController.loanTerm.contains(selected)
                    ? selected
                    : null;

                return DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: currentValue,
                  onChanged: (value) {
                    customTextEditingController.selectedLoanTerm.value =
                        value ?? 'Select';
                  },
                  decoration: InputDecoration(
                    hintText: 'Select',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                  items: customTextEditingController.loanTerm
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                );
              }),

              const SizedBox(height: 30),

              RowTypeCustomButton(
                borderColorLeft: AppColors.infoSecondary,
                borderColorRight: AppColors.primary,
                leftButtonText: "Clear All",
                rightButtonText: "Add property",
                leftTextColor: AppColors.infoSecondary,
                rightTextColor: AppColors.white,

                // ✅ keep same UI + correct behavior
                onTapUseInCalculator: _resetAll, // Clear All
                onTapAddProperty: _applyAndGo, // Apply + Go result page
              ),
            ],
          ),
        ),
      ),
    );
  }
}
