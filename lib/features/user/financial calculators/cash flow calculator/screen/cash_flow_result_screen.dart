import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/themes/app_colors.dart';
import '../../../user navbar/controller/navbar_controller.dart';
import '../controller/property_dropdown_controller.dart';
import '../widget/castom_chart_widget.dart';

class CashFlowResultScreen extends StatelessWidget {
  CashFlowResultScreen({super.key});

  final PropertyDropdownController propertyDropdownController = Get.put(
    PropertyDropdownController(),
  );
  final UserBottomNavbarController navbarController = Get.find<UserBottomNavbarController>();
  final GlobalKey _pageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(color: AppColors.blue),
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
                        "Cash Flow Result",
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
                  key: _pageKey, // Attach the key here
                  child: Column(
                    children: [
                      Container(
                        height: 78.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.colorList[0],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Net Monthly Cashflow",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$625",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Card(
                            elevation: 5,
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Breakdown",
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  breakdownRow(
                                    title: "Monthly Rental Income",
                                    value: "\$2,800",
                                  ),
                                  breakdownRow(
                                    title: "Total Expenses",
                                    value: "\$930",
                                    valueColor: AppColors.warning,
                                  ),
                                  breakdownRow(
                                    title: "Loan Repayment",
                                    value: "\$2,063",
                                    valueColor: AppColors.warning,
                                  ),
                                  breakdownRow(
                                    title: "Other Income",
                                    value: "\$818",
                                  ),
                                  breakdownRow(
                                    title: "Net Cashflow",
                                    value: "\$625",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CashFlowBarChart(
                        title: "6-Month Cashflow Trend",
                        months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                        incomeData: [2800, 3000, 2900, 2700, 2900, 2850],
                        expenseData: [2200, 2100, 2300, 2150, 2200, 2350],
                        incomeColor: AppColors.success,
                        expenseColor: AppColors.red,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(

                            onPressed: () async {
                               // Add a small delay to ensure the UI is stable
                               await Future.delayed(const Duration(milliseconds: 50));
                               final imageBytes = await captureFullPage();
                               if (imageBytes != null) {
                                 final pdfFile = await generatePdf(imageBytes);
                                 await printPdf(pdfFile);
                               }
                            },
                            icon: const Icon(Icons.print, color: Colors.blue),
                            label: const Text("Print Full Page"),
                             style: ElevatedButton.styleFrom(
                                side: BorderSide(color: AppColors.primary, width: 1),
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

  Widget breakdownRow({
    required String title,
    required String value,
    Color valueColor = AppColors.grey,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
// file print
  Future<void> printPdf(File file) async {
    await Printing.layoutPdf(
      onLayout: (format) async => file.readAsBytes(),
    );
  }
// screen short
  Future<Uint8List?> captureFullPage() async {
    try {
      RenderRepaintBoundary boundary =
      _pageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not capture the page. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error capturing widget: $e");
      return null;
    }
  }
// file generate pdf
  Future<File> generatePdf(Uint8List imageBytes) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(image),
        );
      },
    ));

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/cash_flow_report.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
