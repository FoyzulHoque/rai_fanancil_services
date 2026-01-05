import 'dart:developer';

class PersonalProfileData {
  final String? id;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? ethnicity;
  final String? gender;
  final String? dob;
  final String? height;
  final String? weight;
  final bool? isPayment;
  final String? sexOrientation;
  final String? education;
  final List<String>? interest;
  final String? distance;
  final List<String>? favoritesFood;
  final List<Photo>? photos;
  final String? about;
  final String? lat;
  final String? long;
  final bool? isCompleteProfile;
  final String? createdAt;
  final String? updatedAt;
  final String? facebook;
  final String? insta;
  final String? tiktok;
  final String? twitter;
  final String? linkedin;

  PersonalProfileData({
    this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.ethnicity,
    this.gender,
    this.dob,
    this.height,
    this.weight,
    this.isPayment,
    this.sexOrientation,
    this.education,
    this.interest,
    this.distance,
    this.favoritesFood,
    this.photos,
    this.about,
    this.lat,
    this.long,
    this.isCompleteProfile,
    this.createdAt,
    this.updatedAt,
    this.facebook,
    this.insta,
    this.tiktok,
    this.twitter,
    this.linkedin,
  });

  factory PersonalProfileData.fromJson(Map<String, dynamic> json) {
    log("Parsing JSON: ${json.toString()}");
    return PersonalProfileData(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      ethnicity: json['ethnicity'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      height: json['hight'] as String?, // Map 'hight' to 'height'
      weight: json['weight'] as String?,
      isPayment: json['isPayment'] as bool?,
      sexOrientation: json['sexOrientation'] as String?,
      education: json['education'] as String?,
      interest: (json['interest'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      distance: json['distance'] as String?,
      favoritesFood: (json['favoritesFood'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e))
          .toList(),
      about: json['about'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      isCompleteProfile: json['isCompleteProfile'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      facebook: json['facebook'] as String?,
      insta: json['instagram'] as String?,
      tiktok: json['tiktok'] as String?,
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'ethnicity': ethnicity,
      'gender': gender,
      'dob': dob,
      'hight': height, // Use 'hight' to match API response
      'weight': weight,
      'isPayment': isPayment,
      'sexOrientation': sexOrientation,
      'education': education,
      'interest': interest,
      'distance': distance,
      'favoritesFood': favoritesFood,
      'photos': photos?.map((e) => e.toJson()).toList(),
      'about': about,
      'lat': lat,
      'long': long,
      'isCompleteProfile': isCompleteProfile,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'facebook': facebook,
      'instagram': insta,
      'tiktok': tiktok,
      'twitter': twitter,
      'linkedin': linkedin,
    };
  }
}

class Photo {
  final String? url;

  Photo({this.url});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
