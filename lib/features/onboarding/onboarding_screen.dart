import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/themes/app_colors.dart';
import '../auth/signin/screens/signin_screens.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Top Text
                  Positioned(
                    top: 160,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Manage your finances",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: AppColors.primary,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 370.97,
                      child: Image.asset(
                        "assets/images/onboarding_one.png",
                        height: screenHeight * 0.55,
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Subtitle
            Text(
              "Instant insights for\nany property, anytime.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontSize: 28,
                  letterSpacing: -2),
            ),
            const SizedBox(height: 12),
            Text(
              "Turn your financial data into simple insights.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontSize: 14),
            ),

            const Spacer(),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
