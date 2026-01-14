import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

Widget breakdownRow({
  required String title,
  required String value,
  Color valueColor = AppColors.grey,
  Color? containerColors,
}) {
  return Container(
    decoration: BoxDecoration(
        color: containerColors
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          //const Divider(),
        ],
      ),
    ),
  );
}