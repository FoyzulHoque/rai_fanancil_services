import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

import '../../../../auth/text editing controller/custom_text_editing_controller.dart';
import '../../widget/search_widget.dart';
import '../controller/select_button_controller.dart';
import '../widget/import_property_widget.dart';
import '../widget/selectable_container_button.dart';

class SearchingFilterScreen extends StatelessWidget {
  SearchingFilterScreen({super.key});

  final CustomTextEditingController customTextEditingController =
  Get.find<CustomTextEditingController>();

  final SearchingFilterController filterCtrl =
  Get.put(SearchingFilterController());

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
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Location
              const Text("Location"),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                ),
                child: SearchsWidget(),
              ),

              const SizedBox(height: 12),

              /// Import Property
              ImportPropertyWidget(
                onTab: () => customTextEditingController.pickImage(),
              ),

              const SizedBox(height: 16),

              /// Property Type Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Property Type",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),

                    /// 👇 IMPORTANT PART
                    Obx(
                          () => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: filterCtrl.items.map((item) {
                          return SelectableContainerButton(
                            text: item,
                            isSelected:
                            filterCtrl.selectedPropertyType.value == item,
                            onTap: () => filterCtrl.selectItem(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

