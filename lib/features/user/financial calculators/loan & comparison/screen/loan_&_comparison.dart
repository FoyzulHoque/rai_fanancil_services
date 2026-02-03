import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import 'loan_comparison_result_screen.dart';

class LoanAndComparisonScreen extends StatelessWidget {
  LoanAndComparisonScreen({super.key});

  final PropertyDropdownController propertyDropdownController =
  Get.put(PropertyDropdownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // Header (gray)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.deepGrey),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Loan Comparison",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Property",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Dropdown (Property1)
                      Obx(
                            () => DropdownButtonFormField<String>(
                          value:
                          propertyDropdownController.selectedProperty.value,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFE6E6E6), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFCCCCCC), width: 1.2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black54),
                          isExpanded: true,
                          items: propertyDropdownController.properties
                              .map((v) => DropdownMenuItem<String>(
                            value: v,
                            child: Text(
                              v,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                              .toList(),
                          onChanged: propertyDropdownController.changeProperty,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Current Rate + Best Market Rate
                      Row(
                        children: const [
                          Expanded(
                            child: _RateBox(
                              title: "Current Rate",
                              value: "6.24%",
                              borderColor: Color(0xFF34C38F),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _RateBox(
                              title: "Best Market Rate",
                              value: "5.49%",
                              borderColor: Color(0xFF34C38F),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Sydney card
                      _InfoCard(
                        borderColor: const Color(0xFFBFA7FF),
                        leftIcon: Icons.home_outlined,
                        leftIconColor: const Color(0xFF8E63FF),
                        title: "Sydney",
                        rows: const [
                          _InfoRow(
                            label: "Loan Balance",
                            value: "\$450,000",
                          ),
                          _InfoRow(
                            label: "Remaining Term",
                            value: "25 years",
                          ),
                          _InfoRow(
                            label: "Monthly Savings",
                            value: "\$189",
                            valueColor: Color(0xFF2ECC71),
                            prefixIcon: Icons.trending_up_rounded,
                            prefixIconColor: Color(0xFF2ECC71),
                          ),
                          _InfoRow(
                            label: "Total Interest Saved",
                            value: "\$56,788",
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Best Rates on the Market
                      _BestRatesCard(
                        rate: "5.49%",
                        subtitle: "R-Money by Rai Financial services",
                      ),

                      const SizedBox(height: 12),

                      // Why Work With Me?
                      _WhyWorkWithMeCard(),

                      const SizedBox(height: 16),

                      // Book Free Consultation button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // if you want: Get.to(() => BookScreen());
                          },
                          icon: const Icon(Icons.call,
                              color: Colors.white, size: 18),
                          label: const Text(
                            "Book Free Consultation",
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- UI Widgets ----------------

class _RateBox extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;

  const _RateBox({
    required this.title,
    required this.value,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor.withOpacity(0.6), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Color borderColor;
  final IconData leftIcon;
  final Color leftIconColor;
  final String title;
  final List<_InfoRow> rows;

  const _InfoCard({
    required this.borderColor,
    required this.leftIcon,
    required this.leftIconColor,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor.withOpacity(0.45), width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(leftIcon, color: leftIconColor, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...rows
              .map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: r,
          ))
              .toList(),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor = Colors.black87,
    this.prefixIcon,
    this.prefixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, color: prefixIconColor ?? valueColor, size: 16),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BestRatesCard extends StatelessWidget {
  final String rate;
  final String subtitle;

  const _BestRatesCard({
    required this.rate,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6FF),
        border: Border.all(color: const Color(0xFFBFE0FF), width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Best Rates on the Market",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            rate,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2E86DE),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhyWorkWithMeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const bullets = [
      "Access to 40+ lenders",
      "I'll find you the best rate, not just the big banks",
      "No cost to you",
      "Lenders pay me, so you save completely free",
      "Handle the paperwork",
      "I'll manage the entire refinance process for you",
      "Ongoing support",
      "Annual reviews to ensure you always have the best rate",
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1FF),
        border: Border.all(color: const Color(0xFFD8C6FF), width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Why Work With Me?",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          ...bullets.map(
                (t) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "•",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF8E63FF),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t,
                      style: const TextStyle(
                        fontSize: 11.8,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
