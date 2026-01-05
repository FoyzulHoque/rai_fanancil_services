import 'package:flutter/material.dart';
import '../../../../../../core/themes/app_colors.dart';
import 'dates_widget.dart';
import 'flexible_widget.dart';
import 'months_widget.dart';

class CalenderDialogBoxWidget extends StatefulWidget {
  const CalenderDialogBoxWidget({super.key});

  @override
  State<CalenderDialogBoxWidget> createState() =>
      _CalenderDialogBoxWidgetState();
}

class _CalenderDialogBoxWidgetState extends State<CalenderDialogBoxWidget> {
  final List<String> pageList = ["Dates", "Months", "Flexible"];
  int selectedIndex = 0;
  late Widget selectedWidget;

  @override
  void initState() {
    super.initState();
    selectedWidget = const DatesWidget();
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 0:
          selectedWidget = const DatesWidget();
          break;
        case 1:
          selectedWidget = const MonthsWidget(months: 3);
          break;
        case 2:
          selectedWidget = FlexibleWidget();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      title: const Text("When's your trip?"),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 380,
          maxWidth: 450,
        ),
        child: SizedBox(
          width: 400, // Added fixed width
          height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(pageList.length, (index) {
                  return GestureDetector(
                    onTap: () => _onTabSelected(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColors.infoSecondary
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        pageList[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              // Selected widget
              Expanded(
                child: selectedWidget,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.secondaryColors,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child:
              const Text("Skip", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.infoSecondary,
          ),
          onPressed: () {
            // Next logic here
          },
          child: const Text("Next", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}