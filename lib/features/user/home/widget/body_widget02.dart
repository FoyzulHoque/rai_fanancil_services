import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class BodyWidget02 extends StatelessWidget {
  const BodyWidget02({
    super.key,
    this.containerColor,
    this.borderColor,
    this.boxColor,
    this.iconColor,
    this.textColor3,
    this.borderWidth = 1.0,
    this.title,
    this.image,
    this.totalAmount,
    this.totalPercent,
    this.totalPercentText,
  });

  final Color? containerColor;
  final Color? borderColor;
  final Color? boxColor;
  final Color? iconColor;
  final Color? textColor3;
  final double borderWidth;
  final String? title;
  final String? image; // assets path, e.g., "assets/icons/wallet.png"
  final String? totalAmount;
  final String? totalPercent;
  final String? totalPercentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // ভিতরে সমান স্পেসিং
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
        border: Border.all(
          color: borderColor ?? Colors.grey.shade300,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(12), // কার্ড লুকের জন্য
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // টেক্সট সেকশন
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      totalAmount ?? "0",
                      style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title ?? "",
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // আইকন বক্স
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: boxColor ?? Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  image ?? "assets/icons/default.png", // fallback image
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // পার্সেন্টেজ রো
          Row(
            children: [
              Text(
                totalPercent ?? "",
                style: TextStyle(
                  color: textColor3 ?? Colors.green, // সাধারণত গ্রিন/রেড
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "vs",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                totalPercentText ?? "last month",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}