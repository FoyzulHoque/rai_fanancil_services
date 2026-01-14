import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';

class LoanComparisonResultBodyWidget extends StatelessWidget {
  const LoanComparisonResultBodyWidget({
    super.key,
    this.bankName,
    this.bankSubName,
    this.interestRate,
    this.comparisonRate,
    this.monthlyRepayment,
    this.isOffsetAccountTrue = false,
    this.isRedrawfacilityTrue = false,
    this.isNoMonthlyFeeTrue = false,
  });

  final String? bankName;
  final String? bankSubName;
  final String? interestRate;
  final String? comparisonRate;
  final String? monthlyRepayment;

  /// ✅ Non-nullable bool with default false
  final bool isOffsetAccountTrue;
  final bool isRedrawfacilityTrue;
  final bool isNoMonthlyFeeTrue;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: Border.all(style: BorderStyle.none),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- BANK INFO ----------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/dallor_house.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankName ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      bankSubName ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ---------- RATE INFO ----------
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Interest Rate",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      interestRate ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Comparison Rate",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      comparisonRate ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(),

            /// ---------- MONTHLY ----------
            const Text(
              "Monthly Repayment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
            ),
            Text(
              monthlyRepayment ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),

            const Divider(),

            /// ---------- FEATURES ----------
            const Text(
              "Features",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 6),

            _featureRow(
              title: "Offset account",
              isAvailable: isOffsetAccountTrue,
            ),
            _featureRow(
              title: "Redraw facility",
              isAvailable: isRedrawfacilityTrue,
            ),
            _featureRow(
              title: "No monthly fee",
              isAvailable: isNoMonthlyFeeTrue,
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- REUSABLE FEATURE ROW ----------
  Widget _featureRow({
    required String title,
    required bool isAvailable,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isAvailable ? Icons.check : Icons.close,
            size: 20,
            color: isAvailable ? AppColors.greenDip : AppColors.red,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
