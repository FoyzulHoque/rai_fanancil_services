import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/features/user/financial%20calculators/stamp%20duty%20calculator/screen/stamp_duty_calculator_result_screen.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';

class StampDutyCalculatorScreen extends StatelessWidget {
  StampDutyCalculatorScreen({super.key});

  // dropdown values (UI only)
  final List<String> _propertyTypes = const ["an existing property", "a new property"];
  final List<String> _buyerTypes = const ["First Time Home Buyer", "Next Home Buyer", "Investor"];
  final List<String> _suburbs = const ["NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT"];

  final RxString selectedPropertyType = "an existing property".obs;
  final RxString selectedBuyerType = "First Time Home Buyer".obs;
  final RxString selectedSuburb = "NSW".obs;

  // inputs (no initial values set)
  final TextEditingController savingsController = TextEditingController();
  final TextEditingController propertyValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // Header (deep pink)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.deepPink),
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
                          "Stamp Duty Calculator",
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
                    padding: const EdgeInsets.only(top: 4),
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: const BorderSide(color: Color(0xFFE6E6E6)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Label("Property type"),
                            const SizedBox(height: 6),
                            Obx(
                                  () => DropdownButtonFormField<String>(
                                value: selectedPropertyType.value,
                                decoration: _dropDecoration(),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black54),
                                isExpanded: true,
                                items: _propertyTypes
                                    .map((v) => DropdownMenuItem<String>(
                                  value: v,
                                  child: Text(
                                    v,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  selectedPropertyType.value = v;
                                },
                              ),
                            ),

                            const SizedBox(height: 14),

                            _Label("Buyer Type"),
                            const SizedBox(height: 6),
                            Obx(
                                  () => DropdownButtonFormField<String>(
                                value: selectedBuyerType.value,
                                decoration: _dropDecoration(),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black54),
                                isExpanded: true,
                                items: _buyerTypes
                                    .map((v) => DropdownMenuItem<String>(
                                  value: v,
                                  child: Text(
                                    v,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  selectedBuyerType.value = v;
                                },
                              ),
                            ),

                            const SizedBox(height: 14),

                            _Label("Suburb"),
                            const SizedBox(height: 6),
                            Obx(
                                  () => DropdownButtonFormField<String>(
                                value: selectedSuburb.value,
                                decoration: _dropDecoration(),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black54),
                                isExpanded: true,
                                items: _suburbs
                                    .map((v) => DropdownMenuItem<String>(
                                  value: v,
                                  child: Text(
                                    v,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  selectedSuburb.value = v;
                                },
                              ),
                            ),

                            const SizedBox(height: 14),

                            _Label("Savings of (\$)"),
                            const SizedBox(height: 6),
                            CustomInputField(
                              controller: savingsController,
                              keyboardType: TextInputType.number,
                              hintText: "Savings of (\$)",
                            ),

                            const SizedBox(height: 14),

                            _Label("Property Value (\$)"),
                            const SizedBox(height: 6),
                            CustomInputField(
                              controller: propertyValueController,
                              keyboardType: TextInputType.number,
                              hintText: "Property Value (\$)",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom button (blue)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => StampDutyCalculatorResultScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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

  InputDecoration _dropDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Color(0xFF9E9E9E), width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      filled: true,
      fillColor: Colors.white,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
