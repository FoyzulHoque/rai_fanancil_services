// To parse this JSON data, do
//
//     final userCashFlowResponse = userCashFlowResponseFromJson(jsonString);

import 'dart:convert';

UserCashFlowResponse userCashFlowResponseFromJson(String str) =>
    UserCashFlowResponse.fromJson(json.decode(str));

String userCashFlowResponseToJson(UserCashFlowResponse data) =>
    json.encode(data.toJson());

class UserCashFlowResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<Datum>? data;
  Stats? stats;

  UserCashFlowResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory UserCashFlowResponse.fromJson(Map<String, dynamic> json) =>
      UserCashFlowResponse(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "stats": stats?.toJson(),
  };
}

class Datum {
  String? date;
  int? monthlyCashflow;
  int? annualCashflow;

  Datum({this.date, this.monthlyCashflow, this.annualCashflow});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    monthlyCashflow: json["monthlyCashflow"],
    annualCashflow: json["annualCashflow"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "monthlyCashflow": monthlyCashflow,
    "annualCashflow": annualCashflow,
  };
}

class Stats {
  Stats();

  factory Stats.fromJson(Map<String, dynamic> json) => Stats();

  Map<String, dynamic> toJson() => {};
}
