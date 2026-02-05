import 'dart:convert';

MyPropertyModel myPropertyResponseFromJson(String str) =>
    MyPropertyModel.fromJson(json.decode(str));

String myPropertyResponseToJson(MyPropertyModel data) =>
    json.encode(data.toJson());

class MyPropertyModel {
  int statusCode;
  bool success;
  String message;
  MyPropertyData data;
  Map<String, dynamic> stats;

  MyPropertyModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory MyPropertyModel.fromJson(Map<String, dynamic> json) {
    return MyPropertyModel(
      statusCode: (json['statusCode'] as num).toInt(),
      success: json['success'] == true,
      message: (json['message'] ?? '').toString(),
      data: MyPropertyData.fromJson(json['data'] as Map<String, dynamic>),
      stats: (json['stats'] as Map?)?.cast<String, dynamic>() ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data.toJson(),
      "stats": stats,
    };
  }
}

class MyPropertyData {
  String id;
  String userId;
  int howManyBorrowingAdults;
  int howManyDependents;
  double totalAssets;
  DateTime createdAt;
  DateTime updatedAt;
  List<PropertyDetail> propertyDetails;
  List<Liability> liabilities;

  MyPropertyData({
    required this.id,
    required this.userId,
    required this.howManyBorrowingAdults,
    required this.howManyDependents,
    required this.totalAssets,
    required this.createdAt,
    required this.updatedAt,
    required this.propertyDetails,
    required this.liabilities,
  });

  factory MyPropertyData.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();
    int i(dynamic v) => (v as num).toInt();

