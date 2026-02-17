import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../../financial calculators/property investment/widget/custom_button_widget.dart';
import '../controller/set_up_your_financial_profile_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import '../widget/select_button_widget.dart';
import 'assets.dart';

class PropertyDetailsScreen extends StatefulWidget {
  PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final SetUpYourFinancialProfileController controller = Get.find<SetUpYourFinancialProfileController>();

  @override
  void initState() {
    super.initState();
    // Ensure property details are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updatePropertyDetails();
    });
  }

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
                child: Obx(
                      () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-------------------Increment Addon Property-----------------
                      for (int i = 0; i < controller.properties.length; i++)
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
                            controller.addProperty();
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
                // Update property details before navigating
                controller.updatePropertyDetails();
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
    final property = controller.properties[index];
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
                  initialValue: property.propertyType,
                  onSelected: (value) {
                    if (value != null) {
                      controller.updateProperty(index, propertyType: value);
                    }
                  },
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  initialValue: property.mortgageType,
                  height: 42,
                  borderRadius: 6,
                  backgroundColor: AppColors.btncolor,
                  selectedColor: AppColors.primary,
                  selectedTextColor: Colors.white,
                  unSelectedTextColor: Colors.grey,
                  onSelected: (value) {
                    controller.updateProperty(index, mortgageType: value);
                  },
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
                  controller: property.loanTermController,
                  keyboardType: TextInputType.text,
                  hintText: property.totalMonthOfInterest.toString(),
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  controller: TextEditingController(text: property.ioPeriodMonth.toString()),
                  keyboardType: TextInputType.text,
                  hintText: "0",
                  onChanged: (value) {
                    property.ioPeriodMonth = int.tryParse(value) ?? 0;
                    controller.updatePropertyDetails();
                  },
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
                  controller: property.loanTermController,
                  keyboardType: TextInputType.text,
                  hintText: "0",
                  onChanged: (_) => controller.updatePropertyDetails(),
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
                  controller: property.monthlyRentalController,
                  keyboardType: TextInputType.text,
                  hintText: "0",
                  onChanged: (_) => controller.updatePropertyDetails(),
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