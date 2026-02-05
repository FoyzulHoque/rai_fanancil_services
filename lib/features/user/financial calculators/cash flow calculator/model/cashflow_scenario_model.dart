import 'dart:convert';

CashflowScenarioResponse cashflowScenarioResponseFromJson(String str) =>
    CashflowScenarioResponse.fromJson(json.decode(str));

String cashflowScenarioResponseToJson(CashflowScenarioResponse data) =>
    json.encode(data.toJson());

class CashflowScenarioResponse {
  int statusCode;
  bool success;
  String message;
  CashflowScenarioData data;
  Map<String, dynamic> stats;

  CashflowScenarioResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory CashflowScenarioResponse.fromJson(Map<String, dynamic> json) {
    return CashflowScenarioResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      success: json['success'] == true,
      message: (json['message'] ?? '').toString(),
      data: CashflowScenarioData.fromJson(json['data'] as Map<String, dynamic>),
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

class CashflowScenarioData {
  double netMonthlyCashflow;
  double baseMonthlyIncome;
  double baseMonthlyExpenses;
  double baseNetCashflow;
  double additionalMonthlyRepayments;
  double projectedMonthlyExpenses;
  double projectedNetCashflow;

  AssetLiabilityPosition assetLiabilityPosition;

  double propertyValue;
  double totalLoans;
  double equity;
  double lvr;

  AnnualIncreases annualIncreases;

  CashflowScenarioData({
    required this.netMonthlyCashflow,
    required this.baseMonthlyIncome,
    required this.baseMonthlyExpenses,
    required this.baseNetCashflow,
    required this.additionalMonthlyRepayments,
    required this.projectedMonthlyExpenses,
    required this.projectedNetCashflow,
    required this.assetLiabilityPosition,
    required this.propertyValue,
    required this.totalLoans,
    required this.equity,
    required this.lvr,
    required this.annualIncreases,
  });

  factory CashflowScenarioData.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return CashflowScenarioData(
      netMonthlyCashflow: d(json['netMonthlyCashflow']),
      baseMonthlyIncome: d(json['baseMonthlyIncome']),
      baseMonthlyExpenses: d(json['baseMonthlyExpenses']),
      baseNetCashflow: d(json['baseNetCashflow']),
      additionalMonthlyRepayments: d(json['additionalMonthlyRepayments']),
      projectedMonthlyExpenses: d(json['projectedMonthlyExpenses']),
      projectedNetCashflow: d(json['projectedNetCashflow']),
      assetLiabilityPosition:
      AssetLiabilityPosition.fromJson(json['assetLiabilityPosition']),
      propertyValue: d(json['propertyValue']),
      totalLoans: d(json['totalLoans']),
      equity: d(json['equity']),
      lvr: d(json['lvr']),
      annualIncreases: AnnualIncreases.fromJson(json['annualIncreases']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "netMonthlyCashflow": netMonthlyCashflow,
      "baseMonthlyIncome": baseMonthlyIncome,
      "baseMonthlyExpenses": baseMonthlyExpenses,
      "baseNetCashflow": baseNetCashflow,
      "additionalMonthlyRepayments": additionalMonthlyRepayments,
      "projectedMonthlyExpenses": projectedMonthlyExpenses,
      "projectedNetCashflow": projectedNetCashflow,
      "assetLiabilityPosition": assetLiabilityPosition.toJson(),
      "propertyValue": propertyValue,
      "totalLoans": totalLoans,
      "equity": equity,
      "lvr": lvr,
      "annualIncreases": annualIncreases.toJson(),
    };
  }
}

class AssetLiabilityPosition {
  double propertyValue;
  double totalLoans;
  double equity;
  double lvr;
  double liabilityPercent;
  double equityPercent;

  AssetLiabilityPosition({
    required this.propertyValue,
    required this.totalLoans,
    required this.equity,
    required this.lvr,
    required this.liabilityPercent,
    required this.equityPercent,
  });

  factory AssetLiabilityPosition.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return AssetLiabilityPosition(
      propertyValue: d(json['propertyValue']),
      totalLoans: d(json['totalLoans']),
      equity: d(json['equity']),
      lvr: d(json['lvr']),
      liabilityPercent: d(json['liabilityPercent']),
      equityPercent: d(json['equityPercent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "propertyValue": propertyValue,
      "totalLoans": totalLoans,
      "equity": equity,
      "lvr": lvr,
      "liabilityPercent": liabilityPercent,
      "equityPercent": equityPercent,
    };
  }
}

class AnnualIncreases {
  double rentalIncreasePerYear;
  double cashRateChange;
  double annualSalaryIncrease;
  double expenseInflation;

  AnnualIncreases({
    required this.rentalIncreasePerYear,
    required this.cashRateChange,
    required this.annualSalaryIncrease,
    required this.expenseInflation,
  });

  factory AnnualIncreases.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return AnnualIncreases(
      rentalIncreasePerYear: d(json['rentalIncreasePerYear']),
      cashRateChange: d(json['cashRateChange']),
      annualSalaryIncrease: d(json['annualSalaryIncrease']),
      expenseInflation: d(json['expenseInflation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rentalIncreasePerYear": rentalIncreasePerYear,
      "cashRateChange": cashRateChange,
      "annualSalaryIncrease": annualSalaryIncrease,
      "expenseInflation": expenseInflation,
    };
  }
}
