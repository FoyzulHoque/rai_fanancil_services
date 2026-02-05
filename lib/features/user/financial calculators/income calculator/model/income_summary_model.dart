import 'dart:convert';

IncomeSummaryResponse incomeSummaryResponseFromJson(String str) =>
    IncomeSummaryResponse.fromJson(json.decode(str));

String incomeSummaryResponseToJson(IncomeSummaryResponse data) =>
    json.encode(data.toJson());

class IncomeSummaryResponse {
  int statusCode;
  bool success;
  String message;
  IncomeSummaryData data;
  Map<String, dynamic> stats;

  IncomeSummaryResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory IncomeSummaryResponse.fromJson(Map<String, dynamic> json) {
    return IncomeSummaryResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      success: json['success'] == true,
      message: (json['message'] ?? '').toString(),
      data: IncomeSummaryData.fromJson(json['data'] as Map<String, dynamic>),
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

class IncomeSummaryData {
  double netAnnualIncome;
  double grossAnnualIncome;
  double taxRatePercent;
  TaxBreakdown taxBreakdown;
  PotentialTaxPayable potentialTaxPayable;
  IncomeSources incomeSources;
  IncomeMeta meta;

  IncomeSummaryData({
    required this.netAnnualIncome,
    required this.grossAnnualIncome,
    required this.taxRatePercent,
    required this.taxBreakdown,
    required this.potentialTaxPayable,
    required this.incomeSources,
    required this.meta,
  });

  factory IncomeSummaryData.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return IncomeSummaryData(
      netAnnualIncome: d(json['netAnnualIncome']),
      grossAnnualIncome: d(json['grossAnnualIncome']),
      taxRatePercent: d(json['taxRatePercent']),
      taxBreakdown: TaxBreakdown.fromJson(json['taxBreakdown']),
      potentialTaxPayable: PotentialTaxPayable.fromJson(json['potentialTaxPayable']),
      incomeSources: IncomeSources.fromJson(json['incomeSources']),
      meta: IncomeMeta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "netAnnualIncome": netAnnualIncome,
      "grossAnnualIncome": grossAnnualIncome,
      "taxRatePercent": taxRatePercent,
      "taxBreakdown": taxBreakdown.toJson(),
      "potentialTaxPayable": potentialTaxPayable.toJson(),
      "incomeSources": incomeSources.toJson(),
      "meta": meta.toJson(),
    };
  }
}

class TaxBreakdown {
  double incomeTax;
  double medicareLevy;
  double totalTax;

  TaxBreakdown({
    required this.incomeTax,
    required this.medicareLevy,
    required this.totalTax,
  });

  factory TaxBreakdown.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return TaxBreakdown(
      incomeTax: d(json['incomeTax']),
      medicareLevy: d(json['medicareLevy']),
      totalTax: d(json['totalTax']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "incomeTax": incomeTax,
      "medicareLevy": medicareLevy,
      "totalTax": totalTax,
    };
  }
}

class PotentialTaxPayable {
  double totalPayable;
  double incomeTax;
  double medicareLevy;
  double effectiveTaxRate;

  PotentialTaxPayable({
    required this.totalPayable,
    required this.incomeTax,
    required this.medicareLevy,
    required this.effectiveTaxRate,
  });

  factory PotentialTaxPayable.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return PotentialTaxPayable(
      totalPayable: d(json['totalPayable']),
      incomeTax: d(json['incomeTax']),
      medicareLevy: d(json['medicareLevy']),
      effectiveTaxRate: d(json['effectiveTaxRate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalPayable": totalPayable,
      "incomeTax": incomeTax,
      "medicareLevy": medicareLevy,
      "effectiveTaxRate": effectiveTaxRate,
    };
  }
}

class IncomeSources {
  double employmentIncome;
  double rentalIncome;
  double businessIncome;
  double otherIncome;

  IncomeSources({
    required this.employmentIncome,
    required this.rentalIncome,
    required this.businessIncome,
    required this.otherIncome,
  });

  factory IncomeSources.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v as num).toDouble();

    return IncomeSources(
      employmentIncome: d(json['employmentIncome']),
      rentalIncome: d(json['rentalIncome']),
      businessIncome: d(json['businessIncome']),
      otherIncome: d(json['otherIncome']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employmentIncome": employmentIncome,
      "rentalIncome": rentalIncome,
      "businessIncome": businessIncome,
      "otherIncome": otherIncome,
    };
  }
}

class IncomeMeta {
  String incomeFrequency;
  String taxRegion;

  IncomeMeta({
    required this.incomeFrequency,
    required this.taxRegion,
  });

  factory IncomeMeta.fromJson(Map<String, dynamic> json) {
    return IncomeMeta(
      incomeFrequency: (json['incomeFrequency'] ?? '').toString(),
      taxRegion: (json['taxRegion'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "incomeFrequency": incomeFrequency,
      "taxRegion": taxRegion,
    };
  }
}
