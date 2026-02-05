import 'dart:convert';

SuburbProfileResponse suburbProfileResponseFromJson(String str) =>
    SuburbProfileResponse.fromJson(json.decode(str) as Map<String, dynamic>?);

String suburbProfileResponseToJson(SuburbProfileResponse data) =>
    json.encode(data.toJson());

class SuburbProfileResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final SuburbProfileData? data;
  final Map<String, dynamic>? stats;

  const SuburbProfileResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory SuburbProfileResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SuburbProfileResponse();
    return SuburbProfileResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: SuburbProfileData.fromJson(json['data'] as Map<String, dynamic>?),
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

class SuburbProfileData {
  final SuburbMetrics? suburbMetrics;
  final MarketPerformance? marketPerformance;
  final LiveabilityRisk? liveabilityRisk;

  const SuburbProfileData({
    this.suburbMetrics,
    this.marketPerformance,
    this.liveabilityRisk,
  });

  factory SuburbProfileData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SuburbProfileData();
    return SuburbProfileData(
      suburbMetrics:
      SuburbMetrics.fromJson(json['suburbMetrics'] as Map<String, dynamic>?),
      marketPerformance: MarketPerformance.fromJson(
          json['marketPerformance'] as Map<String, dynamic>?),
      liveabilityRisk: LiveabilityRisk.fromJson(
          json['liveabilityRisk'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "suburbMetrics": suburbMetrics?.toJson(),
    "marketPerformance": marketPerformance?.toJson(),
    "liveabilityRisk": liveabilityRisk?.toJson(),
  };
}

class SuburbMetrics {
  final double? medianPrice;
  final double? rentalYield;
  final double? growth10Y;

  const SuburbMetrics({this.medianPrice, this.rentalYield, this.growth10Y});

  factory SuburbMetrics.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SuburbMetrics();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return SuburbMetrics(
      medianPrice: d(json['medianPrice']),
      rentalYield: d(json['rentalYield']),
      growth10Y: d(json['growth10Y']),
    );
  }

  Map<String, dynamic> toJson() => {
    "medianPrice": medianPrice,
    "rentalYield": rentalYield,
    "growth10Y": growth10Y,
  };
}

class MarketPerformance {
  final List<YearValue> fiveYear;
  final List<YearValue> tenYear;

  const MarketPerformance({this.fiveYear = const [], this.tenYear = const []});

  factory MarketPerformance.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const MarketPerformance();

    List<YearValue> parseList(dynamic v) {
      final list = (v is List) ? v : const [];
      return list
          .map((e) => YearValue.fromJson(e as Map<String, dynamic>?))
          .toList();
    }

    return MarketPerformance(
      fiveYear: parseList(json['fiveYear']),
      tenYear: parseList(json['tenYear']),
    );
  }

  Map<String, dynamic> toJson() => {
    "fiveYear": fiveYear.map((e) => e.toJson()).toList(),
    "tenYear": tenYear.map((e) => e.toJson()).toList(),
  };
}

class YearValue {
  final int? year;
  final double? value;

  const YearValue({this.year, this.value});

  factory YearValue.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const YearValue();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return YearValue(
      year: (json['year'] as num?)?.toInt(),
      value: d(json['value']),
    );
  }

  Map<String, dynamic> toJson() => {
    "year": year,
    "value": value,
  };
}

class LiveabilityRisk {
  final String? schoolRanking;
  final String? crimeLevel;
  final String? infrastructureSpend;

  const LiveabilityRisk({
    this.schoolRanking,
    this.crimeLevel,
    this.infrastructureSpend,
  });

  factory LiveabilityRisk.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LiveabilityRisk();
    return LiveabilityRisk(
      schoolRanking: json['schoolRanking']?.toString(),
      crimeLevel: json['crimeLevel']?.toString(),
      infrastructureSpend: json['infrastructureSpend']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "schoolRanking": schoolRanking,
    "crimeLevel": crimeLevel,
    "infrastructureSpend": infrastructureSpend,
  };
}
