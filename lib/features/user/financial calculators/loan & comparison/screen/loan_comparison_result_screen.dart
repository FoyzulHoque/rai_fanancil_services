import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../widget/loan_comparison_result_body_widget.dart';


class LoanAndComparisonResultScreen extends StatelessWidget {
  LoanAndComparisonResultScreen({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  final UserBottomNavbarController navbarController =
  Get.find<UserBottomNavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            // ── 1. Fixed header ────────────────────────────────
            Container(
              height: 70,
              decoration: BoxDecoration(color: AppColors.deepGrey),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      "assets/icons/moves_right.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Loan Comparison",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: RepaintBoundary(
                  key: pageKey, // Attach the key here
                  child: Column(
                    children: [
                      // ── 2. Scrollable results list (grows with content) ──
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return LoanComparisonResultBodyWidget(
                            bankName: "Bank of States",
                            bankSubName: "Basic Variable Rate Home Loan",
                            interestRate: "6.19%",
                            comparisonRate: "6.20%",
                            monthlyRepayment: "\$3,195",
                            isNoMonthlyFeeTrue: true,
                            isRedrawfacilityTrue: true,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      // ── 3. Bottom action buttons (stay together) ───────
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              // Add a small delay to ensure the UI is stable
                              await Future.delayed(
                                const Duration(milliseconds: 50),
                              );
                              final imageBytes = await captureFullPage();
                              if (imageBytes != null) {
                                final pdfFile = await generatePdf(imageBytes);
                                await printPdf(pdfFile);
                              }
                            },
                            icon: const Icon(Icons.print, color: Colors.blue),
                            label: const Text("Print Full Page"),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              navbarController.financialCalculatorsScreen();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text("Down"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
