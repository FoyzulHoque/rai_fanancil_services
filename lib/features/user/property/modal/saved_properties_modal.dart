// To parse this JSON data, do
//
//     final userSavedPropertiesResponse = userSavedPropertiesResponseFromJson(jsonString);

import 'dart:convert';

UserSavedPropertiesResponse userSavedPropertiesResponseFromJson(String str) =>
    UserSavedPropertiesResponse.fromJson(json.decode(str));

String userSavedPropertiesResponseToJson(UserSavedPropertiesResponse data) =>
    json.encode(data.toJson());

class UserSavedPropertiesResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<UserSavedPropertiesDetum>? data;
  Stats? stats;

  UserSavedPropertiesResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.stats,
  });

  factory UserSavedPropertiesResponse.fromJson(Map<String, dynamic> json) =>
      UserSavedPropertiesResponse(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserSavedPropertiesDetum>.from(json["data"]!.map((x) => UserSavedPropertiesDetum.fromJson(x))),
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

class UserSavedPropertiesDetum {
  String? id;
  String? userId;
  String? propertyListingId;
  DateTime? createdAt;
  PropertyListing? propertyListing;

  UserSavedPropertiesDetum({
    this.id,
    this.userId,
    this.propertyListingId,
    this.createdAt,
    this.propertyListing,
  });

  factory UserSavedPropertiesDetum.fromJson(Map<String, dynamic> json) => UserSavedPropertiesDetum(
    id: json["id"],
    userId: json["userId"],
    propertyListingId: json["propertyListingId"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    propertyListing: json["propertyListing"] == null
        ? null
        : PropertyListing.fromJson(json["propertyListing"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "propertyListingId": propertyListingId,
    "createdAt": createdAt?.toIso8601String(),
    "propertyListing": propertyListing?.toJson(),
  };
}

class PropertyListing {
  String? id;
  String? title;
  String? address;
  int? price;
  String? type;
  int? bedrooms;
  int? bathrooms;
  int? carSpaces;
  int? landSize;
  String? description;
  List<String>? images;
  String? suburb;
  String? state;
  String? postcode;
  DateTime? createdAt;
  DateTime? updatedAt;

  PropertyListing({
    this.id,
    this.title,
    this.address,
    this.price,
    this.type,
    this.bedrooms,
    this.bathrooms,
    this.carSpaces,
    this.landSize,
    this.description,
    this.images,
    this.suburb,
    this.state,
    this.postcode,
    this.createdAt,
    this.updatedAt,
  });

  factory PropertyListing.fromJson(Map<String, dynamic> json) =>
      PropertyListing(
        id: json["id"],
        title: json["title"],
        address: json["address"],
        price: json["price"],
        type: json["type"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        carSpaces: json["carSpaces"],
        landSize: json["landSize"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        suburb: json["suburb"],
        state: json["state"],
        postcode: json["postcode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "address": address,
    "price": price,
    "type": type,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "carSpaces": carSpaces,
    "landSize": landSize,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "suburb": suburb,
    "state": state,
    "postcode": postcode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Stats {
  Stats();

  factory Stats.fromJson(Map<String, dynamic> json) => Stats();

  Map<String, dynamic> toJson() => {};
}
