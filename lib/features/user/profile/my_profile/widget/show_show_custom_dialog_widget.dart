import 'package:flutter/material.dart';

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
    barrierDismissible: false, // optional: prevents closing by tapping outside
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
                        style: const TextStyle(color: AppColors.secondaryColors, fontSize: 16),
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
                        style: const TextStyle(color: Colors.white, fontSize: 16),
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