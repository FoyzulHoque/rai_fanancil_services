import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/insurance_council_controller.dart';
import 'cost_estimates_screen.dart';

class InsuranceAndCouncilRatesScreen extends StatelessWidget {
  InsuranceAndCouncilRatesScreen({super.key});

  // ✅ Separate controllers (don’t set initial values; hintText will show placeholders)
  final TextEditingController suburbCtrl = TextEditingController();
  final TextEditingController bedroomsCtrl = TextEditingController();
  final TextEditingController bathroomsCtrl = TextEditingController();
  final TextEditingController buildingAreaCtrl = TextEditingController();

  // ✅ Dropdown values (keep UI like screenshot)
  final List<String> propertyTypes = const ["Apartment", "House", "Townhouse", "Unit"];
  final List<String> buildTypes = const ["New", "Established"];

  // ✅ controller
  final InsuranceCouncilController controller =
  Get.put(InsuranceCouncilController());

  @override
  Widget build(BuildContext context) {
    // default selected (only for dropdown UI selection; not input value)
    String selectedPropertyType = propertyTypes.first; // Apartment
    String selectedBuildType = buildTypes.first; // New

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header (blue)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.lightBlueSolid),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Insurance & Council Rates",
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

              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Suburb input (single top field)
                        Text(
                          "Suburb",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CustomInputField(
                          controller: suburbCtrl,
                          keyboardType: TextInputType.text,
                          hintText: "Suburb",
                        ),

                        const SizedBox(height: 12),

                        // ✅ Property Details card
                        Card(
                          elevation: 5,
                          color: AppColors.white,
                          shape: Border.all(style: BorderStyle.none),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Property Details",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // Property Type dropdown
                                    Text(
                                      "Property Type",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    DropdownButtonFormField<String>(
                                      value: selectedPropertyType,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                                      items: propertyTypes
                                          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                          .toList(),
                                      onChanged: (v) {
                                        if (v == null) return;
                                        setState(() => selectedPropertyType = v);
                                      },
                                    ),

                                    const SizedBox(height: 12),

                                    // Bedrooms
                                    Text(
                                      "Number of Bedrooms",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    CustomInputField(
                                      controller: bedroomsCtrl,
                                      keyboardType: TextInputType.number,
                                      hintText: "Number of bedrooms",
                                    ),

                                    const SizedBox(height: 12),

                                    // Bathrooms
                                    Text(
                                      "Number of Bathrooms",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    CustomInputField(
                                      controller: bathroomsCtrl,
                                      keyboardType: TextInputType.number,
                                      hintText: "Number of bathrooms",
                                    ),

                                    const SizedBox(height: 12),

                                    // Building Area
                                    Text(
                                      "Building Area (sqm)",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    CustomInputField(
                                      controller: buildingAreaCtrl,
                                      keyboardType: TextInputType.number,
                                      hintText: "Building Area (sqm)",
                                    ),

                                    const SizedBox(height: 12),

                                    // Build Type dropdown
                                    Text(
                                      "Build Type",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    DropdownButtonFormField<String>(
                                      value: selectedBuildType,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                                      items: buildTypes
                                          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                          .toList(),
                                      onChanged: (v) {
                                        if (v == null) return;
                                        setState(() => selectedBuildType = v);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ✅ Bottom Calculate button (blue)
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
                        // ✅ API expects buildType: "New" or "Established"
                        final apiBuildType =
                        selectedBuildType == "New" ? "New" : "Established";

                        await controller.calculateInsuranceCouncil(
                          suburb: suburbCtrl.text,
                          propertyType: selectedPropertyType,
                          bedroomsCtrl: bedroomsCtrl,
                          bathroomsCtrl: bathroomsCtrl,
                          buildingAreaCtrl: buildingAreaCtrl,
                          buildType: apiBuildType,
                        );
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
}
