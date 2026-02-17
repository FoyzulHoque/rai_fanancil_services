import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class SelectButtonWidget extends StatefulWidget {
  final String? initialValue; // Add initialValue parameter
  final ValueChanged<String>? onSelected; // Optional: parent ke selected value pathabe

  const SelectButtonWidget({
    super.key,
    this.initialValue,
    this.onSelected,
  });

  @override
  State<SelectButtonWidget> createState() => _SelectButtonWidgetState();
}

class _SelectButtonWidgetState extends State<SelectButtonWidget> {
  late String _selectedItem; // Changed from final to late

  final List<String> _items = ["Primary", "Investment", "SMSF"];

  @override
  void initState() {
    super.initState();
    // Initialize with widget.initialValue if provided, otherwise use default
    _selectedItem = widget.initialValue ?? "Primary";
  }

  @override
  void didUpdateWidget(SelectButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update if initialValue changes
    if (widget.initialValue != oldWidget.initialValue && widget.initialValue != null) {
      setState(() {
        _selectedItem = widget.initialValue!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Button Group
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _items.map((item) {
            final bool isSelected = _selectedItem == item;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedItem = item;
                });
                widget.onSelected?.call(item);
                print("Selected: $item"); // debug
              },
              child: Container(
                width: 110,
                height: 42,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryDife : AppColors.textIt,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.white : AppColors.black.withOpacity(0.7),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}