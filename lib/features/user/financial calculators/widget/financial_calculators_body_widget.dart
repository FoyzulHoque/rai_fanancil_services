import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class FinancialCalculatorsBodyWidget extends StatelessWidget {
  const FinancialCalculatorsBodyWidget({
    super.key,
    this.containerCustomColor,
    this.image,
    this.boxColor,
    this.iconColor,
    this.title,
    this.subTitle,
    this.onTab,
  });

  final Color? containerCustomColor;
  final String? image;
  final Color? boxColor;
  final Color? iconColor;
  final String? title;
  final String? subTitle;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // responsive
      height: 67,
      decoration: BoxDecoration(
        color: containerCustomColor,
        borderRadius: BorderRadius.circular(0),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(color: boxColor),
            padding: const EdgeInsets.all(8),
            child: image == null
                ? const SizedBox()
                : Image.asset(
              image!,
              fit: BoxFit.contain,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 8),

          /// text part flexible
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
                Text(
                  subTitle ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: onTab,
            child: Image.asset(
              'assets/icons/arrow_forward.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
