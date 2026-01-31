import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/income_details_property_drop_down_controller.dart';
import '../controller/tax_region_state_dropdown_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import 'living_expenses.dart'; // if not used, you can remove this import

class IncomeDetailsScreen extends StatelessWidget {
  IncomeDetailsScreen({super.key});

  final TextEditingController _propertyController1 = TextEditingController();

  final IncomeDetailsPropertyDropdownController propertyDropdownController = Get.put(
    IncomeDetailsPropertyDropdownController(),
  );
  final PrimaryIncomeDropdownController primaryIncomeDropdownController = Get.put(
    PrimaryIncomeDropdownController(),
  );

  final TaxRegionStateDropdownController taxRegionStateDropdownController = Get.put(
    TaxRegionStateDropdownController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBarSetBeforeNaveBar(
            title: "Income Details",
            currentStep: 2,
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

                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dropdown section
                          Text(
                            "Select Adults",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(() {
                            final props = propertyDropdownController.properties;

                            // Loading / empty state
                            if (props.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            // Auto-select first item if nothing selected yet
                            if (propertyDropdownController.selectedProperty.value == null) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                propertyDropdownController.selectedProperty.value = props.first;
                              });
                            }

                            return DropdownButtonFormField<String?>(
                              value: propertyDropdownController.selectedProperty.value,
                              hint: const Text("Select Property"),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // nicer look
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.blueGrey,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              isExpanded: true,
                              items: props.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: propertyDropdownController.changeProperty,
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Primary Income Card
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Primary Income",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Your main employment or business income",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(() {
                              final props = primaryIncomeDropdownController.propertiesIcom;

                              // Loading / empty state
                              if (props.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              // Auto-select first item if nothing selected yet
                              if (primaryIncomeDropdownController.selectedProperty.value == null) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  primaryIncomeDropdownController.selectedProperty.value = props.first;
                                });
                              }

                              return DropdownButtonFormField<String?>(
                                value: primaryIncomeDropdownController.selectedProperty.value,
                                hint: const Text("Select Property"),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0), // nicer look
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.blueGrey,
                                ),
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                isExpanded: true,
                                items: props.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: primaryIncomeDropdownController.changeProperty,
                              );
                            }),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.monetization_on_outlined),
                              controller: _propertyController1,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
                          ],
                        ),
                      ),
                    ),
                    //---dropdown field-----------------------
                    const SizedBox(height: 24),
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Dropdown section
                            Text(
                              "Property Type",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              "How often you receive income",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Obx(() {
                              final props = propertyDropdownController.properties;

                              // Loading / empty state
                              if (props.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              // Auto-select first item if nothing selected yet
                              if (propertyDropdownController.selectedProperty.value == null) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  propertyDropdownController.selectedProperty.value = props.first;
                                });
                              }

                              return DropdownButtonFormField<String?>(
                                value: propertyDropdownController.selectedProperty.value,
                                hint: const Text("Select Property"),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), // nicer look
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.blueGrey,
                                ),
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                isExpanded: true,
                                items: props.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: propertyDropdownController.changeProperty,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    //---input field-----------------------
                    const SizedBox(height: 24),

                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Other Income (Optional)",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Rental income, business income, or other sources",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.monetization_on_outlined),
                              controller: _propertyController1,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
                          ],
                        ),
                      ),
                    ),
                    //---dropdown field-----------------------
                    const SizedBox(height: 24),
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Dropdown section
                            Text(
                              "Tax Region/State",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              "Your primary state of residence for tax purposes",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Obx(() {
                              final props = taxRegionStateDropdownController.properties;

                              // Loading / empty state
                              if (props.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              // Auto-select first item if nothing selected yet
                              if (taxRegionStateDropdownController.selectedProperty.value == null) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  taxRegionStateDropdownController.selectedProperty.value = props.first;
                                });
                              }

                              return DropdownButtonFormField<String?>(
                                value: taxRegionStateDropdownController.selectedProperty.value,
                                hint: const Text("Select Property"),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), // nicer look
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.blueGrey,
                                ),
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                isExpanded: true,
                                items: props.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: taxRegionStateDropdownController.changeProperty,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Add more fields here if needed (e.g. HowManyBorrowingAdultsWidget)

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
                Get.to(() => LivingExpensesScreen());
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