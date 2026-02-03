import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final Future<void> Function()? onPressed; // ✅ async + nullable
  final String buttonText;
  final double height;
  final Color? customBackgroundColor;
  final Color? textColors;

  // ✅ added
  final bool isLoading;

  const CustomFloatingButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.height = 50.0,
    this.customBackgroundColor,
    this.textColors,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : (onPressed == null ? null : () async => await onPressed!()),
        style: ElevatedButton.styleFrom(
          backgroundColor: customBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: isLoading
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColors ?? Colors.white,
              ),
            ),
          ],
        )
            : Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColors ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
