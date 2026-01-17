import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class CheckBoxWidget extends StatelessWidget {
  final List<String> selectedOptions; // Changed to a list
  final ValueChanged<String>? onChanged; // Still notifies with a single change

  CheckBoxWidget({
    super.key,
    required this.selectedOptions,
    this.onChanged,
  });

  final List<String> _options = [
    "Own House",
    "Own house mortgage",
    "Renting",
    "Living with parents",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _options.map((option) {
        final bool isSelected = selectedOptions.contains(option); // Check if the list contains the option

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GestureDetector(
            onTap: () {
              if (onChanged != null) {
                onChanged!(option); // Notify parent of the tapped option
              }
            },
            child: Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondaryColors
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 18,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
