import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BorrowingDependentsController extends GetxController {
  final int minAdults;
  final int maxAdults;

  BorrowingDependentsController({
    this.minAdults = 1,
    this.maxAdults = 10,
  });

  final adultCount = 0.obs;
  final adultControllers = <Map<String, TextEditingController>>[].obs;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < minAdults; i++) {
      addDependents();
    }
  }

  void addDependents() {
    if (adultCount.value >= maxAdults) return;
    adultCount.value++;
    adultControllers.add(_createNewAdult());
  }

  void removeDependents() {
    if (adultCount.value <= minAdults) return;
    adultCount.value--;
    final removed = adultControllers.removeLast();
    removed.forEach((key, controller) => controller.dispose());
  }

  Map<String, TextEditingController> _createNewAdult() {
    return {
      'name': TextEditingController(),
      'dob': TextEditingController(),
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
    };
  }).toList();
}