import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BorrowingAdultsController extends GetxController {
  final int minAdults;
  final int maxAdults;

  BorrowingAdultsController({
    this.minAdults = 1,
    this.maxAdults = 10,
  });

  final adultCount = 0.obs;
  final adultControllers = <Map<String, TextEditingController>>[].obs;

  @override
  void onInit() {
    super.onInit();
    addAdult(); // start with minAdults
  }

  void addAdult() {
    if (adultCount.value >= maxAdults) return;
    adultCount.value++;
    adultControllers.add(_createNewAdult());
  }

  void removeAdult() {
    if (adultCount.value <= minAdults) return;
    adultCount.value--;
    final removed = adultControllers.removeLast();
    removed.forEach((key, controller) => controller.dispose());
  }

  Map<String, TextEditingController> _createNewAdult() {
    return {
      'name': TextEditingController(),
      'dob': TextEditingController(),
      'email': TextEditingController(),
      'phone': TextEditingController(),
    };
  }

  @override
  void onClose() {
    for (var adult in adultControllers) {
      adult.forEach((_, controller) => controller.dispose());
    }
    super.onClose();
  }

  /// For submitting form data later
  List<Map<String, String>> get formData => adultControllers.map((c) {
    return {
      'name': c['name']!.text.trim(),
      'dob': c['dob']!.text.trim(),
      'email': c['email']!.text.trim(),
      'phone': c['phone']!.text.trim(),
    };
  }).toList();
}