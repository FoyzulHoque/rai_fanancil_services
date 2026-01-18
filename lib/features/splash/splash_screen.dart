import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/themes/app_colors.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Top Text
          Positioned(
            top: 380,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "R-Money by",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  // Fix: pick a single Color from colorList
                  color: AppColors.colorList.isNotEmpty
                      ? AppColors.colorList[0]
                      : Colors.black,
                ),
              ),
            ),
          ),

          // Centered Logo
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image.asset(
                'assets/logos/Primary-Logo 1.png',
                height: 150,
                width: 150,
              ),
            ),
          ),

          // Loader at the bottom
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: SpinKitCircle(
                color: AppColors.primary,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
