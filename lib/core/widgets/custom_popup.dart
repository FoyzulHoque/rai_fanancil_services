import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/text_styles.dart';
import 'custom_button.dart';

class CustomPopup extends StatelessWidget {
  final String customText;
  final String buttonText;
  final VoidCallback onButtonPressed; // Added onButtonPressed parameter

  const CustomPopup({
    required this.customText,
    required this.buttonText,
    required this.onButtonPressed, // Initialize onButtonPressed
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image at the top
            Image.asset(
              'assets/images/popup.png', // Replace with your asset path
              height: 100, // Adjust the height as needed
              width: 100, // Adjust the width as needed
            ),
            const SizedBox(height: 16), // Space between image and title

            // Title Text ("Congratulations!")
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary, // Your primary color
              ),
              textAlign: TextAlign.center, // Horizontally center the text
            ),
            const SizedBox(height: 16), // Space between title and custom text

            // Custom Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                customText, // Custom text passed to the popup
                style: AppTextStyles.body.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24), // Space between text and button

            // Custom Button at the bottom
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFloatingButton(
                onPressed: onButtonPressed, // Use onButtonPressed here
                buttonText: buttonText, // Custom text for the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}


