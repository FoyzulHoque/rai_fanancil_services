import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/select_custom_button_controller.dart';
import '../widget/custom_button_widget.dart';
import 'investment_results_screen.dart';

class PropertyInvestmentScreen extends StatefulWidget {
  const PropertyInvestmentScreen({super.key});

  @override
  State<PropertyInvestmentScreen> createState() =>
      _PropertyInvestmentScreenState();
}

class _PropertyInvestmentScreenState extends State<PropertyInvestmentScreen> {
  final LoanTypeController loanTypeController = Get.put(LoanTypeController());

  // --- Dropdown values (UI only)
  final List<String> _propertyTypes = const ["Apartment", "House", "Townhouse"];
  String _selectedPropertyType = "Apartment";

  final List<String> _suburbs = const ["Victoria", "Sydney", "Melbourne"];
  String _selectedSuburb = "Victoria";

  final List<String> _rentFrequencies = const ["Monthly", "Weekly"];
  String _selectedRentFrequency = "Monthly";

  // --- Controllers (no initial values)
  final TextEditingController purchasePriceCtrl = TextEditingController();
  final TextEditingController rentCtrl = TextEditingController();
  final TextEditingController loanAmountCtrl = TextEditingController();
  final TextEditingController interestRateCtrl = TextEditingController();

  @override
  void dispose() {
    purchasePriceCtrl.dispose();
    rentCtrl.dispose();
    loanAmountCtrl.dispose();
    interestRateCtrl.dispose();
    super.dispose();
  }

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
                    child: Column(
                      children: [
                        _propertyCard(
                          titleTop: "Property 1",
                          purchasePriceCtrl: purchasePriceCtrl,
                          propertyTypes: _propertyTypes,
                          selectedPropertyType: _selectedPropertyType,
                          onPropertyTypeChanged: (v) =>
                              setState(() => _selectedPropertyType = v),
                          suburbs: _suburbs,
                          selectedSuburb: _selectedSuburb,
                          onSuburbChanged: (v) =>
                              setState(() => _selectedSuburb = v),
                          rentCtrl: rentCtrl,
                          rentFrequencies: _rentFrequencies,
                          selectedRentFrequency: _selectedRentFrequency,
                          onRentFrequencyChanged: (v) =>
                              setState(() => _selectedRentFrequency = v),
                          loanAmountCtrl: loanAmountCtrl,
                          interestRateCtrl: interestRateCtrl,
                          // NOTE: loan type uses your existing CustomSegmentSelector (P&I / Interest Only)
                        ),

                        const SizedBox(height: 12),

                        // duplicate block like screenshot (Property 1 appears again)
                        _propertyCard(
                          titleTop: "Property 1",
                          purchasePriceCtrl: TextEditingController(),
                          propertyTypes: _propertyTypes,
                          selectedPropertyType: _selectedPropertyType,
                          onPropertyTypeChanged: (v) =>
                              setState(() => _selectedPropertyType = v),
                          suburbs: _suburbs,
                          selectedSuburb: _selectedSuburb,
                          onSuburbChanged: (v) =>
                              setState(() => _selectedSuburb = v),
                          rentCtrl: TextEditingController(),
                          rentFrequencies: _rentFrequencies,
                          selectedRentFrequency: _selectedRentFrequency,
                          onRentFrequencyChanged: (v) =>
                              setState(() => _selectedRentFrequency = v),
                          loanAmountCtrl: TextEditingController(),
                          interestRateCtrl: TextEditingController(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Calculate button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => InvestmentResultsScreen()),
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
                    child: const Text("Calculate"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertyCard({
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
  }) {
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
            value: selectedPropertyType,
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
            value: selectedSuburb,
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
                  value: selectedRentFrequency,
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
          // Use your existing widget (P&I / Interest Only)
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
