import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRangeController extends GetxController {
  final double minLimit;
  final double maxLimit;
  final Function(double min, double max)? onChanged;

  PriceRangeController({
    required this.minLimit,
    required this.maxLimit,
    required double initialMin,
    required double initialMax,
    this.onChanged,
  }) {
    minPrice.value = initialMin;
    maxPrice.value = initialMax;

    minCtrl.text = format(initialMin);
    maxCtrl.text = format(initialMax);
  }

  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;

  final minCtrl = TextEditingController();
  final maxCtrl = TextEditingController();

  String format(double value) {
    if (value >= 1000000) {
      return "\$${(value / 1000000).toStringAsFixed(1)}M";
    }
    return "\$${(value / 1000).toStringAsFixed(0)}k";
  }

  double parse(String text) {
    text = text.replaceAll("\$", "").toLowerCase();
    if (text.contains('m')) {
      return double.parse(text.replaceAll('m', '')) * 1000000;
    }
    if (text.contains('k')) {
      return double.parse(text.replaceAll('k', '')) * 1000;
    }
    return double.tryParse(text) ?? minLimit;
  }

  void _notify() {
    onChanged?.call(minPrice.value, maxPrice.value);
  }

  void onSlider(RangeValues values) {
    minPrice.value = values.start;
    maxPrice.value = values.end;

    minCtrl.text = format(values.start);
    maxCtrl.text = format(values.end);

    _notify();
  }

  void onInputDone() {
    double min = parse(minCtrl.text);
    double max = parse(maxCtrl.text);

    if (min < minLimit) min = minLimit;
    if (max > maxLimit) max = maxLimit;
    if (min > max) min = max;

    minPrice.value = min;
    maxPrice.value = max;

    minCtrl.text = format(min);
    maxCtrl.text = format(max);

    _notify();
  }

  @override
  void onClose() {
    minCtrl.dispose();
    maxCtrl.dispose();
    super.onClose();
  }
}
