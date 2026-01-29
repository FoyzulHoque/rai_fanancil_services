import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';
  static const String _isLoginKey = 'isLogin';
  static const String _roleKey = 'role';
  static const String _userIdKey = 'userId';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
  static const _rememberMeKey = 'rememberMe';

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setBool(_isLoginKey, true);
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Save email and password
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_emailKey, email);
  }

  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_passwordKey, password);
  }

  // Retrieve saved email and password
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }

  // Save the 'Remember Me' state
  static Future<void> saveRememberMe(bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_rememberMeKey, rememberMe);
  }

  // Retrieve 'Remember Me' state
  static Future<bool?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey);
  }

  // Clear all stored data (e.g., token, login status, role, etc.)
  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);  // Clear the token
    await prefs.remove(_isLoginKey);  // Clear the login status
    await prefs.remove(_roleKey);  // Clear the role
    await prefs.remove(_userIdKey);
  }

  // Check if the user is logged in
  static Future<bool?> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoginKey) ?? false;
  }
}
