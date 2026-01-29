import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../controller/borrowing_dependents_controller.dart';

class BorrowingDependentsForm extends StatelessWidget {
  const BorrowingDependentsForm({
    super.key,
    this.minAdults = 1,
    this.maxAdults = 10,
    this.cardElevation = 2.0,
    this.headerElevation = 3.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(20.0),
    this.labelStyle,
    this.hintStyle,
    this.controller,
  });

  final int minAdults;
  final int maxAdults;
  final double cardElevation;
  final double headerElevation;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final BorrowingDependentsController? controller;

  @override
  Widget build(BuildContext context) {
    // Safe creation – controller is always non-null after this line
    final ctrl = controller ?? Get.put(
      BorrowingDependentsController(
        minAdults: minAdults,
        maxAdults: maxAdults,
      ),
    );

    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + Counter Card
          Card(
            color: AppColors.white,
            elevation: headerElevation,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How many dependents?",
                    style: labelStyle ??
                        const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Children or others financially dependent on you",
                    style: hintStyle ??
                        TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(height: 24),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildControlButton(
                          icon: Icons.remove,
                          onPressed: ctrl!.removeDependents,
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black87,
                        ),
                        const SizedBox(width: 48),
                        Text(
                          "${ctrl.adultCount.value}",
                          style: TextStyle(
                            fontSize:30,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 48),
                        _buildControlButton(
                          icon: Icons.add,
                          onPressed: ctrl.addDependents,
                          backgroundColor: AppColors.primaryDife,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Dynamic adult cards
          ...List.generate(
            ctrl.adultControllers.length,
                (index) => _buildAdultCard(ctrl, index, borderRadius),
          ),

          const SizedBox(height: 100), // space for bottom buttons if needed
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.all(14),
        minimumSize: const Size(40, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // ✅ perfect square
        ),
      ),
    );
  }

  Widget _buildAdultCard(
      BorrowingDependentsController ctrl,
      int index,
      double borderRadius,
      ) {
    final ctrls = ctrl.adultControllers[index];

    return Card(
      color: AppColors.white,
      elevation: cardElevation,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dependents ${index + 1}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: ctrls['name'],
              decoration: InputDecoration(
                labelText: "Full Name",
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: ctrls['dob'],
              decoration: InputDecoration(
                labelText: "Date of Birth",
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
              readOnly: true,
              onTap: () {
                // TODO: show date picker
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}