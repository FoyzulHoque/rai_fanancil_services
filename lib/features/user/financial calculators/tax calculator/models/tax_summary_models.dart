import 'dart:convert';

TaxSummaryResponse taxSummaryResponseFromJson(String str) =>
    TaxSummaryResponse.fromJson(json.decode(str) as Map<String, dynamic>?);

String taxSummaryResponseToJson(TaxSummaryResponse data) =>
    json.encode(data.toJson());

class TaxSummaryResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final TaxSummaryData? data;
  final Map<String, dynamic>? stats;

  const TaxSummaryResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory TaxSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TaxSummaryResponse();
    return TaxSummaryResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: TaxSummaryData.fromJson(json['data'] as Map<String, dynamic>?),
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

class TaxSummaryData {
  final double? totalTaxPayable;
  final double? netProfitAfterTax;

  final TaxBreakdown? taxBreakdown;
  final IncomeTaxOverview? incomeTaxOverview;
  final DetailedBreakdown? detailedBreakdown;
  final NegativeGearingBenefit? negativeGearingBenefit;

  const TaxSummaryData({
    this.totalTaxPayable,
    this.netProfitAfterTax,
    this.taxBreakdown,
    this.incomeTaxOverview,
    this.detailedBreakdown,
    this.negativeGearingBenefit,
  });

  factory TaxSummaryData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TaxSummaryData();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return TaxSummaryData(
      totalTaxPayable: d(json['totalTaxPayable']),
      netProfitAfterTax: d(json['netProfitAfterTax']),
      taxBreakdown:
      TaxBreakdown.fromJson(json['taxBreakdown'] as Map<String, dynamic>?),
      incomeTaxOverview: IncomeTaxOverview.fromJson(
          json['incomeTaxOverview'] as Map<String, dynamic>?),
      detailedBreakdown: DetailedBreakdown.fromJson(
          json['detailedBreakdown'] as Map<String, dynamic>?),
      negativeGearingBenefit: NegativeGearingBenefit.fromJson(
          json['negativeGearingBenefit'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalTaxPayable": totalTaxPayable,
    "netProfitAfterTax": netProfitAfterTax,
    "taxBreakdown": taxBreakdown?.toJson(),
    "incomeTaxOverview": incomeTaxOverview?.toJson(),
    "detailedBreakdown": detailedBreakdown?.toJson(),
    "negativeGearingBenefit": negativeGearingBenefit?.toJson(),
  };
}

class TaxBreakdown {
  final double? incomeTax;
  final double? investmentTax;
  final double? landTax;

  const TaxBreakdown({this.incomeTax, this.investmentTax, this.landTax});

  factory TaxBreakdown.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const TaxBreakdown();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return TaxBreakdown(
      incomeTax: d(json['incomeTax']),
      investmentTax: d(json['investmentTax']),
      landTax: d(json['landTax']),
    );
  }

  Map<String, dynamic> toJson() => {
    "incomeTax": incomeTax,
    "investmentTax": investmentTax,
    "landTax": landTax,
  };
}

class IncomeTaxOverview {
  final double? grossIncome;
  final double? deductions;
  final double? taxableIncome;
  final double? taxPayable;
  final double? netAfterTax;

  const IncomeTaxOverview({
    this.grossIncome,
    this.deductions,
    this.taxableIncome,
    this.taxPayable,
    this.netAfterTax,
  });

  factory IncomeTaxOverview.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const IncomeTaxOverview();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return IncomeTaxOverview(
      grossIncome: d(json['grossIncome']),
      deductions: d(json['deductions']),
      taxableIncome: d(json['taxableIncome']),
      taxPayable: d(json['taxPayable']),
      netAfterTax: d(json['netAfterTax']),
    );
  }

  Map<String, dynamic> toJson() => {
    "grossIncome": grossIncome,
    "deductions": deductions,
    "taxableIncome": taxableIncome,
    "taxPayable": taxPayable,
    "netAfterTax": netAfterTax,
  };
}

class DetailedBreakdown {
  final double? grossIncome;
  final double? deductibleExpenses; // API sends negative already
  final double? taxableIncome;
  final double? taxRateApplied;
  final double? finalPayableAmount;

  const DetailedBreakdown({
    this.grossIncome,
    this.deductibleExpenses,
    this.taxableIncome,
    this.taxRateApplied,
    this.finalPayableAmount,
  });

  factory DetailedBreakdown.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DetailedBreakdown();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return DetailedBreakdown(
      grossIncome: d(json['grossIncome']),
      deductibleExpenses: d(json['deductibleExpenses']),
      taxableIncome: d(json['taxableIncome']),
      taxRateApplied: d(json['taxRateApplied']),
      finalPayableAmount: d(json['finalPayableAmount']),
    );
  }

  Map<String, dynamic> toJson() => {
    "grossIncome": grossIncome,
    "deductibleExpenses": deductibleExpenses,
    "taxableIncome": taxableIncome,
    "taxRateApplied": taxRateApplied,
    "finalPayableAmount": finalPayableAmount,
  };
}

class NegativeGearingBenefit {
  final double? rentalIncome;
  final double? propertyExpenses; // API sends negative already
  final double? depreciation; // API sends negative already
  final double? propertyLoss; // API sends negative already
  final double? taxBenefit;

  const NegativeGearingBenefit({
    this.rentalIncome,
    this.propertyExpenses,
    this.depreciation,
    this.propertyLoss,
    this.taxBenefit,
  });

  factory NegativeGearingBenefit.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NegativeGearingBenefit();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return NegativeGearingBenefit(
      rentalIncome: d(json['rentalIncome']),
      propertyExpenses: d(json['propertyExpenses']),
      depreciation: d(json['depreciation']),
      propertyLoss: d(json['propertyLoss']),
      taxBenefit: d(json['taxBenefit']),
    );
  }

  Map<String, dynamic> toJson() => {
    "rentalIncome": rentalIncome,
    "propertyExpenses": propertyExpenses,
    "depreciation": depreciation,
    "propertyLoss": propertyLoss,
    "taxBenefit": taxBenefit,
  };
}
