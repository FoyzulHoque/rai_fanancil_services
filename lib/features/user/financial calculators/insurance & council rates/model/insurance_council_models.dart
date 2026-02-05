import 'dart:convert';

InsuranceCouncilResponse insuranceCouncilResponseFromJson(String str) =>
    InsuranceCouncilResponse.fromJson(json.decode(str) as Map<String, dynamic>?);

String insuranceCouncilResponseToJson(InsuranceCouncilResponse data) =>
    json.encode(data.toJson());

class InsuranceCouncilResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final InsuranceCouncilData? data;
  final Map<String, dynamic>? stats;

  const InsuranceCouncilResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory InsuranceCouncilResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const InsuranceCouncilResponse();

    return InsuranceCouncilResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: InsuranceCouncilData.fromJson(json['data'] as Map<String, dynamic>?),
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

class InsuranceCouncilData {
  final double? totalAnnualCosts;
  final CostDistribution? costDistribution;
  final DetailedBreakdown? detailedBreakdown;

  const InsuranceCouncilData({
    this.totalAnnualCosts,
    this.costDistribution,
    this.detailedBreakdown,
  });

  factory InsuranceCouncilData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const InsuranceCouncilData();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return InsuranceCouncilData(
      totalAnnualCosts: d(json['totalAnnualCosts']),
      costDistribution: CostDistribution.fromJson(
          json['costDistribution'] as Map<String, dynamic>?),
      detailedBreakdown: DetailedBreakdown.fromJson(
          json['detailedBreakdown'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalAnnualCosts": totalAnnualCosts,
    "costDistribution": costDistribution?.toJson(),
    "detailedBreakdown": detailedBreakdown?.toJson(),
  };
}

class CostDistribution {
  final double? buildingInsurance;
  final double? councilRates;
  final double? waterCharges;
  final double? contentsInsurance;
  final double? landlordInsurance;

  const CostDistribution({
    this.buildingInsurance,
    this.councilRates,
    this.waterCharges,
    this.contentsInsurance,
    this.landlordInsurance,
  });

  factory CostDistribution.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CostDistribution();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return CostDistribution(
      buildingInsurance: d(json['buildingInsurance']),
      councilRates: d(json['councilRates']),
      waterCharges: d(json['waterCharges']),
      contentsInsurance: d(json['contentsInsurance']),
      landlordInsurance: d(json['landlordInsurance']),
    );
  }

  Map<String, dynamic> toJson() => {
    "buildingInsurance": buildingInsurance,
    "councilRates": councilRates,
    "waterCharges": waterCharges,
    "contentsInsurance": contentsInsurance,
    "landlordInsurance": landlordInsurance,
  };
}

class DetailedBreakdown {
  final double? annualTotal;
  final double? monthlyPayment;
  final double? weeklyPayment;
  final double? dailyCost;

  const DetailedBreakdown({
    this.annualTotal,
    this.monthlyPayment,
    this.weeklyPayment,
    this.dailyCost,
  });

  factory DetailedBreakdown.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DetailedBreakdown();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return DetailedBreakdown(
      annualTotal: d(json['annualTotal']),
      monthlyPayment: d(json['monthlyPayment']),
      weeklyPayment: d(json['weeklyPayment']),
      dailyCost: d(json['dailyCost']),
    );
  }

  Map<String, dynamic> toJson() => {
    "annualTotal": annualTotal,
    "monthlyPayment": monthlyPayment,
    "weeklyPayment": weeklyPayment,
    "dailyCost": dailyCost,
  };
}
