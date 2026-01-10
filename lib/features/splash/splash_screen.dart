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
      body: Column(
        children: [
          // This will push the logo to center and loader to bottom
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // This centers the logo
              children: [
                // Centered Logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image.asset(
                    'assets/logos/Primary-Logo 1.png',
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
          
          // Loader at the bottom with gap
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: SpinKitCircle(
              color: AppColors.primary,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}