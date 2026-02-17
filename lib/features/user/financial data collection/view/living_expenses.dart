import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/financial%20data%20collection/view/property_details.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/set_up_your_financial_profile_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';

class LivingExpensesScreen extends StatefulWidget {
  LivingExpensesScreen({super.key});

  @override
  State<LivingExpensesScreen> createState() => _LivingExpensesScreenState();
}

class _LivingExpensesScreenState extends State<LivingExpensesScreen> {
  final SetUpYourFinancialProfileController controller = Get.find<SetUpYourFinancialProfileController>();

  // Create separate controllers for each field
  final TextEditingController _foodAmountController = TextEditingController();
  final TextEditingController _transportAmountController = TextEditingController();
  final TextEditingController _utilitiesAmountController = TextEditingController();
  final TextEditingController _insuranceAmountController = TextEditingController();
  final TextEditingController _entertainmentAmountController = TextEditingController();
  final TextEditingController _mortgagePaymentController = TextEditingController();

  // ADD SEPARATE DATE CONTROLLERS FOR EACH CATEGORY
  final TextEditingController _foodDateController = TextEditingController();
  final TextEditingController _transportDateController = TextEditingController();
  final TextEditingController _utilitiesDateController = TextEditingController();
  final TextEditingController _insuranceDateController = TextEditingController();
  final TextEditingController _entertainmentDateController = TextEditingController();

  // Add frequency variables for each category
  String _foodFrequency = "Annually";
  String _transportFrequency = "Annually";
  String _utilitiesFrequency = "Annually";
  String _insuranceFrequency = "Annually";
  String _entertainmentFrequency = "Annually";

  // Single string for living situation
  String? _selectedResidence = "Own House";

