import 'package:flutter/material.dart';

class BodyWidget02 extends StatelessWidget {
  final Color containerColor;
  final Color borderColor;
  final Color boxColor; // not used but kept (don’t break your structure)
  final Color iconColor;
  final Color textColor3;
  final String title;
  final String image;
  final String totalAmount;
  final String totalPercent;
  final String totalPercentText;

  const BodyWidget02({
    super.key,
    required this.containerColor,
    required this.borderColor,
    required this.boxColor,
    required this.iconColor,
    required this.textColor3,
    required this.title,
    required this.image,
    required this.totalAmount,
    required this.totalPercent,
    required this.totalPercentText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  totalAmount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      totalPercent,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: textColor3,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      totalPercentText,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Icon(Icons.show_chart, color: iconColor, size: 18),
          ),
        ],
      ),
    );
  }
}
