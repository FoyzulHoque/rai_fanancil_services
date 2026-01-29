import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class CustomAppBarSetBeforeNaveBar extends StatelessWidget {
  const CustomAppBarSetBeforeNaveBar({
    super.key,
    this.title,
    this.appBarColor,
    required this.currentStep,    // changed to int for easy calculation
    required this.totalSteps,     // changed to int
    this.appBarHeight = 150,      // adjustable
  });

  final String? title;
  final Color? appBarColor;
  final int currentStep;          // e.g. 1, 2, 3...
  final int totalSteps;           // e.g. 6
  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    // Calculate progress (0.0 to 1.0)
    final double progress = totalSteps > 0 ? currentStep / totalSteps : 0.0;

    return Container(
      width: double.infinity,
      height: appBarHeight,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
      decoration: BoxDecoration(
        color: appBarColor ?? AppColors.primaryDife,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 12),
          // Title
          if (title != null && title!.isNotEmpty)
            Center(
              child: Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const Spacer(), // Use Spacer to fill available space
          // Step text + Progress bar
          // Replace the bottom Column with:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Step $currentStep of $totalSteps",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.92),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.70),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
