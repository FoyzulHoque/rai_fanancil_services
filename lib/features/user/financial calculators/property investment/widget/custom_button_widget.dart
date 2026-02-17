import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/select_custom_button_controller.dart';

class CustomSegmentSelector extends StatelessWidget {
  final String? initialValue;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color selectedColor;
  final Color selectedTextColor;
  final Color unSelectedTextColor;
  final Function(String)? onSelected;

  const CustomSegmentSelector({
    super.key,
    this.initialValue,
    this.height = 70,
    this.borderRadius = 6,
    this.backgroundColor = const Color(0xFF24BAED),
    this.selectedColor = const Color(0xFF0E77B7),
    this.selectedTextColor = Colors.white,
    this.unSelectedTextColor = Colors.black,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanTypeController());

    // Set initial value if provided
    if (initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (initialValue == "P&I") {
          controller.change(LoanType.pi);
        } else if (initialValue == "Interest Only") {
          controller.change(LoanType.interestOnly);
        }
      });
    }

    return Container(
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.45),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Obx(
            () => Row(
          children: [
            _CustomSegmentButton(
              title: 'P&I',
              isSelected: controller.isPI(),
              onTap: () {
                controller.change(LoanType.pi);
                if (onSelected != null) onSelected!('P&I');
              },
              selectedColor: selectedColor,
              selectedTextColor: selectedTextColor,
              unSelectedTextColor: unSelectedTextColor,
              radius: borderRadius - 2,
            ),
            _CustomSegmentButton(
              title: 'Interest Only',
              isSelected: controller.isInterestOnly(),
              onTap: () {
                controller.change(LoanType.interestOnly);
                if (onSelected != null) onSelected!('Interest Only');
              },
              selectedColor: selectedColor,
              selectedTextColor: selectedTextColor,
              unSelectedTextColor: unSelectedTextColor,
              radius: borderRadius - 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSegmentButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color selectedTextColor;
  final Color unSelectedTextColor;
  final double radius;

  const _CustomSegmentButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.selectedTextColor,
    required this.unSelectedTextColor,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? selectedTextColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}