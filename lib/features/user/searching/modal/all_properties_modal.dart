// To parse this JSON data, do
//
//     final allPropertiesResponse = allPropertiesResponseFromJson(jsonString);

import 'dart:convert';

AllPropertiesResponse allPropertiesResponseFromJson(String str) =>
    AllPropertiesResponse.fromJson(json.decode(str));

String allPropertiesResponseToJson(AllPropertiesResponse data) =>
    json.encode(data.toJson());

class AllPropertiesResponse {
  int? statusCode;
  bool? success;
  String? message;
  AllPropertiesResult? data;
  Stats? stats;

  AllPropertiesResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory AllPropertiesResponse.fromJson(Map<String, dynamic> json) =>
      AllPropertiesResponse(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : AllPropertiesResult.fromJson(json["data"]),
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

class AllPropertiesResult {
  Meta? meta;
  List<Datum>? data;

  AllPropertiesResult({this.meta, this.data});

  factory AllPropertiesResult.fromJson(Map<String, dynamic> json) => AllPropertiesResult(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? price;
  String? address;
  int? beds;
  int? baths;
  String? propertyType;
  String? imageUrl;
  bool? isSaved;
  double? roi;
  GrowthRate? growthRate;

  Datum({
    this.id,
    this.price,
    this.address,
    this.beds,
    this.baths,
    this.propertyType,
    this.imageUrl,
    this.isSaved,
    this.roi,
    this.growthRate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    price: json["price"],
    address: json["address"],
    beds: json["beds"],
    baths: json["baths"],
    propertyType: json["property_type"],
    imageUrl: json["image_url"],
    isSaved: json["is_saved"],
    roi: json["roi"]?.toDouble(),
    growthRate: json["growth_rate"] == null
        ? null
        : GrowthRate.fromJson(json["growth_rate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "address": address,
    "beds": beds,
    "baths": baths,
    "property_type": propertyType,
    "image_url": imageUrl,
    "is_saved": isSaved,
    "roi": roi,
    "growth_rate": growthRate?.toJson(),
  };
}

class GrowthRate {
  double? year1;
  double? year5;
  double? year10;

  GrowthRate({this.year1, this.year5, this.year10});

  factory GrowthRate.fromJson(Map<String, dynamic> json) => GrowthRate(
    year1: json["year_1"]?.toDouble(),
    year5: json["year_5"]?.toDouble(),
    year10: json["year_10"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "year_1": year1,
    "year_5": year5,
    "year_10": year10,
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;

  Meta({this.page, this.limit, this.total});

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(page: json["page"], limit: json["limit"], total: json["total"]);

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
  };
}

class Stats {
  Stats();

  factory Stats.fromJson(Map<String, dynamic> json) => Stats();

  Map<String, dynamic> toJson() => {};
}
