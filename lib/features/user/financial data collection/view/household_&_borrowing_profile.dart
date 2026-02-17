import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../controller/set_up_your_financial_profile_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import '../widget/how_many_borrowing_adults_widget.dart';
import '../widget/how_many_borrowing_dependents_widget.dart';
import 'income_details.dart';

class HouseholdBorrowingProfile extends StatelessWidget {
  const HouseholdBorrowingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller if not already initialized
    Get.put(SetUpYourFinancialProfileController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          //-------------header part------------------
          CustomAppBarSetBeforeNaveBar(
            title: "Household & Borrowing Profile",
            currentStep: 1,
            totalSteps: 6,
            appBarColor: AppColors.secondaryColors,
          ),
          //----------Body part---------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  HowManyBorrowingAdultsWidget(),
                  SizedBox(height: 12),
                  HowManyBorrowingDependentsWidget(),
                ],
              ),
            ),
          ),
          //-----Button part---------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                final controller = Get.find<SetUpYourFinancialProfileController>();
                if (controller.validateAdultsData()) {
                  Get.to(() => IncomeDetailsScreen());
                } else {
                  Get.snackbar(
                    "Error",
                    "Please fill all adult details",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 5,
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
}