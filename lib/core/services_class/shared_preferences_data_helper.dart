
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/model/user_model.dart';


class AuthController extends GetxController{
  static String? accessToken;
  static UserModel? userModel;
  static final Rx<UserModel?> userModelRx = Rx<UserModel?>(null);
  static final RxBool isLoggedInRx = false.obs;
  static String? accessKey;
  static const String _isLoginKey = 'isLogin';
  static const String _userIdKey = 'userId';
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  /// Save token + user model
  static Future<void> setUserData(String token, UserModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_userDataKey, jsonEncode(model.toJson()));

    // Save RiderModel user ID
    if (model.id != null && model.id!.isNotEmpty) {
      await prefs.setString(_userIdKey, model.id!);
    }
    userModelRx.value = model;
    accessToken = token;
    userModel = model;
  }
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setBool(_isLoginKey, true);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }
  /// Load user data from local storage
  static Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_accessTokenKey);
    final userData = prefs.getString(_userDataKey);

    if (userData != null) {
      accessToken = token;
      userModel = UserModel.fromJson(jsonDecode(userData));
      userModelRx.value = userModel;
    }
  }

  /// Save Rider user ID separately (optional)
  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  /// Get Rider user ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }



  /// Check login status
  static Future<bool> isUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_accessTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  /// Logout → clear all saved data
  static Future<void> dataClear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    accessToken = null;
    userModel = null;
    accessKey = null;
  }



  /// Clear only User ID

  static Future<void> idClear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.remove(_userIdKey);
    accessKey = null;
  }
}
