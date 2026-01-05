import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../auth/signin/screens/signin_screens.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Spacer(),
             SizedBox(
               height: 580.97,
               width: 380,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [

                   SizedBox(
                     height: 370.97,
                     width: 380.97,
                     child: Image.asset("assets/images/onboarding1.png",fit: BoxFit.cover,),
                   ),
                   const SizedBox(height: 10,),
                   Text("Instant insights for\n any property, anytime.",style: TextStyle(color:AppColors.black,fontWeight: FontWeight.w700,fontSize: 32),),
                   const SizedBox(height: 10,),
                   Text("Turn your financial data into simple insights.",style: TextStyle(color:AppColors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                   const SizedBox(height: 10,),
                 ],
               ),
             ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // ✅ Square Button
                  ),
                  minimumSize: const Size(double.infinity, 50), // ✅ width full + height
                ),
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}
