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
  }
}
