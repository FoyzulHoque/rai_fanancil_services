import 'package:flutter/material.dart';

class LoanModel {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController monthlyPaymentController =
      TextEditingController();
  final TextEditingController monthsRemainingController =
      TextEditingController();

  void dispose() {
    bankNameController.dispose();
    balanceController.dispose();
    interestRateController.dispose();
    monthlyPaymentController.dispose();
    monthsRemainingController.dispose();
  }
}

class CreditCardModel {
  final TextEditingController bankController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController monthlyPaymentController =
      TextEditingController();

  void dispose() {
    bankController.dispose();
    limitController.dispose();
    balanceController.dispose();
    monthlyPaymentController.dispose();
  }
}

class BuyNowPayLaterModel {
  final TextEditingController bankController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController monthlyPaymentController =
      TextEditingController();
  final TextEditingController monthsRemainingController =
      TextEditingController();

  void dispose() {
    bankController.dispose();
    balanceController.dispose();
    interestRateController.dispose();
    monthlyPaymentController.dispose();
    monthsRemainingController.dispose();
  }
}

class SMSFModel {
  final TextEditingController bankController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController monthlyAmountController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();

  void dispose() {
    bankController.dispose();
    balanceController.dispose();
    rateController.dispose();
    monthlyAmountController.dispose();
    monthsController.dispose();
  }
}

// ==================== SAVING ACCOUNT FORM CLASS ====================
class SavingAccountForm {
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountNo = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController interestRate = TextEditingController();
  final TextEditingController cashSaving = TextEditingController();
  final TextEditingController investment = TextEditingController();
  final TextEditingController superannuation = TextEditingController();
  final TextEditingController otherAssets = TextEditingController();

  void dispose() {
    bankName.dispose();
    accountNo.dispose();
    accountType.dispose();
    interestRate.dispose();
    cashSaving.dispose();
    investment.dispose();
    superannuation.dispose();
    otherAssets.dispose();
  }
}


// ==================== PROPERTY CLASS ====================
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
