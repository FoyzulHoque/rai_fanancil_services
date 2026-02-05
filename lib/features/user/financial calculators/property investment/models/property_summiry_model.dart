import 'dart:convert';

PropertyInvestmentResponse propertyInvestmentResponseFromJson(String str) =>
    PropertyInvestmentResponse.fromJson(json.decode(str));

String propertyInvestmentResponseToJson(PropertyInvestmentResponse data) =>
    json.encode(data.toJson());

class PropertyInvestmentResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final PropertyInvestmentData? data;
  final Map<String, dynamic>? stats;

  const PropertyInvestmentResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory PropertyInvestmentResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PropertyInvestmentResponse();

    return PropertyInvestmentResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: PropertyInvestmentData.fromJson(
          json['data'] as Map<String, dynamic>?),
      stats: (json['stats'] as Map?)?.cast<String, dynamic>() ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "stats": stats ?? {},
  };
}

class PropertyInvestmentData {
  final double? roiPercent;
  final double? annualCashflow;
  final double? capitalGrowth;
  final List<CapitalGrowthItem>? capitalGrowthForecast;
  final InsuranceEstimate? insuranceEstimate;
  final TaxImpact? taxImpact;
  final PortfolioStats? portfolioStats;

  const PropertyInvestmentData({
    this.roiPercent,
    this.annualCashflow,
    this.capitalGrowth,
    this.capitalGrowthForecast,
    this.insuranceEstimate,
    this.taxImpact,
    this.portfolioStats,
  });

  factory PropertyInvestmentData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PropertyInvestmentData();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");
    return PropertyInvestmentData(
      roiPercent: d(json['roiPercent']),
      annualCashflow: d(json['annualCashflow']),
      capitalGrowth: d(json['capitalGrowth']),
      capitalGrowthForecast: (json['capitalGrowthForecast'] as List?)
          ?.map((e) =>
          CapitalGrowthItem.fromJson(e as Map<String, dynamic>?))
          .toList() ??
          const [],
      insuranceEstimate: InsuranceEstimate.fromJson(
          json['insuranceEstimate'] as Map<String, dynamic>?),
      taxImpact: TaxImpact.fromJson(json['taxImpact'] as Map<String, dynamic>?),
      portfolioStats: PortfolioStats.fromJson(
          json['portfolioStats'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "roiPercent": roiPercent,
    "annualCashflow": annualCashflow,
    "capitalGrowth": capitalGrowth,
    "capitalGrowthForecast":
    (capitalGrowthForecast ?? []).map((e) => e.toJson()).toList(),
    "insuranceEstimate": insuranceEstimate?.toJson(),
    "taxImpact": taxImpact?.toJson(),
    "portfolioStats": portfolioStats?.toJson(),
  };
}

class CapitalGrowthItem {
  final String? name;
  final List<PropertyForecast>? forecast;

  const CapitalGrowthItem({this.name, this.forecast});

  factory CapitalGrowthItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CapitalGrowthItem();

    return CapitalGrowthItem(
      name: json['name']?.toString(),
      forecast: (json['forecast'] as List?)
          ?.map((e) => PropertyForecast.fromJson(e as Map<String, dynamic>?))
          .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "forecast": (forecast ?? []).map((e) => e.toJson()).toList(),
  };
}

class PropertyForecast {
  final int? year;
  final double? propertyValue;
  final double? equity;

  const PropertyForecast({this.year, this.propertyValue, this.equity});

  factory PropertyForecast.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PropertyForecast();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return PropertyForecast(
      year: (json['year'] as num?)?.toInt(),
      propertyValue: d(json['propertyValue']),
      equity: d(json['equity']),
    );
  }

  Map<String, dynamic> toJson() => {
    "year": year,
    "propertyValue": propertyValue,
    "equity": equity,
  };
}

class InsuranceEstimate {
  final double? buildingInsurancePerYear;
  final double? landlordInsurancePerYear;
  final double? totalInsurancePerYear;

  const InsuranceEstimate({
    this.buildingInsurancePerYear,
    this.landlordInsurancePerYear,
    this.totalInsurancePerYear,
  });

  factory InsuranceEstimate.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const InsuranceEstimate();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return InsuranceEstimate(
      buildingInsurancePerYear: d(json['buildingInsurancePerYear']),
      landlordInsurancePerYear: d(json['landlordInsurancePerYear']),
      totalInsurancePerYear: d(json['totalInsurancePerYear']),
    );
  }

  Map<String, dynamic> toJson() => {
    "buildingInsurancePerYear": buildingInsurancePerYear,
    "landlordInsurancePerYear": landlordInsurancePerYear,
    "totalInsurancePerYear": totalInsurancePerYear,
  };
}

class TaxImpact {
  final double? rentalIncome;
  final double? deductibleExpenses;
  final double? depreciation;
  final double? taxableIncome;
  final double? estimatedTaxRatePercent;
  final double? estimatedTax;

  const TaxImpact({
    this.rentalIncome,
    this.deductibleExpenses,
    this.depreciation,
    this.taxableIncome,
    this.estimatedTaxRatePercent,
    this.estimatedTax,
  });

  factory TaxImpact.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TaxImpact();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return TaxImpact(
      rentalIncome: d(json['rentalIncome']),
      deductibleExpenses: d(json['deductibleExpenses']),
      depreciation: d(json['depreciation']),
      taxableIncome: d(json['taxableIncome']),
      estimatedTaxRatePercent: d(json['estimatedTaxRatePercent']),
      estimatedTax: d(json['estimatedTax']),
    );
  }

  Map<String, dynamic> toJson() => {
    "rentalIncome": rentalIncome,
    "deductibleExpenses": deductibleExpenses,
    "depreciation": depreciation,
    "taxableIncome": taxableIncome,
    "estimatedTaxRatePercent": estimatedTaxRatePercent,
    "estimatedTax": estimatedTax,
  };
}

class PortfolioStats {
  final int? numberOfProperties;
  final double? totalLoans;
  final double? averageLvrPercent;
  final double? annualRentalIncome;
  final double? annualExpenses;

  const PortfolioStats({
    this.numberOfProperties,
    this.totalLoans,
    this.averageLvrPercent,
    this.annualRentalIncome,
    this.annualExpenses,
  });

  factory PortfolioStats.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PortfolioStats();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return PortfolioStats(
      numberOfProperties: (json['numberOfProperties'] as num?)?.toInt(),
      totalLoans: d(json['totalLoans']),
      averageLvrPercent: d(json['averageLvrPercent']),
      annualRentalIncome: d(json['annualRentalIncome']),
      annualExpenses: d(json['annualExpenses']),
    );
  }

  Map<String, dynamic> toJson() => {
    "numberOfProperties": numberOfProperties,
    "totalLoans": totalLoans,
    "averageLvrPercent": averageLvrPercent,
    "annualRentalIncome": annualRentalIncome,
    "annualExpenses": annualExpenses,
  };
}
