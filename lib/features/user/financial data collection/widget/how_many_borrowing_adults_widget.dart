import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../controller/set_up_your_financial_profile_controller.dart';

class HowManyBorrowingAdultsWidget extends StatelessWidget {
  const HowManyBorrowingAdultsWidget({
    super.key,
    this.minAdults = 1,
    this.maxAdults = 8,
    this.cardElevation = 2.0,
    this.headerElevation = 3.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(20.0),
    this.labelStyle,
    this.hintStyle,
  });

  final int minAdults;
  final int maxAdults;
  final double cardElevation;
  final double headerElevation;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetUpYourFinancialProfileController());

    return Obx(() => Column(
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
                  "How many borrowing adults?",
                  style: labelStyle ??
                      TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Include all adults applying for the loan",
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
                        onPressed: controller.removeAdult,
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                      ),
                      const SizedBox(width: 48),
                      Text(
                        "${controller.adultCount.value}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 48),
                      _buildControlButton(
                        icon: Icons.add,
                        onPressed: controller.addAdult,
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
          controller.adultControllers.length,
              (index) => _buildAdultCard(controller, index),
        ),
      ],
    ));
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
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }

  Widget _buildAdultCard(SetUpYourFinancialProfileController controller, int index) {
    final ctrls = controller.adultControllers[index];

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
              "Adult ${index + 1}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.montserrat().fontFamily,
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
              onTap: () {
                // TODO: show date picker
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: ctrls['email'],
              decoration: InputDecoration(
                labelText: "Email Address",
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: ctrls['phone'],
              decoration: InputDecoration(
                labelText: "Phone Number",
                prefixIcon: const Icon(Icons.phone_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}