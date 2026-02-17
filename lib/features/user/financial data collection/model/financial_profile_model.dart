// financial_profile_model.dart

class FinancialProfileModel {
  final int statusCode;
  final bool success;
  final String message;
  final FinancialProfileData data;
  final Map<String, dynamic> stats;

  FinancialProfileModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory FinancialProfileModel.fromJson(Map<String, dynamic> json) {
    return FinancialProfileModel(
      statusCode: (json['statusCode'] ?? 0) as int,
      success: (json['success'] ?? false) as bool,
      message: (json['message'] ?? '') as String,
      data: FinancialProfileData.fromJson((json['data'] ?? {}) as Map<String, dynamic>),
      stats: (json['stats'] ?? {}) as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'data': data.toJson(),
    'stats': stats,
  };
}

class FinancialProfileData {
  final String id;
  final String userId;
  final int howManyBorrowingAdults;
  final int howManyDependents;
  final num totalAssets;
  final String createdAt;
  final String updatedAt;

  final List<Adult> adults;
  final List<Dependent> dependents;
  final List<Expenses> expenses;
  final List<PropertyDetails> propertyDetails;
  final List<Assets> assets;
  final List<Liabilities> liabilities;

  FinancialProfileData({
    required this.id,
    required this.userId,
    required this.howManyBorrowingAdults,
    required this.howManyDependents,
    required this.totalAssets,
    required this.createdAt,
    required this.updatedAt,
    required this.adults,
    required this.dependents,
    required this.expenses,
    required this.propertyDetails,
    required this.assets,
    required this.liabilities,
  });

