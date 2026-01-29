import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../../core/themes/app_colors.dart';
import '../widget/set_up_widget.dart';
import 'household_&_borrowing_profile.dart';

class SetUpYourFinancialProfile extends StatelessWidget {
  const SetUpYourFinancialProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Scrollable main content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 55,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColors,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Set Up Your Financial Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Complete your financial profile to unlock accurate calculations and insights tailored to your property investment journey.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.92),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.45,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Setup Items Section ───────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SetupItem(
                          boxColor: AppColors.infoLight,
                          iconColor: AppColors.primaryDife,
                          imagePath: "assets/icons/up_graph.png",
                          title: "Faster Calculations",
                          subtitle:
                          "Pre-filled data saves time on every property analysis",
                        ),
                        const SizedBox(height: 12),

                        SetupItem(
                          boxColor: AppColors.infoLight,
                          iconColor: AppColors.primaryDife,
                          imagePath: "assets/icons/calculators_icon.png",
                          title: "Accurate Results",
                          subtitle:
                          "Precise loan estimates and tax calculations based on your situation",
                        ),
                        const SizedBox(height: 12),

                        SetupItem(
                          boxColor: AppColors.infoLight,
                          iconColor: AppColors.primaryDife,
                          imagePath: "assets/icons/lock.png",
                          title: "Editable Anytime",
                          subtitle:
                          "Update your profile whenever your financial situation changes",
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom Fixed Button ───────────────────────────────────────
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
                Get.to(()=>HouseholdBorrowingProfile());
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
              child: const Text("Start Setup"),
            ),
          ),
        ],
      ),
    );
  }
}