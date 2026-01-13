import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

class PdfExportButton extends StatelessWidget {
  final String title;                      // e.g., "Cash Flow Result"
  final String netCashflow;                // e.g., "\$625"
  final List<Map<String, dynamic>> breakdown; // [{'title': '...', 'value': '...', 'color': Colors.red}]
  final List<String> months;
  final List<double> incomeData;
  final List<double> expenseData;

  const PdfExportButton({
    super.key,
    required this.title,
    required this.netCashflow,
    required this.breakdown,
    required this.months,
    required this.incomeData,
    required this.expenseData,
  });

  Future<void> _exportToPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context ctx) => [
          // Header
          pw.Header(
            level: 0,
            child: pw.Text(title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 20),

          // Net Cashflow Box
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue800,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Net Monthly Cashflow", style: pw.TextStyle(fontSize: 18, color: PdfColors.white)),
                pw.SizedBox(height: 8),
                pw.Text(netCashflow, style: pw.TextStyle(fontSize: 22, color: PdfColors.white, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.SizedBox(height: 30),

          // Breakdown Table
          pw.Text("Breakdown", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          ...breakdown.map((row) => pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(row['title'], style: const pw.TextStyle(fontSize: 16)),
                  pw.Text(
                    row['value'],
                    style: pw.TextStyle(
                      fontSize: 16,
                      color: row['color'] == Colors.red ? PdfColors.red : PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
            ],
          )),

          pw.SizedBox(height: 30),

          // Chart Summary (text-based, full image চাইলে screenshot package যোগ করো)
          pw.Text("6-Month Cashflow Trend", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          pw.Text("Months: ${months.join(', ')}"),
          pw.Text("Income: ${incomeData.map((e) => '\$${e.toStringAsFixed(0)}').join(', ')}"),
          pw.Text("Expenses: ${expenseData.map((e) => '\$${e.toStringAsFixed(0)}').join(', ')}"),
        ],
      ),
    );

    // Save to device
    final dir = await getTemporaryDirectory(); // অথবা getApplicationDocumentsDirectory()
    final filePath = "${dir.path}/$title-${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF (user দেখতে পারবে)
    final result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to open PDF: ${result.message}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PDF saved & opened!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () => _exportToPdf(context),
        icon: const Icon(Icons.picture_as_pdf, color: Colors.blue),
        label: const Text("Export PDF"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.blue),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
    );
  }
}

Future<File> generatePdf(Uint8List imageBytes) async {
  final pdf = pw.Document();

  final image = pw.MemoryImage(imageBytes);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Center(
          child: pw.Image(image, fit: pw.BoxFit.contain),
        );
      },
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/page.pdf');

  await file.writeAsBytes(await pdf.save());
  return file;
}


