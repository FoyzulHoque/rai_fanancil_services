import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../auth/signin/screens/signin_screens.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of titles and subtitles for each onboarding page
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Find Your Perfect Stay, Anytime, Anywhere",
      "subtitle": "Discover thousands of hotels across the globe,\nfrom cozy budget rooms to luxury resorts.",
      "image": "assets/images/onboarding1.png"
    },
    {
      "title": "Book in Seconds,\nTravel with Confidence",
      "subtitle": "Enjoy a smooth, secure, and effortless booking experience to make travel planning stress-free.",
      "image": "assets/images/onboarding2.png"
    },
    {
      "title": "Manage All Your \nBookings in One Place",
      "subtitle": "Track reservations, modify dates, or cancel bookings anytime, anywhere — complete control, made simple.",
      "image": "assets/images/onboarding3.png"
    }
  ];

  // Function to update the current page
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // PageView for images at the top (3/5 of screen height)
          Container(
            height: MediaQuery.of(context).size.height * 3 / 5,
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: onboardingData.map((data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity, // Ensure it takes full width
                    height: MediaQuery.of(context).size.height * 3 / 5, // Ensure proper height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: AssetImage(data["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Content area that can scroll if needed
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Title Text below the image (Horizontally centered)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    child: Text(
                      onboardingData[_currentPage]["title"]!,
                      style: AppTextStyles.title,
                      textAlign: TextAlign.center, // Horizontally center the title
                    ),
                  ),

                  // Subtitle Text with center alignment
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      onboardingData[_currentPage]["subtitle"]!,
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.center, // Center-aligned subtitle
                    ),
                  ),
                  SizedBox(height: 32),

                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onboardingData.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: _currentPage == index ? 36 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Custom Floating Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusted alignment
              children: [
                Expanded( // Ensure proper space for buttons
                  child: CustomFloatingButton(
                      customBackgroundColor: AppColors.secondaryColors,
                      textColors: AppColors.black,
                      onPressed: (){
                    Get.to(LoginScreen());
                  }, buttonText: "Skip"),
                ),
                const SizedBox(width: 4), // Extra space at the left
                Expanded(
                  child: CustomFloatingButton(
                    textColors: AppColors.defaultTextColor,
                    customBackgroundColor: AppColors.black,
                    onPressed: () {
                      if (_currentPage < onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        // Navigate to Login Screen using Get.to()
                        Get.to(LoginScreen());  // Navigate to Login Screen here
                      }
                    },
                    buttonText: _currentPage == onboardingData.length - 1 ? 'Get Started' : 'Next',
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16), // Extra space at the bottom
        ],
      ),
    );
  }
}
