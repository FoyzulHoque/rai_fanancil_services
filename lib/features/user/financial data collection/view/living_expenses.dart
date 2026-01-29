import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/financial%20data%20collection/view/property_details.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/income_details_property_drop_down_controller.dart';
import '../controller/tax_region_state_dropdown_controller.dart';
import '../widget/check_box_widget.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';

class LivingExpensesScreen extends StatefulWidget {
  LivingExpensesScreen({super.key});

  @override
  State<LivingExpensesScreen> createState() => _LivingExpensesScreenState();
}

class _LivingExpensesScreenState extends State<LivingExpensesScreen> {
  final TextEditingController _propertyController1 = TextEditingController();
  List<String> _selectedResidences = []; // Changed to a list
  final IncomeDetailsPropertyDropdownController propertyDropdownController =
      Get.put(IncomeDetailsPropertyDropdownController());

  final TaxRegionStateDropdownController taxRegionStateDropdownController =
      Get.put(TaxRegionStateDropdownController());

  @override
  Widget build(BuildContext context) {
    String _period = "Weekly";
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Header (fixed at top)
          CustomAppBarSetBeforeNaveBar(
            title: "Household & Borrowing Profile",
            currentStep: 3,
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
                    //---Check box field-----------------------
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
                            CheckBoxWidget(
                              selectedOptions: _selectedResidences,
                              // Pass the list
                              onChanged: (newValue) {
                                setState(() {
                                  if (_selectedResidences.contains(newValue)) {
                                    _selectedResidences.remove(
                                      newValue,
                                    ); // Unselect
                                  } else {
                                    _selectedResidences.add(newValue); // Select
                                  }
                                });
                                print(
                                  "Selected residences: $_selectedResidences",
                                ); // for debug
                              },
                            ),
                          ],
                        ),
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
                              "Living Expenses",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Food",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                                    controller: _propertyController1,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                  ),
                                ),
                                const SizedBox(width: 8),

                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _period,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _period = v);
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // default light grey
                                          width: 1,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // inactive border
                                          width: 1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // focused border
                                          width: .8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Expense Date (Optional)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: "Expense Date",
                            ),
                            const SizedBox(height: 16),

                            Text(
                              "Transport",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(
                                      Icons.monetization_on_outlined,
                                    ),
                                    controller: _propertyController1,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _period,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _period = v);
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // default light grey
                                          width: 1,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // inactive border
                                          width: 1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // focused border
                                          width: .8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Expense Date (Optional)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: "Expense Date",
                            ),
                            const SizedBox(height: 16),

                            Text(
                              "Utilities",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(
                                      Icons.monetization_on_outlined,
                                    ),
                                    controller: _propertyController1,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _period,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _period = v);
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // default light grey
                                          width: 1,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // inactive border
                                          width: 1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // focused border
                                          width: .8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Expense Date (Optional)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: "Expense Date",
                            ),
                            const SizedBox(height: 16),

                            Text(
                              "Insurance",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(
                                      Icons.monetization_on_outlined,
                                    ),
                                    controller: _propertyController1,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _period,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _period = v);
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // default light grey
                                          width: 1,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // inactive border
                                          width: 1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // focused border
                                          width: .8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Expense Date (Optional)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: "Expense Date",
                            ),
                            const SizedBox(height: 16),

                            Text(
                              "Entertainment",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    prefixIcon: const Icon(
                                      Icons.monetization_on_outlined,
                                    ),
                                    controller: _propertyController1,
                                    keyboardType: TextInputType.number,
                                    hintText: "0",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _period,
                                    items: const [
                                      DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                                      DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                                      DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _period = v);
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFAFAFA),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // default light grey
                                          width: 1,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // inactive border
                                          width: 1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFBDBDBD), // focused border
                                          width: .8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Expense Date (Optional)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: "Expense Date",
                            ),
                          ],
                        ),
                      ),
                    ),
                    //---input field-----------------------
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
                              "Monthly Mortgage Payment",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Your current mortgage payment amount",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.monetization_on_outlined,
                              ),
                              controller: _propertyController1,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
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

  @override
  void dispose() {
    _propertyController1.dispose();
    //_livingExpensesController.dispose();
    super.dispose();
  }
}