    return MyPropertyData(
      id: (json['id'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      howManyBorrowingAdults: i(json['howManyBorrowingAdults'] ?? 0),
      howManyDependents: i(json['howManyDependents'] ?? 0),
      totalAssets: json['totalAssets'] == null ? 0.0 : d(json['totalAssets']),
      createdAt: DateTime.parse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.parse((json['updatedAt'] ?? '').toString()),
      propertyDetails: (json['propertyDetails'] as List? ?? [])
          .map((e) => PropertyDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      liabilities: (json['liabilities'] as List? ?? [])
          .map((e) => Liability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "howManyBorrowingAdults": howManyBorrowingAdults,
      "howManyDependents": howManyDependents,
      "totalAssets": totalAssets,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "propertyDetails": propertyDetails.map((e) => e.toJson()).toList(),
      "liabilities": liabilities.map((e) => e.toJson()).toList(),
    };
  }
}

class PropertyDetail {
  String id;
  String financialProfileId;
  String type;
  String address;
  double purchasePrice;
  String purchaseDate; // kept as String because API gives YYYY-MM-DD
  double currentEstimateValue;
  String mortgageProvider;
  double currentMortgageAmount;
  double currentMortgageRate;
  double currentMortgageInterestRate;
  double mortgageFinishedRate;
  double mortgageLimit;
  String mortgageType;
  int totalMonthOfInterest;
  int ioPeriodMonth;
  int remainingTerm;
  double monthlyRentalPayment;
  bool isInterestOnly;
  bool isPnI;
  DateTime createdAt;
  DateTime updatedAt;

  PropertyDetail({
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

  factory PropertyDetail.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();
    int i(dynamic v) => (v as num).toInt();

    return PropertyDetail(
      id: (json['id'] ?? '').toString(),
      financialProfileId: (json['financialProfileId'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      purchasePrice: json['purchasePrice'] == null ? 0.0 : d(json['purchasePrice']),
      purchaseDate: (json['purchaseDate'] ?? '').toString(),
      currentEstimateValue: json['currentEstimateValue'] == null ? 0.0 : d(json['currentEstimateValue']),
      mortgageProvider: (json['mortgageProvider'] ?? '').toString(),
      currentMortgageAmount: json['currentMortgageAmount'] == null ? 0.0 : d(json['currentMortgageAmount']),
      currentMortgageRate: json['currentMortgageRate'] == null ? 0.0 : d(json['currentMortgageRate']),
      currentMortgageInterestRate: json['currentMortgageInterestRate'] == null ? 0.0 : d(json['currentMortgageInterestRate']),
      mortgageFinishedRate: json['mortgageFinishedRate'] == null ? 0.0 : d(json['mortgageFinishedRate']),
      mortgageLimit: json['mortgageLimit'] == null ? 0.0 : d(json['mortgageLimit']),
      mortgageType: (json['mortgageType'] ?? '').toString(),
      totalMonthOfInterest: i(json['totalMonthOfInterest'] ?? 0),
      ioPeriodMonth: i(json['ioPeriodMonth'] ?? 0),
      remainingTerm: i(json['remainingTerm'] ?? 0),
      monthlyRentalPayment: json['monthlyRentalPayment'] == null ? 0.0 : d(json['monthlyRentalPayment']),
      isInterestOnly: json['isInterestOnly'] == true,
      isPnI: json['isPnI'] == true,
      createdAt: DateTime.parse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.parse((json['updatedAt'] ?? '').toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "financialProfileId": financialProfileId,
      "type": type,
      "address": address,
      "purchasePrice": purchasePrice,
      "purchaseDate": purchaseDate,
      "currentEstimateValue": currentEstimateValue,
      "mortgageProvider": mortgageProvider,
      "currentMortgageAmount": currentMortgageAmount,
      "currentMortgageRate": currentMortgageRate,
      "currentMortgageInterestRate": currentMortgageInterestRate,
      "mortgageFinishedRate": mortgageFinishedRate,
      "mortgageLimit": mortgageLimit,
      "mortgageType": mortgageType,
      "totalMonthOfInterest": totalMonthOfInterest,
      "ioPeriodMonth": ioPeriodMonth,
      "remainingTerm": remainingTerm,
      "monthlyRentalPayment": monthlyRentalPayment,
      "isInterestOnly": isInterestOnly,
      "isPnI": isPnI,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}

class Liability {
  String id;
  String financialProfileId;
  double hecsDebt;
  DateTime createdAt;
  DateTime updatedAt;
  List<LoanItem> loans;

  Liability({
    required this.id,
    required this.financialProfileId,
    required this.hecsDebt,
    required this.createdAt,
    required this.updatedAt,
    required this.loans,
  });

  factory Liability.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return Liability(
      id: (json['id'] ?? '').toString(),
      financialProfileId: (json['financialProfileId'] ?? '').toString(),
      hecsDebt: json['hecsDebt'] == null ? 0.0 : d(json['hecsDebt']),
      createdAt: DateTime.parse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.parse((json['updatedAt'] ?? '').toString()),
      loans: (json['loans'] as List? ?? [])
          .map((e) => LoanItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "financialProfileId": financialProfileId,
      "hecsDebt": hecsDebt,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "loans": loans.map((e) => e.toJson()).toList(),
    };
  }
}

class LoanItem {
  String id;
  String liabilityId;
  String bankName;
  double currentBalance;
  double interestRate;
  double monthlyPayment;
  int remainingMonths;
  DateTime createdAt;
  DateTime updatedAt;

  LoanItem({
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

  factory LoanItem.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();
    int i(dynamic v) => (v as num).toInt();

    return LoanItem(
      id: (json['id'] ?? '').toString(),
      liabilityId: (json['liabilityId'] ?? '').toString(),
      bankName: (json['bankName'] ?? '').toString(),
      currentBalance: json['currentBalance'] == null ? 0.0 : d(json['currentBalance']),
      interestRate: json['interestRate'] == null ? 0.0 : d(json['interestRate']),
      monthlyPayment: json['monthlyPayment'] == null ? 0.0 : d(json['monthlyPayment']),
      remainingMonths: i(json['remainingMonths'] ?? 0),
      createdAt: DateTime.parse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.parse((json['updatedAt'] ?? '').toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "liabilityId": liabilityId,
      "bankName": bankName,
      "currentBalance": currentBalance,
      "interestRate": interestRate,
      "monthlyPayment": monthlyPayment,
      "remainingMonths": remainingMonths,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
