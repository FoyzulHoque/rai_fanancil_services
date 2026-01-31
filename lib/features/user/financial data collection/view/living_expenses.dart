import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/financial%20data%20collection/view/property_details.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/finacial_data_collection_text_editing_controller.dart';
import '../controller/income_details_property_drop_down_controller.dart';
import '../controller/tax_region_state_dropdown_controller.dart';
import '../widget/check_box_widget.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';

class LivingExpensesScreen extends StatefulWidget {
  LivingExpensesScreen({super.key});

  @override
  State<LivingExpensesScreen> createState() => _LivingExpensesScreenState();
}

class _LivingExpensesScreenState extends State<LivingExpensesScreen> {

  final FinacialDataCollectionTextEditingController finacialDataCollectionTextEditingController = Get.put(FinacialDataCollectionTextEditingController());

  final IncomeDetailsPropertyDropdownController propertyDropdownController = Get.put(IncomeDetailsPropertyDropdownController());  // Keep this line only once

  final TextEditingController _propertyController1 = TextEditingController();
  List<String> _selectedResidences = []; // Changed to a list

  final TaxRegionStateDropdownController taxRegionStateDropdownController = Get.put(TaxRegionStateDropdownController());

  @override
  Widget build(BuildContext context) {
    String _period = "Weekly";
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Header (fixed at top)
          CustomAppBarSetBeforeNaveBar(
            title: "Household & Borrowing Profile",
            currentStep: 3,
            totalSteps: 6,
            appBarColor: AppColors.secondaryColors,
          ),

          // Scrollable body
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---Check box field-----------------------
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CheckBoxWidget(
                          selectedOptions: finacialDataCollectionTextEditingController.selectedResidences, // Pass the list
                          onChanged: (newValue) {
                            setState(() {
                              if (finacialDataCollectionTextEditingController.selectedResidences.contains(newValue)) {
                                finacialDataCollectionTextEditingController.selectedResidences.remove(newValue); // Unselect
                              } else {
                                finacialDataCollectionTextEditingController.selectedResidences.add(newValue); // Select
                              }
                            });
                            print("Selected residences: ${finacialDataCollectionTextEditingController.selectedResidences}"); // for debug
                          },
                        ),
                      ),
                    ),
                    // Continue with the rest of the UI...
                  ],
                ),
              ),
            ),
          ),

          // Fixed bottom button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Validate + Navigate
                Get.to(() => PropertyDetailsScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
