import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class UserBodyWidget extends StatelessWidget {
  const UserBodyWidget({
    super.key,
    this.totalNumber,
    this.title,
    this.image,
    this.boxColor,
    this.iconColor,
  });
  final String? totalNumber;
  final String? title;
  final String? image;
  final Color? boxColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 71,
      width: 172,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColors, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$totalNumber",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "$title",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "$image",
                  width: 19.9,
                  height: 19.9,
                  fit: BoxFit.contain, // cover এর বদলে contain ভালো আইকনের জন্য
                  color: iconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
