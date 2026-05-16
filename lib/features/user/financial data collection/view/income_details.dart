import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/set_up_your_financial_profile_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import 'living_expenses.dart';

class IncomeDetailsScreen extends StatefulWidget {
  const IncomeDetailsScreen({super.key});

  @override
  State<IncomeDetailsScreen> createState() => _IncomeDetailsScreenState();
}

class _IncomeDetailsScreenState extends State<IncomeDetailsScreen> {
  final SetUpYourFinancialProfileController controller = Get.find<SetUpYourFinancialProfileController>();

  late TextEditingController _primaryIncomeController;
  late TextEditingController _otherIncomeController;

  // Use empty string as default instead of null
  String _selectedIncomeType = "";
  String _selectedIncomeFrequency = "";
  String _selectedTaxRegion = "";

  @override
  void initState() {
    super.initState();
    _primaryIncomeController = TextEditingController();
    _otherIncomeController = TextEditingController();

    // Initialize with empty strings
    _selectedIncomeType = "";
    _selectedIncomeFrequency = "";
    _selectedTaxRegion = "";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentAdultIncomeData();
    });
  }

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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  final currentAdultIndex = controller.selectedAdultIndex.value;
                  final adultNumber = currentAdultIndex + 1;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Adults",
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),

                            if (controller.adultControllers.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text("No adults added yet"),
                              )
                            else
                              DropdownButtonFormField<int>(
                                key: ValueKey('adultSelection_$currentAdultIndex'),
                                value: currentAdultIndex,
                                hint: const Text("Select Adult"),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
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
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                ),
                                isExpanded: true,
                                items: List.generate(controller.adultControllers.length, (index) {
                                  String name = controller.adultControllers[index]['name']!.text.trim();
                                  String displayName = name.isNotEmpty
                                      ? "$name (Adult ${index + 1})"
                                      : "Adult ${index + 1}";
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(displayName),
                                  );
                                }),
                                onChanged: (index) {
                                  if (index != null) {
                                    _saveIncomeData();
                                    controller.selectAdult(index);
                                    _loadCurrentAdultIncomeData();
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      if (controller.adultControllers.isNotEmpty) ...[
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
                                  "Primary Income for Adult $adultNumber",
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
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
                                // Primary Income Type Dropdown
                                DropdownButtonFormField<String>(
                                  key: ValueKey('incomeType_${currentAdultIndex}_$_selectedIncomeType'),
                                  value: _getValidValue(_selectedIncomeType, _buildIncomeTypeItems()),
                                  hint: const Text("Select Income Type"),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
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
                                    color: AppColors.darkGrey,
                                    fontSize: 16,
                                  ),
                                  isExpanded: true,
                                  items: _buildIncomeTypeItems(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedIncomeType = value;
                                      });
                                      _saveIncomeData();
                                    }
                                  },
                                ),
                                const SizedBox(height: 8),
                                CustomInputField(
                                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                                  controller: _primaryIncomeController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  onChanged: (value) {
                                    _saveIncomeData();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

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
                                  "Income Frequency for Adult $adultNumber",
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
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
                                DropdownButtonFormField<String>(
                                  key: ValueKey('incomeFrequency_${currentAdultIndex}_$_selectedIncomeFrequency'),
                                  value: _getValidValue(_selectedIncomeFrequency, _buildIncomeFrequencyItems()),
                                  hint: const Text("Select Frequency"),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                                  items: _buildIncomeFrequencyItems(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedIncomeFrequency = value;
                                      });
                                      _saveIncomeData();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

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
                                  "Other Income for Adult $adultNumber (Optional)",
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
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
                                  controller: _otherIncomeController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  onChanged: (value) {
                                    _saveIncomeData();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

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
                                  "Tax Region/State for Adult $adultNumber",
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
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
                                DropdownButtonFormField<String>(
                                  key: ValueKey('taxRegion_${currentAdultIndex}_$_selectedTaxRegion'),
                                  value: _getValidValue(_selectedTaxRegion, _buildTaxRegionItems()),
                                  hint: const Text("Select Tax Region"),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                                  items: _buildTaxRegionItems(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedTaxRegion = value;
                                      });
                                      _saveIncomeData();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 40),
                    ],
                  );
                }),
              ),
            ),
          ),
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
                _saveIncomeData();
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

  // Helper method to ensure dropdown value is valid
  String? _getValidValue(String currentValue, List<DropdownMenuItem<String>> items) {
    // If current value is empty or doesn't exist in items, return null (shows hint)
    if (currentValue.isEmpty || !items.any((item) => item.value == currentValue)) {
      return null;
    }
    return currentValue;
  }

  // Build income type items
  List<DropdownMenuItem<String>> _buildIncomeTypeItems() {
    final items = [
      "Salary/Wages",
      "Business Income",
      "Self-Employed",
      "Pension",
      "Government Benefits",
      "Investment Income"
    ];

    return items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  // Build income frequency items
  List<DropdownMenuItem<String>> _buildIncomeFrequencyItems() {
    final items = [
      "Annually",
      "Monthly",
      "Fortnightly",
      "Weekly"
    ];

    return items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  // Build tax region items
  List<DropdownMenuItem<String>> _buildTaxRegionItems() {
    final items = [
      "NSW",
      "VIC",
      "QLD",
      "SA",
      "WA",
      "TAS",
      "NT",
      "ACT"
    ];

    return items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  // Load income data for current adult
  void _loadCurrentAdultIncomeData() {
    final incomeData = controller.getCurrentAdultIncomeData();

    // Get and validate income type
    String? incomeType = incomeData["primaryIncomeType"] as String?;

    // Validate income type
    final validIncomeTypes = _buildIncomeTypeItems().map((item) => item.value).toList();
    if (incomeType == null || incomeType.isEmpty || !validIncomeTypes.contains(incomeType)) {
      incomeType = "Salary/Wages";
    }

    // Validate income frequency
    String? incomeFrequency = incomeData["incomeFrequency"] as String?;
    final validFrequencies = _buildIncomeFrequencyItems().map((item) => item.value).toList();
    if (incomeFrequency == null || incomeFrequency.isEmpty || !validFrequencies.contains(incomeFrequency)) {
      incomeFrequency = "Annually";
    }

    // Validate tax region
    String? taxRegion = incomeData["taxRegion"] as String?;
    final validRegions = _buildTaxRegionItems().map((item) => item.value).toList();
    if (taxRegion == null || taxRegion.isEmpty || !validRegions.contains(taxRegion)) {
      taxRegion = "NSW";
    }

    setState(() {
      _primaryIncomeController.text =
          (incomeData["primaryIncomeAmount"] as double?)?.toStringAsFixed(0) ?? "0";
      _otherIncomeController.text =
          (incomeData["otherIncome"] as double?)?.toStringAsFixed(0) ?? "0";

      _selectedIncomeType = incomeType!;
      _selectedIncomeFrequency = incomeFrequency!;
      _selectedTaxRegion = taxRegion!;
    });
  }

  // Save income data for current adult
  void _saveIncomeData() {
    double primaryIncome = double.tryParse(_primaryIncomeController.text) ?? 0.0;
    double otherIncome = double.tryParse(_otherIncomeController.text) ?? 0.0;

    controller.saveIncomeForCurrentAdult(
      primaryIncomeType: _selectedIncomeType.isNotEmpty ? _selectedIncomeType : "Salary/Wages",
      primaryIncomeAmount: primaryIncome,
      incomeFrequency: _selectedIncomeFrequency.isNotEmpty ? _selectedIncomeFrequency : "Annually",
      otherIncome: otherIncome,
      taxRegion: _selectedTaxRegion.isNotEmpty ? _selectedTaxRegion : "NSW",
    );
  }

  @override
  void dispose() {
    _saveIncomeData();
    _primaryIncomeController.dispose();
    _otherIncomeController.dispose();
    super.dispose();
  }
}