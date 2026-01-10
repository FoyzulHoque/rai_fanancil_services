import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';

class RowTypeCustomButton extends StatelessWidget {
  const RowTypeCustomButton({
    super.key,
    this.onTapAddProperty,
    this.onTapUseInCalculator,
    required this.leftButtonText,
    required this.rightButtonText,
    this.borderColorLeft,
    this.borderColorRight,
    this.leftTextColor,
    this.rightTextColor,
  });

  final VoidCallback? onTapAddProperty;
  final VoidCallback? onTapUseInCalculator;

  final String leftButtonText;
  final String rightButtonText;

  final Color? borderColorLeft;
  final Color? borderColorRight;
  final Color? leftTextColor;
  final Color? rightTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// LEFT BUTTON
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              side: BorderSide(
                color: borderColorLeft ?? AppColors.grey,
              ),
            ),
            onPressed: onTapAddProperty,
            child: Text(
              leftButtonText,
              style: TextStyle(
                color: leftTextColor ?? AppColors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        /// RIGHT BUTTON
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              side: BorderSide(
                color: borderColorRight ?? AppColors.primary,
              ),
            ),
            onPressed: onTapUseInCalculator,
            child: Text(
              rightButtonText,
              style: TextStyle(
                color: rightTextColor ?? AppColors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
