import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services_class/shared_preferences_helper.dart';
import '../../core/themes/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });

    // ✅ After splash delay, decide navigation
    Timer(const Duration(seconds: 3), () async {
      bool? isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
      final role = await SharedPreferencesHelper.getUserRole();

      // You can modify this part to handle role-based navigation
      if (isLoggedIn == true) {
        if(role == "USER"){}
         // Get.offAll(() => BuyerNavBar());
        else if(role == "SELLER"){}
        //  Get.offAll(() => SellerNavBar());
        else if(role == "SERVICE_PROVIDER"){}
         // Get.offAll(() => ServiceProviderNavBar());
      } else {
        Get.offAll(() => OnboardingScreen());
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 400),
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/icons/logo_withtext.png',
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
