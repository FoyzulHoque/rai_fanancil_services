import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/text_styles.dart';
import 'custom_button.dart';

class CustomPopup extends StatelessWidget {
  final String customText;
  final String buttonText;

  // ✅ match CustomFloatingButton's onPressed type
  final Future<void> Function()? onButtonPressed;

  const CustomPopup({
    Key? key,
    required this.customText,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/popup.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 16),

            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                customText,
                style: AppTextStyles.body.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFloatingButton(
                customBackgroundColor: AppColors.primary,
                textColors: Colors.white,
                onPressed: onButtonPressed, // ✅ now matches
                buttonText: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
