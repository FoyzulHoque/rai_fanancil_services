import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  final RxList<Property> properties = <Property>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Start with one property by default
    if (properties.isEmpty) {
      addProperty();
    }
  }

  void addProperty() {
    properties.add(Property());
  }

  void removeProperty(int index) {
    if (properties.length > 1) {
      properties[index].dispose(); // Dispose controllers before removing
      properties.removeAt(index);
    }
  }

  // Method to load existing property data
  void loadPropertyData(List<Map<String, dynamic>> propertyDataList) {
    // Clear existing properties
    for (var prop in properties) {
      prop.dispose();
    }
    properties.clear();

    // Add properties from data
    if (propertyDataList.isNotEmpty) {
      for (var propertyData in propertyDataList) {
        final newProperty = Property();
        newProperty.addressController.text = propertyData['address'] ?? '';
        newProperty.purchasePriceController.text = propertyData['purchasePrice']?.toString() ?? '';
        newProperty.purchaseDateController.text = propertyData['purchaseDate'] ?? '';
        newProperty.estimatedValueController.text = propertyData['currentEstimateValue']?.toString() ?? '';
        newProperty.mortgageProviderController.text = propertyData['mortgageProvider'] ?? '';
        newProperty.mortgageAmountController.text = propertyData['currentMortgageAmount']?.toString() ?? '';
        newProperty.mortgageRateController.text = propertyData['currentMortgageRate']?.toString() ?? '';
        newProperty.interestRateController.text = propertyData['currentMortgageInterestRate']?.toString() ?? '';
        newProperty.finishedRateController.text = propertyData['mortgageFinishedRate']?.toString() ?? '';
        newProperty.loanTermController.text = propertyData['remainingTerm']?.toString() ?? '';
        newProperty.monthlyRentalController.text = propertyData['monthlyRentalPayment']?.toString() ?? '';
        newProperty.propertyType = propertyData['type'] ?? 'Own House';
        newProperty.mortgageType = propertyData['mortgageType'] ?? 'Variable';
        newProperty.isInterestOnly = propertyData['isInterestOnly'] ?? false;
        newProperty.totalMonthOfInterest = propertyData['totalMonthOfInterest'] ?? 360;
        newProperty.ioPeriodMonth = propertyData['ioPeriodMonth'] ?? 0;
        properties.add(newProperty);
      }
    } else {
      // Add default property if no data
      addProperty();
    }
  }

  @override
  void onClose() {
    for (var prop in properties) {
      prop.dispose();
    }
    super.onClose();
  }
}

class Property {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController estimatedValueController = TextEditingController();
  final TextEditingController mortgageProviderController = TextEditingController();
  final TextEditingController mortgageAmountController = TextEditingController();
  final TextEditingController mortgageRateController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController finishedRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  final TextEditingController monthlyRentalController = TextEditingController();
  String propertyType = "Own House";
  String mortgageType = "Variable";
  bool isInterestOnly = false;
  int totalMonthOfInterest = 360;
  int ioPeriodMonth = 0;

  void dispose() {
    addressController.dispose();
    purchasePriceController.dispose();
    purchaseDateController.dispose();
    estimatedValueController.dispose();
    mortgageProviderController.dispose();
    mortgageAmountController.dispose();
    mortgageRateController.dispose();
    interestRateController.dispose();
    finishedRateController.dispose();
    loanTermController.dispose();
    monthlyRentalController.dispose();
  }
}