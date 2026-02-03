// ============================
// ✅ login_controller.dart
// ============================
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';

import '../../../auth/signup/screens/signup_otp_screen.dart';
import '../../../user/financial data collection/view/set_up_your_financial_profile.dart';
import '../../../user/user navbar/user_navbar_screen.dart';

class LogInController extends GetxController {
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var role = ''.obs;

  // ✅ loading state for button / screen
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRememberMeStateOnly();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // ✅ Only load rememberMe checkbox state (email/pass will be loaded in screen)
  Future<void> _loadRememberMeStateOnly() async {
    rememberMe.value = await SharedPreferencesHelper.getRememberMe() ?? false;
  }

  // ✅ Used by LoginScreen to prefill its own controllers (no duplicate controllers now)
  Future<void> loadRememberMeStateForExternalFields({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    rememberMe.value = await SharedPreferencesHelper.getRememberMe() ?? false;

    if (rememberMe.value) {
      final savedEmail = await SharedPreferencesHelper.getEmail();
      final savedPassword = await SharedPreferencesHelper.getPassword();

      if (savedEmail != null) emailController.text = savedEmail;
      if (savedPassword != null) passwordController.text = savedPassword;
    }
  }

  Future<void> setRememberMe(bool value) async {
    rememberMe.value = value;
    await SharedPreferencesHelper.saveRememberMe(value);
  }

  // ✅ MAIN LOGIN (no internal text controllers; takes values from UI)
  Future<bool> onSignIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    final e = email.trim();
    final p = password.trim();

    if (e.isEmpty) {
      Get.snackbar("Error", "Please enter an email address.");
      return false;
    }
    if (p.isEmpty) {
      Get.snackbar("Error", "Please enter a password.");
      return false;
    }

    try {
      isLoading.value = true;

      final url = Uri.parse("${Urls.baseUrl}/auth/login");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": e, "password": p}),
      );

      if (response.statusCode != 200) {
        Get.snackbar("Error", "An error occurred: ${response.statusCode}");
        return false;
      }

      Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (_) {
        Get.snackbar("Error", "Invalid server response.");
        return false;
      }

      final bool success = responseData["success"] == true;
      if (!success) {
        Get.snackbar("Error", responseData["message"] ?? "Invalid credentials.");
        return false;
      }

      final data = responseData["data"] ?? {};

      final String token = (data["token"] ?? "").toString();
      final String userId = (data["id"] ?? data["userId"] ?? "").toString();
      final String userRole = (data["role"] ?? "USER").toString();

      if (token.isEmpty) {
        Get.snackbar("Error", "Invalid token received.");
        return false;
      }

      // ✅ Save token & role
      await SharedPreferencesHelper.saveToken(token);
      await SharedPreferencesHelper.saveUserRole(userRole);
      if (userId.isNotEmpty) {
        await SharedPreferencesHelper.saveUserId(userId);
      }

      // ✅ Remember Me
      if (remember) {
        await SharedPreferencesHelper.saveRememberMe(true);
        await SharedPreferencesHelper.saveEmail(e);
        await SharedPreferencesHelper.savePassword(p);
      } else {
        await SharedPreferencesHelper.saveRememberMe(false);
      }

      // ✅ Conditions
      final bool emailVerified = data["emailVerification"] == true;
      final bool isFinancialProfileComplete =
          data["isFinancialProfileComplete"] == true;

      // ✅ Navigate
      if (!emailVerified) {
        Get.snackbar(
          "Email not verified",
          "Please verify your email",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(() => SignupOtpScreens());
        return false;
      }

      if (!isFinancialProfileComplete) {
        Get.snackbar(
          "Profile incomplete",
          "Please complete your financial profile",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(() => SetUpYourFinancialProfile());
        return false;
      }

      Get.offAll(() => UserBottomNavbar());
      Get.snackbar("Success", "Logged in successfully.");
      return true;
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred.");
      debugPrint("Login error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
