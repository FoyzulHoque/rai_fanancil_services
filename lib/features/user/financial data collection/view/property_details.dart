import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../../financial calculators/property investment/widget/custom_button_widget.dart';
import '../controller/finacial_data_collection_text_editing_controller.dart';
import '../controller/property_details_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import '../widget/select_button_widget.dart';
import 'assets.dart';

class PropertyDetailsScreen extends StatelessWidget {
  PropertyDetailsScreen({super.key});

  final PropertyController propertyController = Get.put(PropertyController());
  final FinacialDataCollectionTextEditingController finacialDataCollectionTextEditingController = Get.put(FinacialDataCollectionTextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          CustomAppBarSetBeforeNaveBar(
            title: "Property Details",
            currentStep: 4,
            totalSteps: 6,
            appBarColor: AppColors.secondaryColors,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Property Type",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.black),),
                    const SizedBox(height: 16,),
                    //-------------------Select Button-----------------
                    SelectButtonWidget(
                      onSelected: (value) {
                        finacialDataCollectionTextEditingController.selectedPropertyButton.add(value);
                      },   // ← fixed: added empty function (or null)
                    ),
                    const SizedBox(height: 16,),
                    //-------------------Increment Addon Property-----------------
                    for (int i = 0; i < propertyController.properties.length; i++)
                      _buildPropertyCard(i),
                    const SizedBox(height: 8),
                    //-------------------Loan Structure Property-----------------
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: Border.all(style: BorderStyle.none),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan Structure",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Interest Type",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomSegmentSelector(
                              height: 42,
                              borderRadius: 6,
                              backgroundColor: AppColors.btncolor,
                              selectedColor: AppColors.primary,
                              selectedTextColor: Colors.white,
                              unSelectedTextColor: Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Remaining Loan Term (Years)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            CustomInputField(
                              controller: propertyController.properties.isNotEmpty
                                  ? propertyController.properties.last.loanTermController
                                  : TextEditingController(),  // ← fixed: using correct controller
                              keyboardType: TextInputType.text,
                              hintText: "5",

                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-------------------Increment Addon Property-----------------
                      for (
                        int i = 0;
                        i < propertyController.properties.length;
                        i++
                      )
                        _buildPropertyCard(i),
                      const SizedBox(height: 12),
                      //-------------------Button-----------------
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
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
                            propertyController.addProperty();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text("+ Add Another Property"),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom Button
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
                // TODO: Validate all fields
                Get.to(() => AssetsScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
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

  Widget _buildPropertyCard(int index) {
    Property property = propertyController.properties[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 5,
          color: AppColors.white,
          shape: Border.all(style: BorderStyle.none),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Property ${index + 1}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Property Type",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                //-------------------Select Button-----------------
                SelectButtonWidget(
                  onSelected: (value) {}, // ← fixed: added empty function (or null)
                ),
                const SizedBox(height: 16),
                Text(
                  "Address",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.addressController,
                  keyboardType: TextInputType.text,
                  hintText: "Enter address",
                ),
                const SizedBox(height: 8),
                Text(
                  "Purchase Prices",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.purchasePriceController,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
                const SizedBox(height: 8),
                Text(
                  "Purchase Date",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                  controller: property.purchaseDateController,
                  keyboardType: TextInputType.datetime,
                  hintText: "01/01/0001",
                ),
                const SizedBox(height: 8),
                Text(
                  "Current Estimated Value",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.estimatedValueController,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
                const SizedBox(height: 8),
                Text(
                  "Mortgage Provider",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.mortgageProviderController,
                  keyboardType: TextInputType.text,
                  hintText: "Provider name",
                ),
                const SizedBox(height: 8),
                Text(
                  "Current Mortgage Amount",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.mortgageAmountController,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
                const SizedBox(height: 8),
                Text(
                  "Current Mortgage Rate",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.mortgageRateController,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
                const SizedBox(height: 8),
                Text(
                  "Current Mortgage Interest Rates",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.interestRateController,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
                const SizedBox(height: 8),
                Text(
                  "Mortgage Finished Rates",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  controller: property.finishedRateController,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        //-------------------Loan Structure Property-----------------
        Card(
          elevation: 5,
          color: AppColors.white,
          shape: Border.all(style: BorderStyle.none),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mortgage Type",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                CustomSegmentSelector(
                  height: 42,
                  borderRadius: 6,
                  backgroundColor: AppColors.btncolor,
                  selectedColor: AppColors.primary,
                  selectedTextColor: Colors.white,
                  unSelectedTextColor: Colors.grey,
                ),
                const SizedBox(height: 12),
                Text(
                  "If Interest Only, Total months",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  controller:
                  propertyController.properties.isNotEmpty
                      ? propertyController
                      .properties
                      .last
                      .loanTermController
                      : TextEditingController(),
                  // ← fixed: using correct controller
                  keyboardType: TextInputType.text,
                  hintText: "0",
                ),
                const SizedBox(height: 16),
                Text(
                  "IO period(Months)",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  controller:
                  propertyController.properties.isNotEmpty
                      ? propertyController
                      .properties
                      .last
                      .loanTermController
                      : TextEditingController(),
                  // ← fixed: using correct controller
                  keyboardType: TextInputType.text,
                  hintText: "0",
                ),
                const SizedBox(height: 16),
                Text(
                  "Remaining term(P&I)",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  controller:
                  propertyController.properties.isNotEmpty
                      ? propertyController
                      .properties
                      .last
                      .loanTermController
                      : TextEditingController(),
                  // ← fixed: using correct controller
                  keyboardType: TextInputType.text,
                  hintText: "0",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 5,
          color: AppColors.white,
          shape: Border.all(style: BorderStyle.none),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Rental Payment",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your current rental payment amount",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  keyboardType: TextInputType.text,
                  hintText: "0",
                ),

              ],
            ),
          ),
        ),

        SizedBox(height: 16),

      ],
    );
  }
}
