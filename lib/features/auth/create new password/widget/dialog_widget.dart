import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/themes/app_colors.dart';
import '../../signin/screens/signin_screens.dart';

class DialogScreen extends StatelessWidget {
  final VoidCallback onContinue;

  const DialogScreen({Key? key, required this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      contentPadding: EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/popup_new.png",
            height: 100,
            width: 100,
          ),
          SizedBox(height: 20),
          Text(
            'Congratulations'.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primary,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your new password has been successfully.'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkGrey,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continue'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
