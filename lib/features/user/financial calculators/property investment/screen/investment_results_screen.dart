import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custome_container.dart';
import '../../../../../core/widgets/full_page_pdf_make_widget.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../../cash flow calculator/controller/property_dropdown_controller.dart';
import '../widget/capital_growth_forecast_widget.dart';

class InvestmentResultsScreen extends StatelessWidget {
  InvestmentResultsScreen({super.key});

  final PropertyDropdownController propertyDropdownController =
  Get.put(PropertyDropdownController());
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
              // ✅ Header (purple)
              Container(
                height: 56,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.indicator),
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
                          "Investment Results",
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
                        // ✅ Top ROI gradient card (10-Year ROI)
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
                                "10-Year ROI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "187.6%",
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

                        // ✅ Annual Cashflow + Capital Growth (two small boxes)
                        Row(
                          children: [
                            Expanded(
                              child: _SmallStatBox(
                                title: "Annual Cashflow",
                                value: "\$18,600",
                                borderColor: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SmallStatBox(
                                title: "Capital Growth",
                                value: "\$296,695",
                                borderColor: AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // ✅ Select property + dropdown
                        const Text(
                          "Select property",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          value: propertyDropdownController
                              .selectedProperty.value,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          isExpanded: true,
                          items: propertyDropdownController.properties
                              .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                              .toList(),
                          onChanged:
                          propertyDropdownController.changeProperty,
                        ),

                        const SizedBox(height: 12),

                        // ✅ Capital Growth Forecast card (chart widget)
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CapitalGrowthForecastChart(
                              years: const [1, 3, 5, 7, 10],
                              propertyValues: const [
                                850000,
                                950000,
                                1050000,
                                1150000,
                                1300000
                              ],
                              equityValues: const [
                                250000,
                                320000,
                                380000,
                                450000,
                                580000
                              ],
                              title: "Capital Growth Forecast",
                              height: 250,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Insurance Estimate (card style like screenshot)
                        _Title("Insurance Estimate"),
                        Card(
                          elevation: 3,
                          color: AppColors.primary.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: const [
                                _RowValue(
                                    label: "Building Insurance",
                                    value: "\$1,850/year"),
                                Divider(height: 18),
                                _RowValue(
                                    label: "Landlord Insurance",
                                    value: "\$650/year"),
                                Divider(height: 18),
                                _RowValue(
                                    label: "Total Insurance",
                                    value: "\$2,500/year"),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Tax Impact (Annual)
                        _Title("Tax Impact (Annual)"),
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: const [
                                _RowValue(
                                    label: "Rental Income", value: "\$33,800"),
                                Divider(height: 18),
                                _RowValue(
                                  label: "Deductible Expenses",
                                  value: "-\$15,200",
                                  valueColor: Colors.red,
                                ),
                                Divider(height: 18),
                                _RowValue(
                                  label: "Depreciation",
                                  value: "-\$8,500",
                                  valueColor: Colors.red,
                                ),
                                Divider(height: 18),
                                _RowValue(
                                    label: "Taxable Income",
                                    value: "\$10,100"),
                                Divider(height: 18),
                                _RowValue(
                                  label: "Estimated Tax (32.5%)",
                                  value: "-\$3,283",
                                  valueColor: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ✅ Portfolio Statistics
                        _Title("Portfolio Statistics"),
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: const [
                                _RowValue(
                                    label: "Number of Properties",
                                    value: "2"),
                                Divider(height: 18),
                                _RowValue(
                                    label: "Total Loans", value: "\$1,124,000"),
                                Divider(height: 18),
                                _RowValue(
                                    label: "Average LVR", value: "80.0%"),
                                Divider(height: 18),
                                _RowValue(
                                    label: "Annual Rental Income",
                                    value: "\$62,400"),
                                Divider(height: 18),
                                _RowValue(
                                  label: "Annual Expenses",
                                  value: "\$19,200",
                                  valueColor: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ✅ Export PDF (outlined) — like screenshot
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 50));
                              final imageBytes = await captureFullPage();
                              if (imageBytes != null) {
                                final pdfFile = await generatePdf(imageBytes);
                                await printPdf(pdfFile);
                              }
                            },
                            icon: const Icon(Icons.download,
                                color: Colors.black54),
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
                                  width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
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

// ---------- helpers (UI exact) ----------

class _Title extends StatelessWidget {
  final String text;
  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

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
      height: 60,
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

class _RowValue extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _RowValue({
    required this.label,
    required this.value,
    this.valueColor = Colors.black87,
  });

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
