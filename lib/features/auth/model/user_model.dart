class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? dob; // empty string in your example → keep as String?
  final String? location;
  final String? phone;
  final String? email;
  final String? profileImage;
  final String? fcmToken;
  final String? role;
  final String? gender;
  final int? otp; // appears as number in JSON
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? onBoarding;
  final bool? emailVerification;
  final DateTime? otpExpiresAt;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.dob,
    this.location,
    this.phone,
    this.email,
    this.profileImage,
    this.fcmToken,
    this.role,
    this.gender,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.onBoarding,
    this.emailVerification,
    this.otpExpiresAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dob: json['dob'] as String?,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      fcmToken: json['fcmToken'] as String?,
      role: json['role'] as String?,
      gender: json['gender'] as String?,
      otp: json['otp'] != null ? json['otp'] as int : null,
      createdAt: _tryParseDateTime(json['createdAt']),
      updatedAt: _tryParseDateTime(json['updatedAt']),
      onBoarding: json['onBoarding'] as bool?,
      emailVerification: json['emailVerification'] as bool?,
      otpExpiresAt: _tryParseDateTime(json['otpExpiresAt']),
    );
  }

  static DateTime? _tryParseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'location': location,
      'phone': phone,
      'email': email,
      'profileImage': profileImage,
      'fcmToken': fcmToken,
      'role': role,
      'gender': gender,
      'otp': otp,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'onBoarding': onBoarding,
      'emailVerification': emailVerification,
      'otpExpiresAt': otpExpiresAt?.toIso8601String(),
    };
  }

  // Optional: nice string representation for debugging
  @override
  String toString() {
    return 'UserModel(id: $id, name: $firstName $lastName, email: $email, role: $role, verified: $emailVerification)';
  }
}
