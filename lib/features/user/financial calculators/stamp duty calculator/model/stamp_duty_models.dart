import 'dart:convert';

StampDutyResponse stampDutyResponseFromJson(String str) =>
    StampDutyResponse.fromJson(json.decode(str) as Map<String, dynamic>?);

String stampDutyResponseToJson(StampDutyResponse data) =>
    json.encode(data.toJson());

class StampDutyResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final StampDutyData? data;
  final Map<String, dynamic>? stats;

  const StampDutyResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory StampDutyResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const StampDutyResponse();

    return StampDutyResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: StampDutyData.fromJson(json['data'] as Map<String, dynamic>?),
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

class StampDutyData {
  final double? totalStampDuty;
  final DutyBreakdown? dutyBreakdown;
  final DetailedBreakdown? detailedBreakdown;

  const StampDutyData({
    this.totalStampDuty,
    this.dutyBreakdown,
    this.detailedBreakdown,
  });

  factory StampDutyData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const StampDutyData();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return StampDutyData(
      totalStampDuty: d(json['totalStampDuty']),
      dutyBreakdown:
      DutyBreakdown.fromJson(json['dutyBreakdown'] as Map<String, dynamic>?),
      detailedBreakdown: DetailedBreakdown.fromJson(
          json['detailedBreakdown'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalStampDuty": totalStampDuty,
    "dutyBreakdown": dutyBreakdown?.toJson(),
    "detailedBreakdown": detailedBreakdown?.toJson(),
  };
}

class DutyBreakdown {
  final double? stampDuty;
  final double? registrationFees;
  final double? transferFees;

  const DutyBreakdown({
    this.stampDuty,
    this.registrationFees,
    this.transferFees,
  });

  factory DutyBreakdown.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DutyBreakdown();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return DutyBreakdown(
      stampDuty: d(json['stampDuty']),
      registrationFees: d(json['registrationFees']),
      transferFees: d(json['transferFees']),
    );
  }

  Map<String, dynamic> toJson() => {
    "stampDuty": stampDuty,
    "registrationFees": registrationFees,
    "transferFees": transferFees,
  };
}

class DetailedBreakdown {
  final double? stampDutyAmount;
  final double? registrationFees;
  final double? transferFees;
  final double? totalTaxesAndFees;

  const DetailedBreakdown({
    this.stampDutyAmount,
    this.registrationFees,
    this.transferFees,
    this.totalTaxesAndFees,
  });

  factory DetailedBreakdown.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DetailedBreakdown();

    double? d(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse("${v ?? ''}");

    return DetailedBreakdown(
      stampDutyAmount: d(json['stampDutyAmount']),
      registrationFees: d(json['registrationFees']),
      transferFees: d(json['transferFees']),
      totalTaxesAndFees: d(json['totalTaxesAndFees']),
    );
  }

  Map<String, dynamic> toJson() => {
    "stampDutyAmount": stampDutyAmount,
    "registrationFees": registrationFees,
    "transferFees": transferFees,
    "totalTaxesAndFees": totalTaxesAndFees,
  };
}
