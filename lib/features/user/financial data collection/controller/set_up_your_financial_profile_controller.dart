import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../../user navbar/user_navbar_screen.dart';
import '../model/financial_profile_model.dart';
import 'financial_profile_controller.dart';

// ==================== LIABILITY MODELS ====================
class LoanModel {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController monthlyPaymentController = TextEditingController();
  final TextEditingController monthsRemainingController = TextEditingController();

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
  final TextEditingController monthlyPaymentController = TextEditingController();

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
  final TextEditingController monthlyPaymentController = TextEditingController();
  final TextEditingController monthsRemainingController = TextEditingController();

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

// ==================== MAIN CONTROLLER ====================
class SetUpYourFinancialProfileController extends GetxController {
  // Reference to the FinancialProfileController
  final FinancialProfileController financialProfileController = Get.find<FinancialProfileController>();

  // ==================== FAMILY VARIABLES ====================
  RxInt adultCount = 0.obs;
  RxInt dependentCount = 0.obs;
  RxList<Map<String, TextEditingController>> adultControllers = <Map<String, TextEditingController>>[].obs;
  RxList<Map<String, TextEditingController>> dependentControllers = <Map<String, TextEditingController>>[].obs;
  RxList<Map<String, dynamic>> adultIncomes = <Map<String, dynamic>>[].obs;
  RxInt selectedAdultIndex = 0.obs;

  // ==================== EXPENSES VARIABLES ====================
  RxString selectedLivingSituation = "Own House".obs;
  RxDouble foodAmount = 0.0.obs;
  RxString foodFrequency = "Annually".obs;
  RxString foodExpenseDate = RxString(DateTime.now().toIso8601String().split('T')[0]);
  RxDouble transportAmount = 0.0.obs;
  RxString transportFrequency = "Annually".obs;
  RxString transportExpenseDate = RxString(DateTime.now().toIso8601String().split('T')[0]);
  RxDouble utilitiesAmount = 0.0.obs;
  RxString utilitiesFrequency = "Annually".obs;
  RxString utilitiesExpenseDate = RxString(DateTime.now().toIso8601String().split('T')[0]);
  RxDouble insuranceAmount = 0.0.obs;
  RxString insuranceFrequency = "Annually".obs;
  RxString insuranceExpenseDate = RxString(DateTime.now().toIso8601String().split('T')[0]);
  RxDouble entertainmentAmount = 0.0.obs;
  RxString entertainmentFrequency = "Annually".obs;
  RxString entertainmentExpenseDate = RxString(DateTime.now().toIso8601String().split('T')[0]);
  RxDouble monthlyRentalPayment = 0.0.obs;

  // ==================== PROPERTY VARIABLES ====================
  RxList<Property> properties = <Property>[].obs;

  // ==================== ASSETS VARIABLES ====================
  RxList<SavingAccountForm> savingAccounts = <SavingAccountForm>[].obs;
  RxDouble totalAssets = 0.0.obs;

  // ==================== LIABILITIES VARIABLES ====================
  RxList<LoanModel> loans = <LoanModel>[].obs;
  RxList<CreditCardModel> creditCards = <CreditCardModel>[].obs;
  RxList<BuyNowPayLaterModel> buyNowPayLaters = <BuyNowPayLaterModel>[].obs;
  RxList<SMSFModel> smsfs = <SMSFModel>[].obs;
  RxDouble hecsDebt = 0.0.obs;
  final TextEditingController hecsDebtController = TextEditingController();

  // ==================== TEXT EDITING CONTROLLERS ====================
  var nameController = TextEditingController();
  var dobController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var expenseAmountController = TextEditingController();
  var expenseDateController = TextEditingController();
  var propertyTypeController = TextEditingController();
  var propertyAddressController = TextEditingController();
  var purchasePriceController = TextEditingController();
  var currentEstimateValueController = TextEditingController();
  var mortgageProviderController = TextEditingController();
  var currentMortgageAmountController = TextEditingController();
  var totalAssetsController = TextEditingController();
  var bankNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var accountTypeController = TextEditingController();
  var cashSavingController = TextEditingController();
  var investmentController = TextEditingController();
  var superannuationController = TextEditingController();
  var otherAssetsController = TextEditingController();

  // ==================== DATA LISTS ====================
  RxList<Map<String, dynamic>> expenses = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> assets = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> liabilities = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> propertyDetails = <Map<String, dynamic>>[].obs;
  RxBool isUploading = false.obs;

  // ==================== IMAGE PICKER ====================
  final ImagePicker _picker = ImagePicker();

  // ==================== CONFIGURATION ====================
  final int minAdults = 1;
  final int maxAdults = 8;
  final int minDependents = 0;
  final int maxDependents = 8;

  // Flag to track if data has been loaded
  bool _dataLoaded = false;

