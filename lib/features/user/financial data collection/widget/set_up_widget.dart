import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart'; // adjust path if needed

class SetupItem extends StatelessWidget {
  const SetupItem({
    super.key,
    required this.boxColor,
    required this.iconColor,
    required this.imagePath,
    this.title,
    this.subtitle,
    this.onTap,
    this.iconSize = 24.0,
    this.boxSize = 48.0,
    this.backgroundColor = Colors.white, // ← new optional parameter
    this.elevation = 0.0,               // ← optional subtle shadow
  });

  final Color boxColor;
  final Color iconColor;
  final String imagePath;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final double iconSize;
  final double boxSize;
  final Color backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,           // White background
      elevation: elevation,             // 0 = flat, 1–2 = subtle card look
      borderRadius: BorderRadius.circular(0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon container
              Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: boxColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  imagePath,
                  width: iconSize,
                  height: iconSize,
                  color: iconColor,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.error_outline_rounded,
                    color: iconColor.withOpacity(0.7),
                    size: iconSize,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Text content
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null && title!.isNotEmpty)
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          height: 1.2,
                        ),
                      ),

                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      if (title != null && title!.isNotEmpty)
                        const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              if (onTap != null)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.grey,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}