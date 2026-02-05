import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../controller/loan_comparison_controller.dart';
import '../controller/loan_property_dropdown_controller.dart';

class LoanAndComparisonScreen extends StatelessWidget {
  LoanAndComparisonScreen({super.key});

  final LoanPropertyDropdownController propertyDropdownController =
  Get.put(LoanPropertyDropdownController());

  final LoanComparisonController loanComparisonController =
  Get.put(LoanComparisonController());

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
                  child: Obx(() {
                    final showFull = loanComparisonController.showFullUI.value;
                    final data = loanComparisonController.comparison.value?.data;

                    return Column(
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
                            value: propertyDropdownController.selectedProperty.value.isEmpty
                                ? null
                                : propertyDropdownController.selectedProperty.value,
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

                        const SizedBox(height: 16),

                        // ✅ BEFORE API: show ONLY dropdown + Calculate button
                        if (!showFull) ...[
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: loanComparisonController.isLoading.value
                                  ? null
                                  : () async {
                                final propertyId =
                                propertyDropdownController.selectedPropertyId();

                                if (propertyId == null || propertyId.trim().isEmpty) {
                                  Get.snackbar("Error", "Please select a property",
                                      snackPosition: SnackPosition.BOTTOM);
                                  return;
                                }

                                await loanComparisonController.calculateLoanComparison(
                                  propertyId: propertyId.trim(),
                                );

                                if (loanComparisonController.showFullUI.value == false) {
                                  final msg = loanComparisonController.errorMessage.value.trim().isEmpty
                                      ? "Something went wrong"
                                      : loanComparisonController.errorMessage.value;
                                  Get.snackbar("Error", msg,
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              child: loanComparisonController.isLoading.value
                                  ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Text(
                                "Calculate",
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],

                        // ✅ AFTER API: show full UI (same layout)
                        if (showFull && data != null) ...[
                          // Current Rate + Best Market Rate
                          Row(
                            children: [
                              Expanded(
                                child: _RateBox(
                                  title: "Current Rate",
                                  value:
                                  "${data.currentRatePercent.toStringAsFixed(2)}%",
                                  borderColor: const Color(0xFF34C38F),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _RateBox(
                                  title: "Best Market Rate",
                                  value:
                                  "${data.bestMarketRatePercent.toStringAsFixed(2)}%",
                                  borderColor: const Color(0xFF34C38F),
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
                            title: data.propertySummary.location.split(" ").first.isEmpty
                                ? "Property"
                                : data.propertySummary.location.split(" ").first,
                            rows: [
                              _InfoRow(
                                label: "Loan Balance",
                                value: "\$${_money(data.propertySummary.loanBalance)}",
                              ),
                              _InfoRow(
                                label: "Remaining Term",
                                value: "${data.propertySummary.remainingTermYears.toStringAsFixed(0)} years",
                              ),
                              _InfoRow(
                                label: "Monthly Savings",
                                value: "\$${_money(data.savingsSummary.monthlySavings)}",
                                valueColor: const Color(0xFF2ECC71),
                                prefixIcon: Icons.trending_up_rounded,
                                prefixIconColor: const Color(0xFF2ECC71),
                              ),
                              _InfoRow(
                                label: "Total Interest Saved",
                                value: "\$${_money(data.savingsSummary.totalInterestSaved)}",
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Best Rates on the Market
                          _BestRatesCard(
                            rate: "${data.bestRateProvider.ratePercent.toStringAsFixed(2)}%",
                            subtitle: data.bestRateProvider.name,
                          ),

                          const SizedBox(height: 12),

                          // Why Work With Me? (API)
                          _WhyWorkWithMeCardFromApi(items: data.whyWorkWithMe),

                          const SizedBox(height: 16),

                          // Book Free Consultation button (same button spot)
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
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _money(num v) {
    final s = v.toStringAsFixed(0);
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(reg, (m) => ',');
  }
}

// ---------------- UI Widgets (UNCHANGED) ----------------

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

class _WhyWorkWithMeCardFromApi extends StatelessWidget {
  final List<dynamic> items; // WhyWorkItem list

  const _WhyWorkWithMeCardFromApi({required this.items});

  @override
  Widget build(BuildContext context) {
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
          ...items.map((e) {
            final title = (e.title ?? '').toString();
            final desc = (e.description ?? '').toString();

            return Padding(
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
                      "$title\n$desc",
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
            );
          }).toList(),
        ],
      ),
    );
  }
}
