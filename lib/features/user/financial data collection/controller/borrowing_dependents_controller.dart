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

  // Method to load existing dependent data
  void loadDependentData(List<Map<String, String>> dependentsData) {
    // Clear existing controllers
    for (var dependent in adultControllers) {
      dependent.forEach((_, controller) => controller.dispose());
    }
    adultControllers.clear();
    adultCount.value = 0;

    // Add dependents from data
    for (var dependentData in dependentsData) {
      final newDependent = _createNewAdult();
      newDependent['name']?.text = dependentData['name'] ?? '';
      newDependent['dob']?.text = dependentData['dob'] ?? '';
      adultControllers.add(newDependent);
      adultCount.value++;
    }
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