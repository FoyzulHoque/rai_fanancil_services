import 'dart:convert';

LoanComparisonResponse loanComparisonResponseFromJson(String str) =>
    LoanComparisonResponse.fromJson(json.decode(str));

String loanComparisonResponseToJson(LoanComparisonResponse data) =>
    json.encode(data.toJson());

class LoanComparisonResponse {
  final int statusCode;
  final bool success;
  final String message;
  final LoanComparisonData? data;
  final Map<String, dynamic> stats;

  LoanComparisonResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory LoanComparisonResponse.fromJson(Map<String, dynamic> json) {
    return LoanComparisonResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      success: json['success'] == true,
      message: (json['message'] ?? '').toString(),
      data: json['data'] == null
          ? null
          : LoanComparisonData.fromJson(json['data'] as Map<String, dynamic>),
      stats: (json['stats'] as Map?)?.cast<String, dynamic>() ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "stats": stats,
  };
}

class LoanComparisonData {
  final double currentRatePercent;
  final double bestMarketRatePercent;
  final PropertySummary propertySummary;
  final SavingsSummary savingsSummary;
  final BestRateProvider bestRateProvider;
  final List<WhyWorkItem> whyWorkWithMe;

  LoanComparisonData({
    required this.currentRatePercent,
    required this.bestMarketRatePercent,
    required this.propertySummary,
    required this.savingsSummary,
    required this.bestRateProvider,
    required this.whyWorkWithMe,
  });

  factory LoanComparisonData.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v is num) ? v.toDouble() : double.tryParse("$v") ?? 0;

    return LoanComparisonData(
      currentRatePercent: d(json['currentRatePercent']),
      bestMarketRatePercent: d(json['bestMarketRatePercent']),
      propertySummary: PropertySummary.fromJson(
          (json['propertySummary'] ?? {}) as Map<String, dynamic>),
      savingsSummary: SavingsSummary.fromJson(
          (json['savingsSummary'] ?? {}) as Map<String, dynamic>),
      bestRateProvider: BestRateProvider.fromJson(
          (json['bestRateProvider'] ?? {}) as Map<String, dynamic>),
      whyWorkWithMe: (json['whyWorkWithMe'] as List? ?? [])
          .map((e) => WhyWorkItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "currentRatePercent": currentRatePercent,
    "bestMarketRatePercent": bestMarketRatePercent,
    "propertySummary": propertySummary.toJson(),
    "savingsSummary": savingsSummary.toJson(),
    "bestRateProvider": bestRateProvider.toJson(),
    "whyWorkWithMe": whyWorkWithMe.map((e) => e.toJson()).toList(),
  };
}

class PropertySummary {
  final String propertyId;
  final String location;
  final String address;
  final double loanBalance;
  final double remainingTermYears;

  PropertySummary({
    required this.propertyId,
    required this.location,
    required this.address,
    required this.loanBalance,
    required this.remainingTermYears,
  });

  factory PropertySummary.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v is num) ? v.toDouble() : double.tryParse("$v") ?? 0;

    return PropertySummary(
      propertyId: (json['propertyId'] ?? '').toString(),
      location: (json['location'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      loanBalance: d(json['loanBalance']),
      remainingTermYears: d(json['remainingTermYears']),
    );
  }

  Map<String, dynamic> toJson() => {
    "propertyId": propertyId,
    "location": location,
    "address": address,
    "loanBalance": loanBalance,
    "remainingTermYears": remainingTermYears,
  };
}

class SavingsSummary {
  final double monthlySavings;
  final double totalInterestSaved;

  SavingsSummary({
    required this.monthlySavings,
    required this.totalInterestSaved,
  });

  factory SavingsSummary.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v is num) ? v.toDouble() : double.tryParse("$v") ?? 0;

    return SavingsSummary(
      monthlySavings: d(json['monthlySavings']),
      totalInterestSaved: d(json['totalInterestSaved']),
    );
  }

  Map<String, dynamic> toJson() => {
    "monthlySavings": monthlySavings,
    "totalInterestSaved": totalInterestSaved,
  };
}

class BestRateProvider {
  final String name;
  final double ratePercent;
  final String description;

  BestRateProvider({
    required this.name,
    required this.ratePercent,
    required this.description,
  });

  factory BestRateProvider.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v is num) ? v.toDouble() : double.tryParse("$v") ?? 0;

    return BestRateProvider(
      name: (json['name'] ?? '').toString(),
      ratePercent: d(json['ratePercent']),
      description: (json['description'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "ratePercent": ratePercent,
    "description": description,
  };
}

class WhyWorkItem {
  final String title;
  final String description;

  WhyWorkItem({
    required this.title,
    required this.description,
  });

  factory WhyWorkItem.fromJson(Map<String, dynamic> json) {
    return WhyWorkItem(
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}