  factory FinancialProfileData.fromJson(Map<String, dynamic> json) {
    return FinancialProfileData(
      id: (json['id'] ?? '') as String,
      userId: (json['userId'] ?? '') as String,
      howManyBorrowingAdults: _toInt(json['howManyBorrowingAdults']),
      howManyDependents: _toInt(json['howManyDependents']),
      totalAssets: (json['totalAssets'] ?? 0) as num,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
      adults: _toList(json['adults'])
          .map((e) => Adult.fromJson(e as Map<String, dynamic>))
          .toList(),
      dependents: _toList(json['dependents'])
          .map((e) => Dependent.fromJson(e as Map<String, dynamic>))
          .toList(),
      expenses: _toList(json['expenses'])
          .map((e) => Expenses.fromJson(e as Map<String, dynamic>))
          .toList(),
      propertyDetails: _toList(json['propertyDetails'])
          .map((e) => PropertyDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      assets: _toList(json['assets'])
          .map((e) => Assets.fromJson(e as Map<String, dynamic>))
          .toList(),
      liabilities: _toList(json['liabilities'])
          .map((e) => Liabilities.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'howManyBorrowingAdults': howManyBorrowingAdults,
    'howManyDependents': howManyDependents,
    'totalAssets': totalAssets,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'adults': adults.map((e) => e.toJson()).toList(),
    'dependents': dependents.map((e) => e.toJson()).toList(),
    'expenses': expenses.map((e) => e.toJson()).toList(),
    'propertyDetails': propertyDetails.map((e) => e.toJson()).toList(),
    'assets': assets.map((e) => e.toJson()).toList(),
    'liabilities': liabilities.map((e) => e.toJson()).toList(),
  };
}

class Adult {
  final String id;
  final String financialProfileId;
  final String name;
  final String dob; // format: ddMMyyyy in your JSON
  final String email;
  final String phone;
  final String createdAt;
  final String updatedAt;
  final List<Income> incomes;

  Adult({
    required this.id,
    required this.financialProfileId,
    required this.name,
    required this.dob,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.incomes,
  });

  factory Adult.fromJson(Map<String, dynamic> json) {
    return Adult(
      id: (json['id'] ?? '') as String,
      financialProfileId: (json['financialProfileId'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      dob: (json['dob'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
      incomes: _toList(json['incomes'])
          .map((e) => Income.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financialProfileId': financialProfileId,
    'name': name,
    'dob': dob,
    'email': email,
    'phone': phone,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'incomes': incomes.map((e) => e.toJson()).toList(),
  };
}

class Income {
  final String id;
  final String adultId;
  final String primaryIncomeType;
  final num primaryIncomeAmount;
  final String incomeFrequency; // e.g., Annually
  final num otherIncome;
  final String taxRegion; // e.g., NSW
  final String createdAt;
  final String updatedAt;

  Income({
    required this.id,
    required this.adultId,
    required this.primaryIncomeType,
    required this.primaryIncomeAmount,
    required this.incomeFrequency,
    required this.otherIncome,
    required this.taxRegion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: (json['id'] ?? '') as String,
      adultId: (json['adultId'] ?? '') as String,
      primaryIncomeType: (json['primaryIncomeType'] ?? '') as String,
      primaryIncomeAmount: (json['primaryIncomeAmount'] ?? 0) as num,
      incomeFrequency: (json['incomeFrequency'] ?? '') as String,
      otherIncome: (json['otherIncome'] ?? 0) as num,
      taxRegion: (json['taxRegion'] ?? '') as String,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'adultId': adultId,
    'primaryIncomeType': primaryIncomeType,
    'primaryIncomeAmount': primaryIncomeAmount,
    'incomeFrequency': incomeFrequency,
    'otherIncome': otherIncome,
    'taxRegion': taxRegion,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class Dependent {
  // Your response shows empty list. Keep flexible.
  final Map<String, dynamic> raw;

  Dependent({required this.raw});

  factory Dependent.fromJson(Map<String, dynamic> json) => Dependent(raw: json);

  Map<String, dynamic> toJson() => raw;
}

/// Expense category object like food/transport/utilities etc.
class ExpenseItem {
  final num amount;
  final String frequency; // Annually/Monthly/etc.
  final String expenseDate; // YYYY-MM-DD

  ExpenseItem({
    required this.amount,
    required this.frequency,
    required this.expenseDate,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      amount: (json['amount'] ?? 0) as num,
      frequency: (json['frequency'] ?? '') as String,
      expenseDate: (json['expenseDate'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'frequency': frequency,
    'expenseDate': expenseDate,
  };
}

class Expenses {
  final ExpenseItem? food;
  final ExpenseItem? transport;
  final ExpenseItem? utilities;
  final ExpenseItem? insurance;
  final ExpenseItem? entertainment;

  final String id;
  final String financialProfileId;
  final String livingSituation;
  final num monthlyRentalPayment;
  final String createdAt;
  final String updatedAt;

  Expenses({
    required this.food,
    required this.transport,
    required this.utilities,
    required this.insurance,
    required this.entertainment,
    required this.id,
    required this.financialProfileId,
    required this.livingSituation,
    required this.monthlyRentalPayment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    ExpenseItem? parseItem(String key) {
      final v = json[key];
      if (v is Map<String, dynamic>) return ExpenseItem.fromJson(v);
      return null;
    }

    return Expenses(
      food: parseItem('food'),
      transport: parseItem('transport'),
      utilities: parseItem('utilities'),
      insurance: parseItem('insurance'),
      entertainment: parseItem('entertainment'),
      id: (json['id'] ?? '') as String,
      financialProfileId: (json['financialProfileId'] ?? '') as String,
      livingSituation: (json['livingSituation'] ?? '') as String,
      monthlyRentalPayment: (json['monthlyRentalPayment'] ?? 0) as num,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'food': food?.toJson(),
    'transport': transport?.toJson(),
    'utilities': utilities?.toJson(),
    'insurance': insurance?.toJson(),
    'entertainment': entertainment?.toJson(),
    'id': id,
    'financialProfileId': financialProfileId,
    'livingSituation': livingSituation,
    'monthlyRentalPayment': monthlyRentalPayment,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class PropertyDetails {
  final String id;
  final String financialProfileId;
  final String type;
  final String address;
  final num purchasePrice;
  final String purchaseDate; // YYYY-MM-DD
  final num currentEstimateValue;
  final String mortgageProvider;
  final num currentMortgageAmount;
  final num currentMortgageRate;
  final num currentMortgageInterestRate;
  final num mortgageFinishedRate;
  final num mortgageLimit;
  final String mortgageType; // Variable
  final int totalMonthOfInterest;
  final int ioPeriodMonth;
  final int remainingTerm;
  final num monthlyRentalPayment;
  final bool isInterestOnly;
  final bool isPnI;
  final String createdAt;
  final String updatedAt;

  PropertyDetails({
    required this.id,
    required this.financialProfileId,
    required this.type,
    required this.address,
    required this.purchasePrice,
    required this.purchaseDate,
    required this.currentEstimateValue,
    required this.mortgageProvider,
    required this.currentMortgageAmount,
    required this.currentMortgageRate,
    required this.currentMortgageInterestRate,
    required this.mortgageFinishedRate,
    required this.mortgageLimit,
    required this.mortgageType,
    required this.totalMonthOfInterest,
    required this.ioPeriodMonth,
    required this.remainingTerm,
    required this.monthlyRentalPayment,
    required this.isInterestOnly,
    required this.isPnI,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
    return PropertyDetails(
      id: (json['id'] ?? '') as String,
      financialProfileId: (json['financialProfileId'] ?? '') as String,
      type: (json['type'] ?? '') as String,
      address: (json['address'] ?? '') as String,
      purchasePrice: (json['purchasePrice'] ?? 0) as num,
      purchaseDate: (json['purchaseDate'] ?? '') as String,
      currentEstimateValue: (json['currentEstimateValue'] ?? 0) as num,
      mortgageProvider: (json['mortgageProvider'] ?? '') as String,
      currentMortgageAmount: (json['currentMortgageAmount'] ?? 0) as num,
      currentMortgageRate: (json['currentMortgageRate'] ?? 0) as num,
      currentMortgageInterestRate: (json['currentMortgageInterestRate'] ?? 0) as num,
      mortgageFinishedRate: (json['mortgageFinishedRate'] ?? 0) as num,
      mortgageLimit: (json['mortgageLimit'] ?? 0) as num,
      mortgageType: (json['mortgageType'] ?? '') as String,
      totalMonthOfInterest: _toInt(json['totalMonthOfInterest']),
      ioPeriodMonth: _toInt(json['ioPeriodMonth']),
      remainingTerm: _toInt(json['remainingTerm']),
      monthlyRentalPayment: (json['monthlyRentalPayment'] ?? 0) as num,
      isInterestOnly: (json['isInterestOnly'] ?? false) as bool,
      isPnI: (json['isPnI'] ?? false) as bool,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financialProfileId': financialProfileId,
    'type': type,
    'address': address,
    'purchasePrice': purchasePrice,
    'purchaseDate': purchaseDate,
    'currentEstimateValue': currentEstimateValue,
    'mortgageProvider': mortgageProvider,
    'currentMortgageAmount': currentMortgageAmount,
    'currentMortgageRate': currentMortgageRate,
    'currentMortgageInterestRate': currentMortgageInterestRate,
    'mortgageFinishedRate': mortgageFinishedRate,
    'mortgageLimit': mortgageLimit,
    'mortgageType': mortgageType,
    'totalMonthOfInterest': totalMonthOfInterest,
    'ioPeriodMonth': ioPeriodMonth,
    'remainingTerm': remainingTerm,
    'monthlyRentalPayment': monthlyRentalPayment,
    'isInterestOnly': isInterestOnly,
    'isPnI': isPnI,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class Assets {
  final String id;
  final String financialProfileId;
  final String bankName;
  final String accountNumber;
  final String accountType;
  final num interestRate;
  final num cashSaving;
  final num investment;
  final num superannuation;
  final num otherAssets;
  final String createdAt;
  final String updatedAt;

  Assets({
    required this.id,
    required this.financialProfileId,
    required this.bankName,
    required this.accountNumber,
    required this.accountType,
    required this.interestRate,
    required this.cashSaving,
    required this.investment,
    required this.superannuation,
    required this.otherAssets,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      id: (json['id'] ?? '') as String,
      financialProfileId: (json['financialProfileId'] ?? '') as String,
      bankName: (json['bankName'] ?? '') as String,
      accountNumber: (json['accountNumber'] ?? '') as String,
      accountType: (json['accountType'] ?? '') as String,
      interestRate: (json['interestRate'] ?? 0) as num,
      cashSaving: (json['cashSaving'] ?? 0) as num,
      investment: (json['investment'] ?? 0) as num,
      superannuation: (json['superannuation'] ?? 0) as num,
      otherAssets: (json['otherAssets'] ?? 0) as num,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financialProfileId': financialProfileId,
    'bankName': bankName,
    'accountNumber': accountNumber,
    'accountType': accountType,
    'interestRate': interestRate,
    'cashSaving': cashSaving,
    'investment': investment,
    'superannuation': superannuation,
    'otherAssets': otherAssets,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class Liabilities {
  final String id;
  final String financialProfileId;
  final num hecsDebt;
  final String createdAt;
  final String updatedAt;

  final List<Loan> loans;
  final List<BuyNowPayLater> buyNowPayLaters;
  final List<CreditCard> creditCards;
  final List<Smsf> smsfs;

  Liabilities({
    required this.id,
    required this.financialProfileId,
    required this.hecsDebt,
    required this.createdAt,
    required this.updatedAt,
    required this.loans,
    required this.buyNowPayLaters,
    required this.creditCards,
    required this.smsfs,
  });

  factory Liabilities.fromJson(Map<String, dynamic> json) {
    return Liabilities(
      id: (json['id'] ?? '') as String,
      financialProfileId: (json['financialProfileId'] ?? '') as String,
      hecsDebt: (json['hecsDebt'] ?? 0) as num,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
      loans: _toList(json['loans'])
          .map((e) => Loan.fromJson(e as Map<String, dynamic>))
          .toList(),
      buyNowPayLaters: _toList(json['buyNowPayLaters'])
          .map((e) => BuyNowPayLater.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditCards: _toList(json['creditCards'])
          .map((e) => CreditCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      smsfs: _toList(json['smsfs'])
          .map((e) => Smsf.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financialProfileId': financialProfileId,
    'hecsDebt': hecsDebt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'loans': loans.map((e) => e.toJson()).toList(),
    'buyNowPayLaters': buyNowPayLaters.map((e) => e.toJson()).toList(),
    'creditCards': creditCards.map((e) => e.toJson()).toList(),
    'smsfs': smsfs.map((e) => e.toJson()).toList(),
  };
}

class Loan {
  final String id;
  final String liabilityId;
  final String bankName;
  final num currentBalance;
  final num interestRate;
  final num monthlyPayment;
  final int remainingMonths;
  final String createdAt;
  final String updatedAt;

  Loan({
    required this.id,
    required this.liabilityId,
    required this.bankName,
    required this.currentBalance,
    required this.interestRate,
    required this.monthlyPayment,
    required this.remainingMonths,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: (json['id'] ?? '') as String,
      liabilityId: (json['liabilityId'] ?? '') as String,
      bankName: (json['bankName'] ?? '') as String,
      currentBalance: (json['currentBalance'] ?? 0) as num,
      interestRate: (json['interestRate'] ?? 0) as num,
      monthlyPayment: (json['monthlyPayment'] ?? 0) as num,
      remainingMonths: _toInt(json['remainingMonths']),
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'liabilityId': liabilityId,
    'bankName': bankName,
    'currentBalance': currentBalance,
    'interestRate': interestRate,
    'monthlyPayment': monthlyPayment,
    'remainingMonths': remainingMonths,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class BuyNowPayLater {
  final String id;
  final String liabilityId;
  final String bankName;
  final num currentBalance;
  final num interestRate;
  final num monthlyPayment;
  final int remainingMonths;
  final String createdAt;
  final String updatedAt;

  BuyNowPayLater({
    required this.id,
    required this.liabilityId,
    required this.bankName,
    required this.currentBalance,
    required this.interestRate,
    required this.monthlyPayment,
    required this.remainingMonths,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BuyNowPayLater.fromJson(Map<String, dynamic> json) {
    return BuyNowPayLater(
      id: (json['id'] ?? '') as String,
      liabilityId: (json['liabilityId'] ?? '') as String,
      bankName: (json['bankName'] ?? '') as String,
      currentBalance: (json['currentBalance'] ?? 0) as num,
      interestRate: (json['interestRate'] ?? 0) as num,
      monthlyPayment: (json['monthlyPayment'] ?? 0) as num,
      remainingMonths: _toInt(json['remainingMonths']),
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'liabilityId': liabilityId,
    'bankName': bankName,
    'currentBalance': currentBalance,
    'interestRate': interestRate,
    'monthlyPayment': monthlyPayment,
    'remainingMonths': remainingMonths,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class CreditCard {
  final String id;
  final String liabilityId;
  final String bankName;
  final num creditLimit;
  final num currentBalance;
  final String monthlyPayment; // "5%" in your response
  final String createdAt;
  final String updatedAt;

  CreditCard({
    required this.id,
    required this.liabilityId,
    required this.bankName,
    required this.creditLimit,
    required this.currentBalance,
    required this.monthlyPayment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: (json['id'] ?? '') as String,
      liabilityId: (json['liabilityId'] ?? '') as String,
      bankName: (json['bankName'] ?? '') as String,
      creditLimit: (json['creditLimit'] ?? 0) as num,
      currentBalance: (json['currentBalance'] ?? 0) as num,
      monthlyPayment: (json['monthlyPayment'] ?? '') as String,
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'liabilityId': liabilityId,
    'bankName': bankName,
    'creditLimit': creditLimit,
    'currentBalance': currentBalance,
    'monthlyPayment': monthlyPayment,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class Smsf {
  final String id;
  final String liabilityId;
  final String bankName;
  final num loanBalance;
  final num rate;
  final num monthlyAmount;
  final int remainingMonths;
  final String createdAt;
  final String updatedAt;

  Smsf({
    required this.id,
    required this.liabilityId,
    required this.bankName,
    required this.loanBalance,
    required this.rate,
    required this.monthlyAmount,
    required this.remainingMonths,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Smsf.fromJson(Map<String, dynamic> json) {
    return Smsf(
      id: (json['id'] ?? '') as String,
      liabilityId: (json['liabilityId'] ?? '') as String,
      bankName: (json['bankName'] ?? '') as String,
      loanBalance: (json['loanBalance'] ?? 0) as num,
      rate: (json['rate'] ?? 0) as num,
      monthlyAmount: (json['monthlyAmount'] ?? 0) as num,
      remainingMonths: _toInt(json['remainingMonths']),
      createdAt: (json['createdAt'] ?? '') as String,
      updatedAt: (json['updatedAt'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'liabilityId': liabilityId,
    'bankName': bankName,
    'loanBalance': loanBalance,
    'rate': rate,
    'monthlyAmount': monthlyAmount,
    'remainingMonths': remainingMonths,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

// ---------- helpers ----------

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

List<dynamic> _toList(dynamic v) {
  if (v is List) return v;
  return const [];
}
