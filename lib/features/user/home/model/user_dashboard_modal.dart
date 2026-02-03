// To parse this JSON data, do
//
//     final userDashBoardResponse = userDashBoardResponseFromJson(jsonString);

import 'dart:convert';

UserDashBoardResponse userDashBoardResponseFromJson(String str) =>
    UserDashBoardResponse.fromJson(json.decode(str));

String userDashBoardResponseToJson(UserDashBoardResponse data) =>
    json.encode(data.toJson());

class UserDashBoardResponse {
  int? statusCode;
  bool? success;
  String? message;
  UserDashBoardResult? data;
  Stats? stats;

  UserDashBoardResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory UserDashBoardResponse.fromJson(Map<String, dynamic> json) =>
      UserDashBoardResponse(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserDashBoardResult.fromJson(json["data"]),
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "stats": stats?.toJson(),
  };
}

class UserDashBoardResult {
  int? totalProperties;
  int? totalActiveLoans;
  Comparisons? comparisons;

  UserDashBoardResult({this.totalProperties, this.totalActiveLoans, this.comparisons});

  factory UserDashBoardResult.fromJson(Map<String, dynamic> json) => UserDashBoardResult(
    totalProperties: json["totalProperties"],
    totalActiveLoans: json["totalActiveLoans"],
    comparisons: json["comparisons"] == null
        ? null
        : Comparisons.fromJson(json["comparisons"]),
  );

  Map<String, dynamic> toJson() => {
    "totalProperties": totalProperties,
    "totalActiveLoans": totalActiveLoans,
    "comparisons": comparisons?.toJson(),
  };
}

class Comparisons {
  Cashflow? monthlyCashflow;
  Cashflow? annualCashflow;

  Comparisons({this.monthlyCashflow, this.annualCashflow});

  factory Comparisons.fromJson(Map<String, dynamic> json) => Comparisons(
    monthlyCashflow: json["monthlyCashflow"] == null
        ? null
        : Cashflow.fromJson(json["monthlyCashflow"]),
    annualCashflow: json["annualCashflow"] == null
        ? null
        : Cashflow.fromJson(json["annualCashflow"]),
  );

  Map<String, dynamic> toJson() => {
    "monthlyCashflow": monthlyCashflow?.toJson(),
    "annualCashflow": annualCashflow?.toJson(),
  };
}

class Cashflow {
  double? value;
  double? changePercentage;
  bool? isIncrease;

  Cashflow({this.value, this.changePercentage, this.isIncrease});

  factory Cashflow.fromJson(Map<String, dynamic> json) => Cashflow(
    value: json["value"]?.toDouble(),
    changePercentage: json["changePercentage"]?.toDouble(),
    isIncrease: json["isIncrease"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "changePercentage": changePercentage,
    "isIncrease": isIncrease,
  };
}

class Stats {
  Stats();

  factory Stats.fromJson(Map<String, dynamic> json) => Stats();

  Map<String, dynamic> toJson() => {};
}
