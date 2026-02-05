import 'dart:convert';

BorrowingOverviewResponse borrowingOverviewResponseFromJson(String str) =>
    BorrowingOverviewResponse.fromJson(json.decode(str) as Map<String, dynamic>?);

String borrowingOverviewResponseToJson(BorrowingOverviewResponse data) =>
    json.encode(data.toJson());

class BorrowingOverviewResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final BorrowingOverviewData? data;
  final Map<String, dynamic>? stats;

  const BorrowingOverviewResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory BorrowingOverviewResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const BorrowingOverviewResponse();

    return BorrowingOverviewResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: BorrowingOverviewData.fromJson(json['data'] as Map<String, dynamic>?),
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

class BorrowingOverviewData {
  final EstimatedBorrowingCapacity? estimatedBorrowingCapacity;
  final FinancialSummary? financialSummary;
  final AssetsVsLiabilities? assetsVsLiabilities;
  final PropertyPortfolioDetails? propertyPortfolioDetails;

  const BorrowingOverviewData({
    this.estimatedBorrowingCapacity,
    this.financialSummary,
    this.assetsVsLiabilities,
    this.propertyPortfolioDetails,
  });

  factory BorrowingOverviewData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const BorrowingOverviewData();

    return BorrowingOverviewData(
      estimatedBorrowingCapacity: EstimatedBorrowingCapacity.fromJson(
          json['estimatedBorrowingCapacity'] as Map<String, dynamic>?),
      financialSummary:
      FinancialSummary.fromJson(json['financialSummary'] as Map<String, dynamic>?),
      assetsVsLiabilities:
      AssetsVsLiabilities.fromJson(json['assetsVsLiabilities'] as Map<String, dynamic>?),
      propertyPortfolioDetails: PropertyPortfolioDetails.fromJson(
          json['propertyPortfolioDetails'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "estimatedBorrowingCapacity": estimatedBorrowingCapacity?.toJson(),
    "financialSummary": financialSummary?.toJson(),
    "assetsVsLiabilities": assetsVsLiabilities?.toJson(),
    "propertyPortfolioDetails": propertyPortfolioDetails?.toJson(),
  };
}

class EstimatedBorrowingCapacity {
  final double? min;
  final double? max;
  final String? status;

  const EstimatedBorrowingCapacity({this.min, this.max, this.status});

  factory EstimatedBorrowingCapacity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const EstimatedBorrowingCapacity();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return EstimatedBorrowingCapacity(
      min: d(json['min']),
      max: d(json['max']),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
    "status": status,
  };
}

class FinancialSummary {
  final double? netWorth;
  final double? debtToIncomeRatio;

  const FinancialSummary({this.netWorth, this.debtToIncomeRatio});

  factory FinancialSummary.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const FinancialSummary();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return FinancialSummary(
      netWorth: d(json['netWorth']),
      debtToIncomeRatio: d(json['debtToIncomeRatio']),
    );
  }

  Map<String, dynamic> toJson() => {
    "netWorth": netWorth,
    "debtToIncomeRatio": debtToIncomeRatio,
  };
}

class AssetsVsLiabilities {
  final double? assets;
  final double? liabilities;

  const AssetsVsLiabilities({this.assets, this.liabilities});

  factory AssetsVsLiabilities.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const AssetsVsLiabilities();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return AssetsVsLiabilities(
      assets: d(json['assets']),
      liabilities: d(json['liabilities']),
    );
  }

  Map<String, dynamic> toJson() => {
    "assets": assets,
    "liabilities": liabilities,
  };
}

class PropertyPortfolioDetails {
  final double? totalPropertyValue;
  final double? totalCurrentBorrowings;
  final double? availableEquity;
  final double? totalLvr;

  const PropertyPortfolioDetails({
    this.totalPropertyValue,
    this.totalCurrentBorrowings,
    this.availableEquity,
    this.totalLvr,
  });

  factory PropertyPortfolioDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PropertyPortfolioDetails();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return PropertyPortfolioDetails(
      totalPropertyValue: d(json['totalPropertyValue']),
      totalCurrentBorrowings: d(json['totalCurrentBorrowings']),
      availableEquity: d(json['availableEquity']),
      totalLvr: d(json['totalLVR']) ?? d(json['totalLvr']), // ✅ supports both keys
    );
  }

  Map<String, dynamic> toJson() => {
    "totalPropertyValue": totalPropertyValue,
    "totalCurrentBorrowings": totalCurrentBorrowings,
    "availableEquity": availableEquity,
    "totalLVR": totalLvr,
  };
}
