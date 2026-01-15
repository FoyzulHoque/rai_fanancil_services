import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/Get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



final GlobalKey pageKey = GlobalKey();

Future<void> printPdf(File file) async {
  await Printing.layoutPdf(
    onLayout: (format) async => file.readAsBytes(),
  );
}
// view short
Future<Uint8List?> captureFullPage() async {
  try {
    RenderRepaintBoundary boundary =
    pageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
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