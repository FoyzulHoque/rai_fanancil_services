import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/themes/app_colors.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  String? title,
  String? subtitle,
  String? confirmText = "Confirm",
  VoidCallback? onConfirm,
  String cancelText = "Cancel",
  Color confirmColor = Colors.red,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],

              if (subtitle != null)
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.secondaryColors),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        cancelText,
                        style: TextStyle(color: AppColors.secondaryColors, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: GoogleFonts.montserrat().fontFamily),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        confirmText!,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: GoogleFonts.montserrat().fontFamily),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}