  @override
  void initState() {
    super.initState();
    _selectedResidence = controller.selectedLivingSituation.value;

    // Load existing data from controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExpensesData();
    });
  }

  void _loadExpensesData() {
    setState(() {
      _foodAmountController.text = controller.foodAmount.value.toString();
      _foodFrequency = controller.foodFrequency.value;
      _foodDateController.text = controller.foodExpenseDate.value;

      _transportAmountController.text = controller.transportAmount.value.toString();
      _transportFrequency = controller.transportFrequency.value;
      _transportDateController.text = controller.transportExpenseDate.value;

      _utilitiesAmountController.text = controller.utilitiesAmount.value.toString();
      _utilitiesFrequency = controller.utilitiesFrequency.value;
      _utilitiesDateController.text = controller.utilitiesExpenseDate.value;

      _insuranceAmountController.text = controller.insuranceAmount.value.toString();
      _insuranceFrequency = controller.insuranceFrequency.value;
      _insuranceDateController.text = controller.insuranceExpenseDate.value;

      _entertainmentAmountController.text = controller.entertainmentAmount.value.toString();
      _entertainmentFrequency = controller.entertainmentFrequency.value;
      _entertainmentDateController.text = controller.entertainmentExpenseDate.value;

      _mortgagePaymentController.text = controller.monthlyRentalPayment.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          CustomAppBarSetBeforeNaveBar(
            title: "Living Expenses",
            currentStep: 3,
            totalSteps: 6,
            appBarColor: AppColors.secondaryColors,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              "Current Living Status",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Affects your borrowing capacity assessment",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedResidence == "Own House",
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _selectedResidence = "Own House";
                                        });
                                        _saveExpensesData();
                                      },
                                    ),
                                    Text("Own House"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedResidence == "Renting",
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _selectedResidence = "Renting";
                                        });
                                        _saveExpensesData();
                                      },
                                    ),
                                    Text("Renting"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedResidence == "Living with Parents",
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _selectedResidence = "Living with Parents";
                                        });
                                        _saveExpensesData();
                                      },
                                    ),
                                    Text("Living with Parents"),
                                  ],
                                ),
                              ],
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
                              "Living Expenses",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // FOOD SECTION
                            Text("Food"),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                                    controller: _foodAmountController,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                    onChanged: (value) => _saveExpensesData(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _foodFrequency,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Annually", child: Text("Annually")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _foodFrequency = v);
                                      _saveExpensesData();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text("Food Expense Date (Optional)"),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.calendar_month),
                              controller: _foodDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: "YYYY-MM-DD",
                              onChanged: (value) => _saveExpensesData(),
                            ),
                            const SizedBox(height: 24),

                            // TRANSPORT SECTION
                            Text("Transport"),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                                    controller: _transportAmountController,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                    onChanged: (value) => _saveExpensesData(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _transportFrequency,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Annually", child: Text("Annually")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _transportFrequency = v);
                                      _saveExpensesData();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text("Transport Expense Date (Optional)"),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.calendar_month),
                              controller: _transportDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: "YYYY-MM-DD",
                              onChanged: (value) => _saveExpensesData(),
                            ),
                            const SizedBox(height: 24),

                            // UTILITIES SECTION
                            Text("Utilities"),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                                    controller: _utilitiesAmountController,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                    onChanged: (value) => _saveExpensesData(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _utilitiesFrequency,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Annually", child: Text("Annually")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _utilitiesFrequency = v);
                                      _saveExpensesData();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text("Utilities Expense Date (Optional)"),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.calendar_month),
                              controller: _utilitiesDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: "YYYY-MM-DD",
                              onChanged: (value) => _saveExpensesData(),
                            ),
                            const SizedBox(height: 24),

                            // INSURANCE SECTION
                            Text("Insurance"),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                                    controller: _insuranceAmountController,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                    onChanged: (value) => _saveExpensesData(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _insuranceFrequency,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Annually", child: Text("Annually")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _insuranceFrequency = v);
                                      _saveExpensesData();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text("Insurance Expense Date (Optional)"),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.calendar_month),
                              controller: _insuranceDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: "YYYY-MM-DD",
                              onChanged: (value) => _saveExpensesData(),
                            ),
                            const SizedBox(height: 24),

                            // ENTERTAINMENT SECTION
                            Text("Entertainment"),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                                    controller: _entertainmentAmountController,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                    onChanged: (value) => _saveExpensesData(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _entertainmentFrequency,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Annually", child: Text("Annually")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _entertainmentFrequency = v);
                                      _saveExpensesData();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text("Entertainment Expense Date (Optional)"),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.calendar_month),
                              controller: _entertainmentDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: "YYYY-MM-DD",
                              onChanged: (value) => _saveExpensesData(),
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
                            Text("Monthly Mortgage Payment"),
                            const SizedBox(height: 8),
                            Text("Your current mortgage payment amount"),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.monetization_on_outlined),
                              controller: _mortgagePaymentController,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                              onChanged: (value) => _saveExpensesData(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
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
                _saveExpensesData();
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

  // Save expenses data to controller
  void _saveExpensesData() {
    controller.saveExpenses(
      livingSituation: _selectedResidence ?? "Own House",
      foodAmount: double.tryParse(_foodAmountController.text) ?? 0.0,
      foodFrequency: _foodFrequency,
      foodExpenseDate: _foodDateController.text,
      transportAmount: double.tryParse(_transportAmountController.text) ?? 0.0,
      transportFrequency: _transportFrequency,
      transportExpenseDate: _transportDateController.text,
      utilitiesAmount: double.tryParse(_utilitiesAmountController.text) ?? 0.0,
      utilitiesFrequency: _utilitiesFrequency,
      utilitiesExpenseDate: _utilitiesDateController.text,
      insuranceAmount: double.tryParse(_insuranceAmountController.text) ?? 0.0,
      insuranceFrequency: _insuranceFrequency,
      insuranceExpenseDate: _insuranceDateController.text,
      entertainmentAmount: double.tryParse(_entertainmentAmountController.text) ?? 0.0,
      entertainmentFrequency: _entertainmentFrequency,
      entertainmentExpenseDate: _entertainmentDateController.text,
      monthlyRentalPayment: double.tryParse(_mortgagePaymentController.text) ?? 0.0,
    );
  }

  @override
  void dispose() {
    // Dispose amount controllers
    _foodAmountController.dispose();
    _transportAmountController.dispose();
    _utilitiesAmountController.dispose();
    _insuranceAmountController.dispose();
    _entertainmentAmountController.dispose();
    _mortgagePaymentController.dispose();

    // Dispose date controllers
    _foodDateController.dispose();
    _transportDateController.dispose();
    _utilitiesDateController.dispose();
    _insuranceDateController.dispose();
    _entertainmentDateController.dispose();

    super.dispose();
  }
}