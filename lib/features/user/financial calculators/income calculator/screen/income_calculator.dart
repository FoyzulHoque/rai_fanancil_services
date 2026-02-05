import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_input_field_widget.dart';
import '../controllers/income_calculator_controller.dart';

class IncomeCalculatorScreen extends StatefulWidget {
  const IncomeCalculatorScreen({super.key});

  @override
  State<IncomeCalculatorScreen> createState() => _IncomeCalculatorScreenState();
}

class _IncomeCalculatorScreenState extends State<IncomeCalculatorScreen> {
  final IncomeCalculatorController controller =
  Get.put(IncomeCalculatorController());

  final List<String> _frequencies = const ["Monthly", "Annually", "Weekly"];
  String _selectedFrequency = "Monthly";

  final TextEditingController primaryIncomeCtrl = TextEditingController();
  final TextEditingController rentalIncomeCtrl = TextEditingController();
  final TextEditingController businessIncomeCtrl = TextEditingController();
  final TextEditingController otherIncomeCtrl = TextEditingController();
  final TextEditingController residencyStatusCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    // default selected
    controller.incomeFrequencyController.text = _selectedFrequency;
    // attach UI controllers -> controller controllers (same structure)
    controller.primaryIncomeController = primaryIncomeCtrl;
    controller.rentalIncomeController = rentalIncomeCtrl;
    controller.businessOrSideIncomeController = businessIncomeCtrl;
    controller.otherIncomeController = otherIncomeCtrl;
    controller.residencyStatusController = residencyStatusCtrl;
  }

  @override
  void dispose() {
    primaryIncomeCtrl.dispose();
    rentalIncomeCtrl.dispose();
    businessIncomeCtrl.dispose();
    otherIncomeCtrl.dispose();
    residencyStatusCtrl.dispose();
    super.dispose();
  }

  InputDecoration _boxDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Colors.grey, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Colors.grey, width: 1.8),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(color: AppColors.greenDip),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Image.asset(
                        "assets/icons/moves_right.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Income Calculator",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        Text(
                          "Income Frequency",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedFrequency,
                          hint: const Text("Select Income Frequency"),
                          decoration: _boxDecoration(),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.blueGrey),
                          isExpanded: true,
                          items: _frequencies
                              .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                              .toList(),
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _selectedFrequency = v);
                            controller.incomeFrequencyController.text = v;
                          },
                        ),

                        const SizedBox(height: 14),

                        Card(
                          elevation: 5,
                          color: AppColors.white,
                          shape: Border.all(style: BorderStyle.none),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Primary Income (\$)",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CustomInputField(
                                  controller: primaryIncomeCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Primary Income",
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Card(
                          elevation: 5,
                          color: AppColors.white,
                          shape: Border.all(style: BorderStyle.none),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Additional Income Sources",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  "Rental Income (\$)",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomInputField(
                                  controller: rentalIncomeCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Rental Income",
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  "Business / Side Income (\$)",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomInputField(
                                  controller: businessIncomeCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Business / Side Income",
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  "Other Income (\$)",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomInputField(
                                  controller: otherIncomeCtrl,
                                  keyboardType: TextInputType.number,
                                  hintText: "Other Income",
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Card(
                          elevation: 5,
                          color: AppColors.white,
                          shape: Border.all(style: BorderStyle.none),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tax Settings",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  "Residency Status",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomInputField(
                                  controller: residencyStatusCtrl,
                                  keyboardType: TextInputType.text,
                                  hintText: "Residency Status",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        controller.createIncomeCalculator();
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
