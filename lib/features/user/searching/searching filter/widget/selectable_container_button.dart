import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class SelectableContainerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableContainerButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //width: 262,
       // height:130 ,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColors : Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: isSelected ?AppColors.secondaryColors : Colors.grey.shade400,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
