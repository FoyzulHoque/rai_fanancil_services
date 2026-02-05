import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/select_custom_button_controller.dart';
import '../widget/custom_button_widget.dart';
import '../controller/property_calculator_controller.dart';

class PropertyInvestmentScreen extends StatefulWidget {
  const PropertyInvestmentScreen({super.key});

  @override
  State<PropertyInvestmentScreen> createState() =>
      _PropertyInvestmentScreenState();
}

class _PropertyInvestmentScreenState extends State<PropertyInvestmentScreen> {
  final LoanTypeController loanTypeController = Get.put(LoanTypeController());

  // ✅ controller
  final PropertyCalculatorController controller =
  Get.put(PropertyCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // Header (purple)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.indicator),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Property Investment",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      // loading prefill
                      if (controller.isLoadingProperty.value &&
                          controller.propertyForms.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final forms = controller.propertyForms;

                      return Column(
                        children: [
                          for (int i = 0; i < forms.length; i++) ...[
                            _propertyCard(
                              index: i,
                              titleTop: forms[i].name,
                              purchasePriceCtrl: forms[i].purchasePriceCtrl,
                              propertyTypes: controller.propertyTypes,
                              selectedPropertyType:
                              forms[i].selectedPropertyType,
                              onPropertyTypeChanged: (v) =>
                                  controller.setPropertyType(i, v),
                              suburbs: controller.suburbs,
                              selectedSuburb: forms[i].selectedSuburb,
                              onSuburbChanged: (v) =>
                                  controller.setSuburb(i, v),
                              rentCtrl: forms[i].rentCtrl,
                              rentFrequencies: controller.rentFrequencies,
                              selectedRentFrequency:
                              forms[i].selectedRentFrequency,
                              onRentFrequencyChanged: (v) =>
                                  controller.setRentFrequency(i, v),
                              loanAmountCtrl: forms[i].loanAmountCtrl,
                              interestRateCtrl: forms[i].interestRateCtrl,
                              // loan type
                              selectedLoanType: forms[i].selectedLoanType,
                              onLoanTypeChanged: (v) =>
                                  controller.setLoanType(i, v),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ],
                      );
                    }),
                  ),
                ),
              ),

              // Bottom Calculate button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                        await controller.createPropertyCalculator();
                        // navigation handled in controller
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Calculate"),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertyCard({
    required int index,
    required String titleTop,
    required TextEditingController purchasePriceCtrl,
    required List<String> propertyTypes,
    required String selectedPropertyType,
    required void Function(String) onPropertyTypeChanged,
    required List<String> suburbs,
    required String selectedSuburb,
    required void Function(String) onSuburbChanged,
    required TextEditingController rentCtrl,
    required List<String> rentFrequencies,
    required String selectedRentFrequency,
    required void Function(String) onRentFrequencyChanged,
    required TextEditingController loanAmountCtrl,
    required TextEditingController interestRateCtrl,

    // loan type
    required String selectedLoanType,
    required void Function(String) onLoanTypeChanged,
  }) {
    // ✅ FIX (no UI change): dropdown value must exist in items, otherwise null
    final safePropertyType =
    propertyTypes.contains(selectedPropertyType) ? selectedPropertyType : null;

    final safeSuburb =
    suburbs.contains(selectedSuburb) ? selectedSuburb : null;

    final safeRentFrequency = rentFrequencies.contains(selectedRentFrequency)
        ? selectedRentFrequency
        : null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleTop,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),

          // Purchase Details
          const Text(
            "Purchase Details",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _label("Purchase Price (\$)"),
          CustomInputField(
            controller: purchasePriceCtrl,
            keyboardType: TextInputType.number,
            hintText: "12000",
          ),
          const SizedBox(height: 8),

          _label("Property Type"),
          DropdownButtonFormField<String>(
            value: safePropertyType,
            decoration: _ddDecoration(),
            isExpanded: true,
            items: propertyTypes
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              onPropertyTypeChanged(v);
            },
          ),
          const SizedBox(height: 8),

          _label("Suburb"),
          DropdownButtonFormField<String>(
            value: safeSuburb,
            decoration: _ddDecoration(),
            isExpanded: true,
            items: suburbs
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              onSuburbChanged(v);
            },
          ),

          const SizedBox(height: 12),

          // Rental Income
          const Text(
            "Rental Income",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _label("Rent (\$)"),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  controller: rentCtrl,
                  keyboardType: TextInputType.number,
                  hintText: "0",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: safeRentFrequency,
                  decoration: _ddDecoration(),
                  isExpanded: true,
                  items: rentFrequencies
                      .map((e) =>
                      DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) {
                    if (v == null) return;
                    onRentFrequencyChanged(v);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Loan Details
          const Text(
            "Loan Details",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          _label("Loan Amount (\$)"),
          CustomInputField(
            controller: loanAmountCtrl,
            keyboardType: TextInputType.number,
            hintText: "12000",
          ),
          const SizedBox(height: 8),

          _label("Interest Rate (%)"),
          CustomInputField(
            controller: interestRateCtrl,
            keyboardType: TextInputType.number,
            hintText: "10",
          ),
          const SizedBox(height: 10),

          _label("Loan Type"),

          // ✅ keep your existing widget UI (no change)
          CustomSegmentSelector(
            height: 36,
            borderRadius: 4,
            backgroundColor: AppColors.btncolor,
            selectedColor: AppColors.primary,
            selectedTextColor: Colors.white,
            unSelectedTextColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  static Widget _label(String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black45,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static InputDecoration _ddDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
