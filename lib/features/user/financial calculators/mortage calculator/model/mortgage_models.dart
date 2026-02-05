import 'dart:convert';

MortgageResponse mortgageResponseFromJson(String str) =>
    MortgageResponse.fromJson(json.decode(str) as Map<String, dynamic>?);

String mortgageResponseToJson(MortgageResponse data) => json.encode(data.toJson());

class MortgageResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final MortgageData? data;
  final Map<String, dynamic>? stats;

  const MortgageResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory MortgageResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const MortgageResponse();

    return MortgageResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: MortgageData.fromJson(json['data'] as Map<String, dynamic>?),
      stats: (json['stats'] as Map?)?.cast<String, dynamic>() ?? const {},
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "stats": stats ?? const {},
  };
}

class MortgageData {
  final double? monthlyRepayment;
  final LoanSummary? loanSummary;
  final PaymentOptions? paymentOptions;
  final PaymentBreakdown? paymentBreakdown;
  final BorrowingPosition? borrowingPosition;

  const MortgageData({
    this.monthlyRepayment,
    this.loanSummary,
    this.paymentOptions,
    this.paymentBreakdown,
    this.borrowingPosition,
  });

  factory MortgageData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const MortgageData();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return MortgageData(
      monthlyRepayment: d(json['monthlyRepayment']),
      loanSummary: LoanSummary.fromJson(json['loanSummary'] as Map<String, dynamic>?),
      paymentOptions:
      PaymentOptions.fromJson(json['paymentOptions'] as Map<String, dynamic>?),
      paymentBreakdown:
      PaymentBreakdown.fromJson(json['paymentBreakdown'] as Map<String, dynamic>?),
      borrowingPosition:
      BorrowingPosition.fromJson(json['borrowingPosition'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "monthlyRepayment": monthlyRepayment,
    "loanSummary": loanSummary?.toJson(),
    "paymentOptions": paymentOptions?.toJson(),
    "paymentBreakdown": paymentBreakdown?.toJson(),
    "borrowingPosition": borrowingPosition?.toJson(),
  };
}

class LoanSummary {
  final double? loanAmount;
  final double? interestRatePercent;

  const LoanSummary({this.loanAmount, this.interestRatePercent});

  factory LoanSummary.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LoanSummary();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return LoanSummary(
      loanAmount: d(json['loanAmount']),
      interestRatePercent: d(json['interestRatePercent']),
    );
  }

  Map<String, dynamic> toJson() => {
    "loanAmount": loanAmount,
    "interestRatePercent": interestRatePercent,
  };
}

class PaymentOptions {
  final InterestOnlyOption? interestOnly;
  final PrincipalAndInterestOption? principalAndInterest;

  const PaymentOptions({this.interestOnly, this.principalAndInterest});

  factory PaymentOptions.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PaymentOptions();

    return PaymentOptions(
      interestOnly:
      InterestOnlyOption.fromJson(json['interestOnly'] as Map<String, dynamic>?),
      principalAndInterest: PrincipalAndInterestOption.fromJson(
          json['principalAndInterest'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "interestOnly": interestOnly?.toJson(),
    "principalAndInterest": principalAndInterest?.toJson(),
  };
}

class InterestOnlyOption {
  final int? months;
  final double? monthlyPayment;
  final double? totalInterest30Years;
  final double? principalStillOwing;
  final double? totalToRepay;

  const InterestOnlyOption({
    this.months,
    this.monthlyPayment,
    this.totalInterest30Years,
    this.principalStillOwing,
    this.totalToRepay,
  });

  factory InterestOnlyOption.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const InterestOnlyOption();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return InterestOnlyOption(
      months: (json['months'] as num?)?.toInt(),
      monthlyPayment: d(json['monthlyPayment']),
      totalInterest30Years: d(json['totalInterest30Years']),
      principalStillOwing: d(json['principalStillOwing']),
      totalToRepay: d(json['totalToRepay']),
    );
  }

  Map<String, dynamic> toJson() => {
    "months": months,
    "monthlyPayment": monthlyPayment,
    "totalInterest30Years": totalInterest30Years,
    "principalStillOwing": principalStillOwing,
    "totalToRepay": totalToRepay,
  };
}

class PrincipalAndInterestOption {
  final double? monthlyPayment;
  final double? totalInterest30Years;
  final double? principalPaid;
  final double? totalToRepay;

  const PrincipalAndInterestOption({
    this.monthlyPayment,
    this.totalInterest30Years,
    this.principalPaid,
    this.totalToRepay,
  });

  factory PrincipalAndInterestOption.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PrincipalAndInterestOption();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return PrincipalAndInterestOption(
      monthlyPayment: d(json['monthlyPayment']),
      totalInterest30Years: d(json['totalInterest30Years']),
      principalPaid: d(json['principalPaid']),
      totalToRepay: d(json['totalToRepay']),
    );
  }

  Map<String, dynamic> toJson() => {
    "monthlyPayment": monthlyPayment,
    "totalInterest30Years": totalInterest30Years,
    "principalPaid": principalPaid,
    "totalToRepay": totalToRepay,
  };
}

class PaymentBreakdown {
  final double? principal;
  final double? interest;

  const PaymentBreakdown({this.principal, this.interest});

  factory PaymentBreakdown.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PaymentBreakdown();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return PaymentBreakdown(
      principal: d(json['principal']),
      interest: d(json['interest']),
    );
  }

  Map<String, dynamic> toJson() => {
    "principal": principal,
    "interest": interest,
  };
}

class BorrowingPosition {
  final double? deposit;
  final double? depositLvrPercent;
  final double? loanAmount;
  final double? propertyValue;

  const BorrowingPosition({
    this.deposit,
    this.depositLvrPercent,
    this.loanAmount,
    this.propertyValue,
  });

  factory BorrowingPosition.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const BorrowingPosition();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return BorrowingPosition(
      deposit: d(json['deposit']),
      depositLvrPercent: d(json['depositLvrPercent']),
      loanAmount: d(json['loanAmount']),
      propertyValue: d(json['propertyValue']),
    );
  }

  Map<String, dynamic> toJson() => {
    "deposit": deposit,
    "depositLvrPercent": depositLvrPercent,
    "loanAmount": loanAmount,
    "propertyValue": propertyValue,
  };
}
