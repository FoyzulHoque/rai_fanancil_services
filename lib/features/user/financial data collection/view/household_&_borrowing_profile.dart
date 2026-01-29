import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import '../widget/how_many_borrowing_adults_widget.dart';
import '../widget/how_many_borrowing_dependents_widget.dart';
import 'income_details.dart';

class HouseholdBorrowingProfile extends StatelessWidget {
  const HouseholdBorrowingProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
                  BorrowingAdultsForm(
                    minAdults: 0,
                    maxAdults: 8,
                    borderRadius: 16,
                    padding: const EdgeInsets.all(20),
                  ),
                  SizedBox(height: 12),
                  BorrowingDependentsForm(
                    minAdults: 0,
                    maxAdults: 8,
                    borderRadius: 16,
                    padding: const EdgeInsets.all(20),
                  ),
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
                Get.to(()=>IncomeDetailsScreen());
                // TODO: Start setup flow / navigation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 5, // shadow already on container
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // ← modern look (change to 0 if you want sharp)
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