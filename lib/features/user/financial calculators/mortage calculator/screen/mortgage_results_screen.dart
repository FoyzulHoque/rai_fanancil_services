import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../widget/payment_breakdown_chart_widget.dart';

class MortgageResultScreen extends StatelessWidget {
  MortgageResultScreen({super.key});

  final UserBottomNavbarController navbarController =
      Get.find<UserBottomNavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              // ✅ Header (orange)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.warning),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Mortgage Results",
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

              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: RepaintBoundary(
                    key: pageKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Monthly Repayment gradient card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.95),
                                AppColors.blue.withOpacity(0.85),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monthly Repayment",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "\$2,908",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ✅ Loan Amount + Interest Rate boxes
                        Row(
                          children: const [
                            Expanded(
                              child: _SmallStatBox(
                                title: "Loan Amount",
                                value: "\$450,000",
                                borderColor: AppColors.greenDip,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _SmallStatBox(
                                title: "Interest Rate",
                                value: "5.5%",
                                borderColor: AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // ✅ Monthly Payment Options card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE6E6E6)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Monthly Payment Options",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "For the first 10 months for Interest Only (IO)",
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // IO block (blue light)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F6FB),
                                  border: Border.all(
                                    color: const Color(0xFFCFEAF5),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Interest Only (IO)",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "\$2,063",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "per month",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.attach_money,
                                          color: AppColors.primary,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const _MiniRow(
                                      label: "Total Interest (30 years)",
                                      value: "\$742,500",
                                      valueColor: Colors.red,
                                    ),
                                    const _MiniRow(
                                      label: "Principal Still Owing",
                                      value: "\$450,000",
                                    ),
                                    const _MiniRow(
                                      label: "Total to Repay",
                                      value: "\$1,192,500",
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "From months 10-1 to the end",
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // P&I block (green light)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF9F0),
                                  border: Border.all(
                                    color: const Color(0xFFCFEFDB),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Principal & Interest (P&I)",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "\$2,555",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.green,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "per month",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.green,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const _MiniRow(
                                      label: "Total Interest (30 years)",
                                      value: "\$469,818",
                                      valueColor: Colors.red,
                                    ),
                                    const _MiniRow(
                                      label: "Principal Paid",
                                      value: "\$450,000",
                                    ),
                                    const _MiniRow(
                                      label: "Total to Repay",
                                      value: "\$919,818",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Payment Breakdown card (pie)
                        PaymentBreakdownChart(
                          principalAmount: 450000,
                          interestAmount: 423000,
                          pieSize: 220,
                        ),

                        const SizedBox(height: 12),

                        // ✅ Borrowing Position card (blue light)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9EEF8),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Your Borrowing Position",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              _BorrowRow(
                                label: "Deposit (LVR)",
                                value: "\$90,000 (16.7%)",
                              ),
                              SizedBox(height: 6),
                              _BorrowRow(
                                label: "Loan Amount",
                                value: "\$450,000",
                              ),
                              SizedBox(height: 6),
                              _BorrowRow(
                                label: "Property Value",
                                value: "\$540,000",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ✅ Export PDF button (outlined)
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await Future.delayed(
                                const Duration(milliseconds: 50),
                              );
                              final imageBytes = await captureFullPage();
                              if (imageBytes != null) {
                                final pdfFile = await generatePdf(imageBytes);
                                await printPdf(pdfFile);
                              }
                            },
                            icon: const Icon(
                              Icons.download,
                              color: Colors.black54,
                            ),
                            label: const Text(
                              "Export PDF",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.primary.withOpacity(0.35),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Done button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              navbarController.financialCalculatorsScreen();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: const Text("Done"),
                          ),
                        ),

                        const SizedBox(height: 18),
                      ],
                    ),
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

// ---------------- small widgets ----------------

class _SmallStatBox extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;

  const _SmallStatBox({
    required this.title,
    required this.value,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor.withOpacity(0.45), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _MiniRow({
    required this.label,
    required this.value,
    this.valueColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: valueColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BorrowRow extends StatelessWidget {
  final String label;
  final String value;

  const _BorrowRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
