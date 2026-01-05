import 'package:flutter/material.dart';


class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText; // Text to be displayed inside the button
  final double height;
  final Color? customBackgroundColor;  // Height of the button
  final Color? textColors;  // Height of the button

  const CustomFloatingButton({
    required this.onPressed,
    required this.buttonText,
    this.height = 50.0,  // Default height of the button
    Key? key,
     this.customBackgroundColor,
    this.textColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make the button take the full width
      height: height, // Height of the button
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:customBackgroundColor, // Use AppColors.btncolor for button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Rounded corners
          ),
         // elevation: 6.0, // Shadow below the button
        ),
        child: Text(
          buttonText, // Button text
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColors
          ),
        ),
      ),
    );
  }
}
