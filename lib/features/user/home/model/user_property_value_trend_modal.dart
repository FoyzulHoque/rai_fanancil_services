import 'dart:convert';

UserPropertyValueResponse userPropertyValueResponseFromJson(String str) =>
    UserPropertyValueResponse.fromJson(json.decode(str));

String userPropertyValueResponseToJson(UserPropertyValueResponse data) =>
    json.encode(data.toJson());

class UserPropertyValueResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<UserPropertyValueDetum>? data;
  Stats? stats;

  UserPropertyValueResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory UserPropertyValueResponse.fromJson(Map<String, dynamic> json) =>
      UserPropertyValueResponse(
        statusCode: (json["statusCode"] as num?)?.toInt(),
        success: json["success"] as bool?,
        message: json["message"] as String?,
        data: json["data"] == null
            ? <UserPropertyValueDetum>[]
            : List<UserPropertyValueDetum>.from(
          (json["data"] as List).map(
                (x) => UserPropertyValueDetum.fromJson(
                x as Map<String, dynamic>),
          ),
        ),
        stats: json["stats"] == null
            ? null
            : Stats.fromJson(json["stats"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "stats": stats?.toJson() ?? {},
  };
}

class UserPropertyValueDetum {
  String? date;

  /// ✅ API field name is "value"
  double? value;

  UserPropertyValueDetum({this.date, this.value});

  factory UserPropertyValueDetum.fromJson(Map<String, dynamic> json) =>
      UserPropertyValueDetum(
        date: json["date"] as String?,
        value: (json["value"] as num?)?.toDouble() ?? 0.0, // ✅ null-safe
      );

  Map<String, dynamic> toJson() => {
    "date": date,
    "value": value,
  };
}

class Stats {
  Stats();

  factory Stats.fromJson(Map<String, dynamic> json) => Stats();

  Map<String, dynamic> toJson() => {};
}