  // ==================== INITIALIZATION ====================
  @override
  void onInit() {
    super.onInit();
    // Initialize with minimum adults
    for (int i = 0; i < minAdults; i++) {
      addAdult();
    }
    // Start with one property by default
    if (properties.isEmpty) {
      addProperty();
    }
    // Start with one saving account by default
    if (savingAccounts.isEmpty) {
      addSavingAccount();
    }
    // Start with one of each liability by default
    if (loans.isEmpty) {
      addLoan();
    }
    if (creditCards.isEmpty) {
      addCreditCard();
    }
    if (buyNowPayLaters.isEmpty) {
      addBuyNowPayLater();
    }
    if (smsfs.isEmpty) {
      addSMSF();
    }

    // Load existing financial profile data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFinancialProfileData();
    });
  }

  // ==================== LOAD FINANCIAL PROFILE DATA ====================
  void loadFinancialProfileData() {
    if (_dataLoaded) return;

    final profileData = financialProfileController.profileData.value;
    if (profileData == null) return;

    try {
      // Set counts
      adultCount.value = profileData.howManyBorrowingAdults;
      dependentCount.value = profileData.howManyDependents;

      // Clear and recreate adult controllers based on API data
      for (var adult in adultControllers) {
        adult.forEach((_, controller) => controller.dispose());
      }
      adultControllers.clear();
      adultIncomes.clear();

      // Load adults
      if (profileData.adults.isNotEmpty) {
        for (var adult in profileData.adults) {
          final adultControllersMap = _createNewAdult();
          adultControllersMap['name']?.text = adult.name;
          adultControllersMap['dob']?.text = adult.dob;
          adultControllersMap['email']?.text = adult.email;
          adultControllersMap['phone']?.text = adult.phone;
          adultControllers.add(adultControllersMap);

          // Load income data
          if (adult.incomes.isNotEmpty) {
            final income = adult.incomes.first;
            adultIncomes.add({
              "primaryIncomeType": income.primaryIncomeType,
              "primaryIncomeAmount": income.primaryIncomeAmount.toDouble(),
              "incomeFrequency": income.incomeFrequency,
              "otherIncome": income.otherIncome.toDouble(),
              "taxRegion": income.taxRegion,
            });
          } else {
            adultIncomes.add({
              "primaryIncomeType": "Salary/Wages",
              "primaryIncomeAmount": 0.0,
              "incomeFrequency": "Annually",
              "otherIncome": 0.0,
              "taxRegion": "",
            });
          }
        }
      }

      // Load dependents
      for (var dependent in dependentControllers) {
        dependent.forEach((_, controller) => controller.dispose());
      }
      dependentControllers.clear();

      if (profileData.dependents.isNotEmpty) {
        for (var dependent in profileData.dependents) {
          final dependentControllersMap = _createNewDependent();
          // Since Dependent uses raw map, we need to extract data
          final rawData = dependent.raw;
          dependentControllersMap['name']?.text = rawData['name'] ?? '';
          dependentControllersMap['dob']?.text = rawData['dob'] ?? '';
          dependentControllers.add(dependentControllersMap);
        }
      }

      // Load expenses
      if (profileData.expenses.isNotEmpty) {
        final expense = profileData.expenses.first;
        selectedLivingSituation.value = expense.livingSituation;
        monthlyRentalPayment.value = expense.monthlyRentalPayment.toDouble();

        if (expense.food != null) {
          foodAmount.value = expense.food!.amount.toDouble();
          foodFrequency.value = expense.food!.frequency;
          foodExpenseDate.value = expense.food!.expenseDate;
        }
        if (expense.transport != null) {
          transportAmount.value = expense.transport!.amount.toDouble();
          transportFrequency.value = expense.transport!.frequency;
          transportExpenseDate.value = expense.transport!.expenseDate;
        }
        if (expense.utilities != null) {
          utilitiesAmount.value = expense.utilities!.amount.toDouble();
          utilitiesFrequency.value = expense.utilities!.frequency;
          utilitiesExpenseDate.value = expense.utilities!.expenseDate;
        }
        if (expense.insurance != null) {
          insuranceAmount.value = expense.insurance!.amount.toDouble();
          insuranceFrequency.value = expense.insurance!.frequency;
          insuranceExpenseDate.value = expense.insurance!.expenseDate;
        }
        if (expense.entertainment != null) {
          entertainmentAmount.value = expense.entertainment!.amount.toDouble();
          entertainmentFrequency.value = expense.entertainment!.frequency;
          entertainmentExpenseDate.value = expense.entertainment!.expenseDate;
        }
        _updateExpensesList();
      }

      // Load properties
      for (var property in properties) {
        property.dispose();
      }
      properties.clear();

      if (profileData.propertyDetails.isNotEmpty) {
        for (var property in profileData.propertyDetails) {
          final newProperty = Property();
          newProperty.propertyType = property.type;
          newProperty.addressController.text = property.address;
          newProperty.purchasePriceController.text = property.purchasePrice.toString();
          newProperty.purchaseDateController.text = property.purchaseDate;
          newProperty.estimatedValueController.text = property.currentEstimateValue.toString();
          newProperty.mortgageProviderController.text = property.mortgageProvider;
          newProperty.mortgageAmountController.text = property.currentMortgageAmount.toString();
          newProperty.mortgageRateController.text = property.currentMortgageRate.toString();
          newProperty.interestRateController.text = property.currentMortgageInterestRate.toString();
          newProperty.finishedRateController.text = property.mortgageFinishedRate.toString();
          newProperty.mortgageType = property.mortgageType;
          newProperty.isInterestOnly = property.isInterestOnly;
          newProperty.totalMonthOfInterest = property.totalMonthOfInterest;
          newProperty.ioPeriodMonth = property.ioPeriodMonth;
          newProperty.loanTermController.text = property.remainingTerm.toString();
          newProperty.monthlyRentalController.text = property.monthlyRentalPayment.toString();
          properties.add(newProperty);
        }
      }

      // Load assets
      totalAssets.value = profileData.totalAssets.toDouble();

      for (var account in savingAccounts) {
        account.dispose();
      }
      savingAccounts.clear();

      if (profileData.assets.isNotEmpty) {
        for (var asset in profileData.assets) {
          final newAccount = SavingAccountForm();
          newAccount.bankName.text = asset.bankName;
          newAccount.accountNo.text = asset.accountNumber;
          newAccount.accountType.text = asset.accountType;
          newAccount.interestRate.text = asset.interestRate.toString();
          newAccount.cashSaving.text = asset.cashSaving.toString();
          newAccount.investment.text = asset.investment.toString();
          newAccount.superannuation.text = asset.superannuation.toString();
          newAccount.otherAssets.text = asset.otherAssets.toString();
          savingAccounts.add(newAccount);
        }
      }
      updateAssetsList();

      // Load liabilities
      for (var loan in loans) {
        loan.dispose();
      }
      loans.clear();

      for (var card in creditCards) {
        card.dispose();
      }
      creditCards.clear();

      for (var bnpl in buyNowPayLaters) {
        bnpl.dispose();
      }
      buyNowPayLaters.clear();

      for (var smsf in smsfs) {
        smsf.dispose();
      }
      smsfs.clear();

      if (profileData.liabilities.isNotEmpty) {
        final liability = profileData.liabilities.first;
        hecsDebt.value = liability.hecsDebt.toDouble();
        hecsDebtController.text = liability.hecsDebt.toString();

        // Load loans
        for (var loan in liability.loans) {
          final newLoan = LoanModel();
          newLoan.bankNameController.text = loan.bankName;
          newLoan.balanceController.text = loan.currentBalance.toString();
          newLoan.interestRateController.text = loan.interestRate.toString();
          newLoan.monthlyPaymentController.text = loan.monthlyPayment.toString();
          newLoan.monthsRemainingController.text = loan.remainingMonths.toString();
          loans.add(newLoan);
        }

        // Load credit cards
        for (var card in liability.creditCards) {
          final newCard = CreditCardModel();
          newCard.bankController.text = card.bankName;
          newCard.limitController.text = card.creditLimit.toString();
          newCard.balanceController.text = card.currentBalance.toString();
          newCard.monthlyPaymentController.text = card.monthlyPayment;
          creditCards.add(newCard);
        }

        // Load buy now pay later
        for (var bnpl in liability.buyNowPayLaters) {
          final newBnpl = BuyNowPayLaterModel();
          newBnpl.bankController.text = bnpl.bankName;
          newBnpl.balanceController.text = bnpl.currentBalance.toString();
          newBnpl.interestRateController.text = bnpl.interestRate.toString();
          newBnpl.monthlyPaymentController.text = bnpl.monthlyPayment.toString();
          newBnpl.monthsRemainingController.text = bnpl.remainingMonths.toString();
          buyNowPayLaters.add(newBnpl);
        }

        // Load SMSFs
        for (var smsf in liability.smsfs) {
          final newSmsf = SMSFModel();
          newSmsf.bankController.text = smsf.bankName;
          newSmsf.balanceController.text = smsf.loanBalance.toString();
          newSmsf.rateController.text = smsf.rate.toString();
          newSmsf.monthlyAmountController.text = smsf.monthlyAmount.toString();
          newSmsf.monthsController.text = smsf.remainingMonths.toString();
          smsfs.add(newSmsf);
        }
      }

      _dataLoaded = true;
      update();

    } catch (e) {
      print("Error loading financial profile data: $e");
    }
  }

  // ==================== SAVING ACCOUNTS METHODS ====================
  void addSavingAccount() {
    savingAccounts.add(SavingAccountForm());
    updateAssetsList();
    update();
  }

  void removeSavingAccount(int index) {
    if (savingAccounts.length > 1 && index < savingAccounts.length) {
      savingAccounts[index].dispose();
      savingAccounts.removeAt(index);
      updateAssetsList();
      update();
    }
  }

  void onSavingAccountFieldChanged() {
    updateAssetsList();
  }

  void updateAssetsList() {
    assets.clear();

    for (var account in savingAccounts) {
      assets.add({
        "bankName": account.bankName.text.trim(),
        "accountNumber": account.accountNo.text.trim(),
        "accountType": account.accountType.text.trim(),
        "interestRate": double.tryParse(account.interestRate.text) ?? 0.0,
        "cashSaving": double.tryParse(account.cashSaving.text) ?? 0.0,
        "investment": double.tryParse(account.investment.text) ?? 0.0,
        "superannuation": double.tryParse(account.superannuation.text) ?? 0.0,
        "otherAssets": double.tryParse(account.otherAssets.text) ?? 0.0,
      });
    }

    calculateTotalAssets();
  }

  void calculateTotalAssets() {
    double total = 0.0;

    for (var account in savingAccounts) {
      total += double.tryParse(account.cashSaving.text) ?? 0.0;
      total += double.tryParse(account.investment.text) ?? 0.0;
      total += double.tryParse(account.superannuation.text) ?? 0.0;
      total += double.tryParse(account.otherAssets.text) ?? 0.0;
    }

    totalAssets.value = total;
  }

  // ==================== LIABILITIES METHODS ====================
  // Loans
  void addLoan() {
    loans.add(LoanModel());
    updateLiabilitiesList();
    update();
  }

  void removeLoan(int index) {
    if (loans.length > 1 && index < loans.length) {
      loans[index].dispose();
      loans.removeAt(index);
      updateLiabilitiesList();
      update();
    }
  }

  // Credit Cards
  void addCreditCard() {
    creditCards.add(CreditCardModel());
    updateLiabilitiesList();
    update();
  }

  void removeCreditCard(int index) {
    if (creditCards.length > 1 && index < creditCards.length) {
      creditCards[index].dispose();
      creditCards.removeAt(index);
      updateLiabilitiesList();
      update();
    }
  }

  // Buy Now Pay Later
  void addBuyNowPayLater() {
    buyNowPayLaters.add(BuyNowPayLaterModel());
    updateLiabilitiesList();
    update();
  }

  void removeBuyNowPayLater(int index) {
    if (buyNowPayLaters.length > 1 && index < buyNowPayLaters.length) {
      buyNowPayLaters[index].dispose();
      buyNowPayLaters.removeAt(index);
      updateLiabilitiesList();
      update();
    }
  }

  // SMSF
  void addSMSF() {
    smsfs.add(SMSFModel());
    updateLiabilitiesList();
    update();
  }

  void removeSMSF(int index) {
    if (smsfs.length > 1 && index < smsfs.length) {
      smsfs[index].dispose();
      smsfs.removeAt(index);
      updateLiabilitiesList();
      update();
    }
  }

  // HECS Debt
  void onHecsDebtChanged(String value) {
    hecsDebt.value = double.tryParse(value) ?? 0.0;
    updateLiabilitiesList();
  }

  // Update all liabilities
  void onLiabilityFieldChanged() {
    updateLiabilitiesList();
  }

  void updateLiabilitiesList() {
    // Update HECS debt from controller
    hecsDebt.value = double.tryParse(hecsDebtController.text) ?? 0.0;

    liabilities.clear();

    if (loans.isNotEmpty || creditCards.isNotEmpty ||
        buyNowPayLaters.isNotEmpty || smsfs.isNotEmpty ||
        hecsDebt.value > 0) {

      // Map loans
      List<Map<String, dynamic>> loanList = loans.map((loan) => ({
        "bankName": loan.bankNameController.text.trim(),
        "currentBalance": double.tryParse(loan.balanceController.text) ?? 0.0,
        "interestRate": double.tryParse(loan.interestRateController.text) ?? 0.0,
        "monthlyPayment": double.tryParse(loan.monthlyPaymentController.text) ?? 0.0,
        "remainingMonths": int.tryParse(loan.monthsRemainingController.text) ?? 0,
      })).toList();

      // Map credit cards
      List<Map<String, dynamic>> creditCardList = creditCards.map((card) => ({
        "bankName": card.bankController.text.trim(),
        "creditLimit": double.tryParse(card.limitController.text) ?? 0.0,
        "currentBalance": double.tryParse(card.balanceController.text) ?? 0.0,
        "monthlyPayment": card.monthlyPaymentController.text.trim().isNotEmpty ?
        card.monthlyPaymentController.text.trim() : "5%",
      })).toList();

      // Map buy now pay later
      List<Map<String, dynamic>> buyNowPayLaterList = buyNowPayLaters.map((bnpl) => ({
        "bankName": bnpl.bankController.text.trim(),
        "currentBalance": double.tryParse(bnpl.balanceController.text) ?? 0.0,
        "interestRate": double.tryParse(bnpl.interestRateController.text) ?? 0.0,
        "monthlyPayment": double.tryParse(bnpl.monthlyPaymentController.text) ?? 0.0,
        "remainingMonths": int.tryParse(bnpl.monthsRemainingController.text) ?? 0,
      })).toList();

      // Map SMSF
      List<Map<String, dynamic>> smsfList = smsfs.map((smsf) => ({
        "bankName": smsf.bankController.text.trim(),
        "loanBalance": double.tryParse(smsf.balanceController.text) ?? 0.0,
        "rate": double.tryParse(smsf.rateController.text) ?? 0.0,
        "monthlyAmount": double.tryParse(smsf.monthlyAmountController.text) ?? 0.0,
        "remainingMonths": int.tryParse(smsf.monthsController.text) ?? 0,
      })).toList();

      // Create liabilities object matching API structure
      liabilities.add({
        "hecsDebt": hecsDebt.value,
        "loans": loanList,
        "creditCards": creditCardList,
        "buyNowPayLaters": buyNowPayLaterList,
        "smsfs": smsfList,
      });
    }
  }

  // ==================== PROPERTY METHODS ====================
  void addProperty() {
    properties.add(Property());
    updatePropertyDetails();
  }

  void removeProperty(int index) {
    if (properties.length > 1) {
      properties[index].dispose();
      properties.removeAt(index);
      updatePropertyDetails();
    }
  }

  void updateProperty(int index, {String? propertyType, String? mortgageType, bool? isInterestOnly}) {
    if (index < properties.length) {
      if (propertyType != null) properties[index].propertyType = propertyType;
      if (mortgageType != null) properties[index].mortgageType = mortgageType;
      if (isInterestOnly != null) properties[index].isInterestOnly = isInterestOnly;
      updatePropertyDetails();
    }
  }

  void updatePropertyDetails() {
    propertyDetails.clear();

    for (int i = 0; i < properties.length; i++) {
      final property = properties[i];
      propertyDetails.add({
        "type": property.propertyType,
        "address": property.addressController.text,
        "purchasePrice": double.tryParse(property.purchasePriceController.text) ?? 0.0,
        "purchaseDate": property.purchaseDateController.text.isNotEmpty
            ? property.purchaseDateController.text
            : "2019-06-20",
        "currentEstimateValue": double.tryParse(property.estimatedValueController.text) ?? 0.0,
        "mortgageProvider": property.mortgageProviderController.text,
        "currentMortgageAmount": double.tryParse(property.mortgageAmountController.text) ?? 0.0,
        "currentMortgageRate": double.tryParse(property.mortgageRateController.text) ?? 4.2,
        "currentMortgageInterestRate": double.tryParse(property.interestRateController.text) ?? 4.2,
        "mortgageFinishedRate": double.tryParse(property.finishedRateController.text) ?? 0.0,
        "mortgageLimit": 0.0,
        "mortgageType": property.mortgageType,
        "isInterestOnly": property.isInterestOnly,
        "totalMonthOfInterest": property.totalMonthOfInterest,
        "ioPeriodMonth": property.ioPeriodMonth,
        "remainingTerm": int.tryParse(property.loanTermController.text) ?? 310,
        "monthlyRentalPayment": double.tryParse(property.monthlyRentalController.text) ?? 0.0,
      });
    }
  }

  // ==================== EXPENSES METHODS ====================
  void saveExpenses({
    required String livingSituation,
    required double foodAmount,
    required String foodFrequency,
    required String foodExpenseDate,
    required double transportAmount,
    required String transportFrequency,
    required String transportExpenseDate,
    required double utilitiesAmount,
    required String utilitiesFrequency,
    required String utilitiesExpenseDate,
    required double insuranceAmount,
    required String insuranceFrequency,
    required String insuranceExpenseDate,
    required double entertainmentAmount,
    required String entertainmentFrequency,
    required String entertainmentExpenseDate,
    required double monthlyRentalPayment,
  }) {
    selectedLivingSituation.value = livingSituation;
    this.foodAmount.value = foodAmount;
    this.foodFrequency.value = foodFrequency;
    this.foodExpenseDate.value = foodExpenseDate.isNotEmpty ? foodExpenseDate : DateTime.now().toIso8601String().split('T')[0];
    this.transportAmount.value = transportAmount;
    this.transportFrequency.value = transportFrequency;
    this.transportExpenseDate.value = transportExpenseDate.isNotEmpty ? transportExpenseDate : DateTime.now().toIso8601String().split('T')[0];
    this.utilitiesAmount.value = utilitiesAmount;
    this.utilitiesFrequency.value = utilitiesFrequency;
    this.utilitiesExpenseDate.value = utilitiesExpenseDate.isNotEmpty ? utilitiesExpenseDate : DateTime.now().toIso8601String().split('T')[0];
    this.insuranceAmount.value = insuranceAmount;
    this.insuranceFrequency.value = insuranceFrequency;
    this.insuranceExpenseDate.value = insuranceExpenseDate.isNotEmpty ? insuranceExpenseDate : DateTime.now().toIso8601String().split('T')[0];
    this.entertainmentAmount.value = entertainmentAmount;
    this.entertainmentFrequency.value = entertainmentFrequency;
    this.entertainmentExpenseDate.value = entertainmentExpenseDate.isNotEmpty ? entertainmentExpenseDate : DateTime.now().toIso8601String().split('T')[0];
    this.monthlyRentalPayment.value = monthlyRentalPayment;

    _updateExpensesList();
    update();
  }

  void _updateExpensesList() {
    expenses.clear();

    expenses.add({
      "livingSituation": selectedLivingSituation.value,
      "food": {
        "amount": foodAmount.value,
        "frequency": foodFrequency.value,
        "expenseDate": foodExpenseDate.value,
      },
      "transport": {
        "amount": transportAmount.value,
        "frequency": transportFrequency.value,
        "expenseDate": transportExpenseDate.value,
      },
      "utilities": {
        "amount": utilitiesAmount.value,
        "frequency": utilitiesFrequency.value,
        "expenseDate": utilitiesExpenseDate.value,
      },
      "insurance": {
        "amount": insuranceAmount.value,
        "frequency": insuranceFrequency.value,
        "expenseDate": insuranceExpenseDate.value,
      },
      "entertainment": {
        "amount": entertainmentAmount.value,
        "frequency": entertainmentFrequency.value,
        "expenseDate": entertainmentExpenseDate.value,
      },
      "monthlyRentalPayment": monthlyRentalPayment.value,
    });
  }

  // ==================== ADULT METHODS ====================
  void addAdult() {
    if (adultCount.value >= maxAdults) return;
    adultCount.value++;
    adultControllers.add(_createNewAdult());

    adultIncomes.add({
      "primaryIncomeType": "Salary/Wages",
      "primaryIncomeAmount": 0.0,
      "incomeFrequency": "Annually",
      "otherIncome": 0.0,
      "taxRegion": "",
    });

    update();
  }

  void removeAdult() {
    if (adultCount.value <= minAdults) return;
    adultCount.value--;
    final removed = adultControllers.removeLast();
    removed.forEach((key, controller) => controller.dispose());

    if (adultIncomes.isNotEmpty) {
      adultIncomes.removeLast();
    }

    if (selectedAdultIndex.value >= adultControllers.length) {
      selectedAdultIndex.value = adultControllers.length - 1;
    }

    update();
  }

  Map<String, TextEditingController> _createNewAdult() {
    return {
      'name': TextEditingController(),
      'dob': TextEditingController(),
      'email': TextEditingController(),
      'phone': TextEditingController(),
    };
  }

  void selectAdult(int index) {
    if (index >= 0 && index < adultControllers.length) {
      selectedAdultIndex.value = index;
    }
  }

  String get currentAdultName {
    int index = selectedAdultIndex.value;
    if (index < adultControllers.length) {
      String name = adultControllers[index]['name']!.text.trim();
      return name.isNotEmpty ? name : "Adult ${index + 1}";
    }
    return "Adult";
  }

  void saveIncomeForCurrentAdult({
    required String primaryIncomeType,
    required double primaryIncomeAmount,
    required String incomeFrequency,
    required double otherIncome,
    required String taxRegion,
  }) {
    int index = selectedAdultIndex.value;

    if (index < adultIncomes.length) {
      adultIncomes[index] = {
        "primaryIncomeType": primaryIncomeType,
        "primaryIncomeAmount": primaryIncomeAmount,
        "incomeFrequency": incomeFrequency,
        "otherIncome": otherIncome,
        "taxRegion": taxRegion,
      };
    }
  }

  Map<String, dynamic> getCurrentAdultIncomeData() {
    int index = selectedAdultIndex.value;
    if (index < adultIncomes.length) {
      return adultIncomes[index];
    }
    return {
      "primaryIncomeType": "Salary/Wages",
      "primaryIncomeAmount": 0.0,
      "incomeFrequency": "Annually",
      "otherIncome": 0.0,
      "taxRegion": "",
    };
  }

  // ==================== DEPENDENT METHODS ====================
  void addDependent() {
    if (dependentCount.value >= maxDependents) return;
    dependentCount.value++;
    dependentControllers.add(_createNewDependent());
    update();
  }

  void removeDependent() {
    if (dependentCount.value <= minDependents) return;
    dependentCount.value--;
    final removed = dependentControllers.removeLast();
    removed.forEach((key, controller) => controller.dispose());
    update();
  }

  Map<String, TextEditingController> _createNewDependent() {
    return {
      'name': TextEditingController(),
      'dob': TextEditingController(),
    };
  }

  // ==================== DATA FORMATTING METHODS ====================
  List<Map<String, dynamic>> get adultsFormData {
    List<Map<String, dynamic>> result = [];

    for (int i = 0; i < adultControllers.length; i++) {
      var adult = adultControllers[i];
      var incomeData = i < adultIncomes.length ? adultIncomes[i] : {
        "primaryIncomeType": "Salary/Wages",
        "primaryIncomeAmount": 0.0,
        "incomeFrequency": "Annually",
        "otherIncome": 0.0,
        "taxRegion": "",
      };

      result.add({
        "name": adult['name']!.text.trim(),
        "dob": adult['dob']!.text.trim(),
        "email": adult['email']!.text.trim(),
        "phone": adult['phone']!.text.trim(),
        "incomes": [incomeData]
      });
    }
    return result;
  }

  List<Map<String, dynamic>> get dependentsFormData => dependentControllers.map((c) {
    return {
      'name': c['name']!.text.trim(),
      'dob': c['dob']!.text.trim(),
    };
  }).toList();

  // ==================== IMAGE PICKER ====================
  Future<void> pickDocumentImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle the picked image
    }
  }

  // ==================== VALIDATION METHODS ====================
  bool validateAdultsData() {
    for (var adult in adultControllers) {
      if (adult['name']!.text.trim().isEmpty ||
          adult['dob']!.text.trim().isEmpty ||
          adult['email']!.text.trim().isEmpty ||
          adult['phone']!.text.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool validateDependentsData() {
    for (var dependent in dependentControllers) {
      if (dependent['name']!.text.trim().isEmpty ||
          dependent['dob']!.text.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  // ==================== RESET FORM ====================
  void resetForm() {
    adultCount.value = minAdults;
    dependentCount.value = minDependents;
    selectedAdultIndex.value = 0;

    // Clear and reinitialize adult controllers
    for (var adult in adultControllers) {
      adult.forEach((_, controller) => controller.dispose());
    }
    adultControllers.clear();
    adultIncomes.clear();

    for (int i = 0; i < minAdults; i++) {
      addAdult();
    }

    // Clear dependent controllers
    for (var dependent in dependentControllers) {
      dependent.forEach((_, controller) => controller.dispose());
    }
    dependentControllers.clear();

    // Reset expenses
    selectedLivingSituation.value = "Own House";
    foodAmount.value = 0.0;
    foodFrequency.value = "Annually";
    foodExpenseDate.value = DateTime.now().toIso8601String().split('T')[0];
    transportAmount.value = 0.0;
    transportFrequency.value = "Annually";
    transportExpenseDate.value = DateTime.now().toIso8601String().split('T')[0];
    utilitiesAmount.value = 0.0;
    utilitiesFrequency.value = "Annually";
    utilitiesExpenseDate.value = DateTime.now().toIso8601String().split('T')[0];
    insuranceAmount.value = 0.0;
    insuranceFrequency.value = "Annually";
    insuranceExpenseDate.value = DateTime.now().toIso8601String().split('T')[0];
    entertainmentAmount.value = 0.0;
    entertainmentFrequency.value = "Annually";
    entertainmentExpenseDate.value = DateTime.now().toIso8601String().split('T')[0];
    monthlyRentalPayment.value = 0.0;

    // Reset properties
    for (var property in properties) {
      property.dispose();
    }
    properties.clear();
    addProperty();

    // Reset saving accounts
    for (var account in savingAccounts) {
      account.dispose();
    }
    savingAccounts.clear();
    addSavingAccount();
    totalAssets.value = 0.0;

    // Reset liabilities
    for (var loan in loans) {
      loan.dispose();
    }
    loans.clear();
    addLoan();

    for (var card in creditCards) {
      card.dispose();
    }
    creditCards.clear();
    addCreditCard();

    for (var bnpl in buyNowPayLaters) {
      bnpl.dispose();
    }
    buyNowPayLaters.clear();
    addBuyNowPayLater();

    for (var smsf in smsfs) {
      smsf.dispose();
    }
    smsfs.clear();
    addSMSF();

    hecsDebt.value = 0.0;
    hecsDebtController.clear();

    // Clear all data lists
    expenses.clear();
    assets.clear();
    liabilities.clear();
    propertyDetails.clear();

    _dataLoaded = false;
    update();
  }

  // ==================== API SUBMISSION ====================
  Future<void> submitFinancialProfile() async {
    // Validate data
    if (!validateAdultsData()) {
      Get.snackbar("Error", "Please fill all adult details",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!validateDependentsData()) {
      Get.snackbar("Error", "Please fill all dependent details",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Update all data before submission
    updatePropertyDetails();
    updateAssetsList();
    updateLiabilitiesList();

    // Prepare the data for API call
    final financialProfileData = {
      "howManyBorrowingAdults": adultCount.value,
      "howManyDependents": dependentCount.value,
      "adults": adultsFormData,
      "dependents": dependentsFormData,
      "expenses": expenses.map((expense) => ({
        "livingSituation": expense["livingSituation"],
        "food": expense["food"],
        "transport": expense["transport"],
        "utilities": expense["utilities"],
        "insurance": expense["insurance"],
        "entertainment": expense["entertainment"],
        "monthlyRentalPayment": expense["monthlyRentalPayment"],
      })).toList(),
      "propertyDetails": propertyDetails.map((property) => ({
        "type": property["type"],
        "address": property["address"],
        "purchasePrice": property["purchasePrice"],
        "purchaseDate": property["purchaseDate"],
        "currentEstimateValue": property["currentEstimateValue"],
        "mortgageProvider": property["mortgageProvider"],
        "currentMortgageAmount": property["currentMortgageAmount"],
        "currentMortgageRate": property["currentMortgageRate"],
        "currentMortgageInterestRate": property["currentMortgageInterestRate"],
        "mortgageFinishedRate": property["mortgageFinishedRate"],
        "mortgageLimit": property["mortgageLimit"],
        "mortgageType": property["mortgageType"],
        "isInterestOnly": property["isInterestOnly"],
        "totalMonthOfInterest": property["totalMonthOfInterest"],
        "ioPeriodMonth": property["ioPeriodMonth"],
        "remainingTerm": property["remainingTerm"],
        "monthlyRentalPayment": property["monthlyRentalPayment"],
      })).toList(),
      "totalAssets": totalAssets.value,
      "assets": assets.map((asset) => ({
        "bankName": asset["bankName"],
        "accountNumber": asset["accountNumber"],
        "accountType": asset["accountType"],
        "interestRate": asset["interestRate"],
        "cashSaving": asset["cashSaving"],
        "investment": asset["investment"],
        "superannuation": asset["superannuation"],
        "otherAssets": asset["otherAssets"],
      })).toList(),
      "liabilities": liabilities.isNotEmpty ? liabilities.map((liability) => ({
        "hecsDebt": liability["hecsDebt"] ?? 0.0,
        "loans": liability["loans"] is List ? liability["loans"] : [],
        "creditCards": liability["creditCards"] is List ? liability["creditCards"] : [],
        "buyNowPayLaters": liability["buyNowPayLaters"] is List ? liability["buyNowPayLaters"] : [],
        "smsfs": liability["smsfs"] is List ? liability["smsfs"] : [],
      })).toList() : [{
        "hecsDebt": hecsDebt.value,
        "loans": [],
        "creditCards": [],
        "buyNowPayLaters": [],
        "smsfs": [],
      }],
    };

    print("Submitting data: ${jsonEncode(financialProfileData)}");

    // Get the authorization token
    final token = await SharedPreferencesHelper.getAccessToken();
    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "Authorization token is missing!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isUploading.value = true;

    try {
      final url = Uri.parse("${Urls.baseUrl}/financial-profile/create");

      final response = await http.post(
        url,
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(financialProfileData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          Get.offAll(()=>UserBottomNavbar());
          Get.snackbar("Success", "Financial profile saved successfully!",
              backgroundColor: Colors.green, colorText: Colors.white);
          resetForm();
        } else {
          Get.snackbar("Error", responseData['message'] ?? "Failed to save data.",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Failed to save data. Status code: ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save data: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isUploading.value = false;
    }
  }

  // ==================== CLEANUP ====================
  @override
  void onClose() {
    // Dispose adult controllers
    for (var adult in adultControllers) {
      adult.forEach((_, controller) => controller.dispose());
    }

    // Dispose dependent controllers
    for (var dependent in dependentControllers) {
      dependent.forEach((_, controller) => controller.dispose());
    }

    // Dispose property controllers
    for (var property in properties) {
      property.dispose();
    }

    // Dispose saving account controllers
    for (var account in savingAccounts) {
      account.dispose();
    }

    // Dispose liability controllers
    for (var loan in loans) {
      loan.dispose();
    }
    for (var card in creditCards) {
      card.dispose();
    }
    for (var bnpl in buyNowPayLaters) {
      bnpl.dispose();
    }
    for (var smsf in smsfs) {
      smsf.dispose();
    }
    hecsDebtController.dispose();

    // Dispose text editing controllers
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    expenseAmountController.dispose();
    expenseDateController.dispose();
    propertyTypeController.dispose();
    propertyAddressController.dispose();
    purchasePriceController.dispose();
    currentEstimateValueController.dispose();
    mortgageProviderController.dispose();
    currentMortgageAmountController.dispose();
    totalAssetsController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    accountTypeController.dispose();
    cashSavingController.dispose();
    investmentController.dispose();
    superannuationController.dispose();
    otherAssetsController.dispose();

    super.onClose();
  }
}