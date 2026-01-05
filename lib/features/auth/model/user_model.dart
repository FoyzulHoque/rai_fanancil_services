class UserModel {
  String? id;
  String? email;
  String? profileImage;
  String? password;
  String? gender;
  String? phone;
  String? location;
  String? firstName;
  String? lastName;
  String? role;

  UserModel({
    this.id,
    this.email,
    this.profileImage,
    this.password,
    this.gender,
    this.phone,
    this.location,
    this.firstName,
    this.lastName,
    this.role,
  });

  /// Factory: Convert JSON → UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      profileImage: json['profileImage'],
      password: json['password'],
      gender: json['gender'],
      phone: json['phone'],
      location: json['location'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
    );
  }

  /// Convert UserModel → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'profileImage': profileImage,
      'password': password,
      'gender': gender,
      'phone': phone,
      'location': location,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    };
  }
}
