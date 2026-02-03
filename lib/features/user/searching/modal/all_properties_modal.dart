import 'dart:convert';

// JSON parsing helpers
AllPropertiesResponse allPropertiesResponseFromJson(String str) =>
    AllPropertiesResponse.fromJson(json.decode(str));

String allPropertiesResponseToJson(AllPropertiesResponse data) =>
    json.encode(data.toJson());

// Top-level response
class AllPropertiesResponse {
  num? statusCode;
  bool? success;
  String? message;
  AllPropertiesData? data;
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
        data: json["data"] == null
            ? null
            : AllPropertiesData.fromJson(json["data"]),
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

// Data container (contains meta and list of properties)
class AllPropertiesData {
  Meta? meta;
  List<AllPropertiesDatum>? data;

  AllPropertiesData({this.meta, this.data});

  factory AllPropertiesData.fromJson(Map<String, dynamic> json) =>
      AllPropertiesData(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<AllPropertiesDatum>.from(
                json["data"].map((x) => AllPropertiesDatum.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

// Single property
class AllPropertiesDatum {
  num? id;
  num? price;
  String? address;
  num? beds;
  num? baths;
  String? propertyType;
  String? imageUrl;
  bool? isSaved;
  double? roi;
  GrowthRate? growthRate;

  AllPropertiesDatum({
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

  factory AllPropertiesDatum.fromJson(Map<String, dynamic> json) =>
      AllPropertiesDatum(
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

// Growth rate object
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

// Meta info
class Meta {
  num? page;
  num? limit;
  num? total;

  Meta({this.page, this.limit, this.total});

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(page: json["page"], limit: json["limit"], total: json["total"]);

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
  };
}

// Stats (empty in your example)
class Stats {
  Stats();

  factory Stats.fromJson(Map<String, dynamic> json) => Stats();

  Map<String, dynamic> toJson() => {};
}
