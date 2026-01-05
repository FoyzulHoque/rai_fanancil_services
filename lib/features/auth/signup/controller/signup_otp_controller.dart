// features/auth/controllers/signup_otp_controller.dart

import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../text editing controller/custom_text_editing_controller.dart';

class SignupOtpController extends GetxController {
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 60.obs;
  final RxBool canResend = false.obs;

  final CustomTextEditingController textCtrl = Get.find<CustomTextEditingController>();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    secondsRemaining.value = 60;
    canResend.value = false;
    
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

  Future<bool> verifySignupOtp() async {
    isLoading.value = true;
    _errorMessage = null;
    update();
    
    // Get email from the signup form
    final email = textCtrl.emailController.text.trim();
    
    // Build OTP from controllers
    final String otpText = textCtrl.otpControllersList
        .map((controller) => controller.text.trim())
        .join('');

    developer.log("================== VERIFY OTP API CALL ==================", name: 'SignupOtpController');
    developer.log("Email: $email", name: 'SignupOtpController');
    developer.log("OTP: $otpText", name: 'SignupOtpController');
    developer.log("OTP Length: ${otpText.length}", name: 'SignupOtpController');

    // Validation
    if (email.isEmpty) {
      _errorMessage = "Email is missing.";
      isLoading.value = false;
      update();
      developer.log("Validation failed: Email is empty", name: 'SignupOtpController');
      return false;
    }

    if (otpText.isEmpty || otpText.length != 4 || !RegExp(r'^\d{4}$').hasMatch(otpText)) {
      // Get.snackbar(
      //   "Error", 
      //   "Please enter a valid 4-digit OTP",
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      isLoading.value = false;
      developer.log("Validation failed: Invalid OTP format", name: 'SignupOtpController');
      return false;
    }

    try {
      Map<String, dynamic> mapBody = {
        "email": email,
        "otp": int.parse(otpText),
      };

      developer.log("API Endpoint: ${Urls.authVerifyOtp}", name: 'SignupOtpController');
      developer.log("Request Payload: $mapBody", name: 'SignupOtpController');

      final NetworkResponse response = await NetworkCall.postRequest(
        url: Urls.authVerifyOtp,
        body: mapBody,
      );

      developer.log("================== VERIFY OTP API RESPONSE ==================", name: 'SignupOtpController');
      developer.log("Status Code: ${response.statusCode}", name: 'SignupOtpController');
      developer.log("Is Success: ${response.isSuccess}", name: 'SignupOtpController');
      developer.log("Response Body: ${response.responseData}", name: 'SignupOtpController');
      developer.log("==============================================================", name: 'SignupOtpController');

      if (response.isSuccess) {
        final data = response.responseData?['data'];
        final token = data['token'] as String;
        
        developer.log("Token received: $token", name: 'SignupOtpController');
        
        // Save token and user data
        await SharedPreferencesHelper.saveAccessToken(token);
        developer.log("Token saved to SharedPreferences", name: 'SignupOtpController');
        
        // Get and save user data from AuthController
        await AuthController.getUserData();
        developer.log("User data fetched and saved", name: 'SignupOtpController');
        
        Get.snackbar(
          "Success",
          "Email verified successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        
        // Clear OTP fields
        textCtrl.clearOtpFields();
        developer.log("OTP fields cleared", name: 'SignupOtpController');
        
        isLoading.value = false;
        developer.log("OTP verification SUCCESSFUL", name: 'SignupOtpController');
        return true;
      } else {
        final message = response.responseData?['message']?.toString() ?? 
                       response.responseData?['detail']?.toString() ??
                       "Invalid OTP";
        
        _errorMessage = message;
        
        developer.log("OTP verification FAILED: $message", name: 'SignupOtpController');
        
        // Get.snackbar(
        //   "Error",
        //   message,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
        
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      _errorMessage = "Network error: $e";
      
      developer.log("================== OTP VERIFICATION EXCEPTION ==================", name: 'SignupOtpController');
      developer.log("Exception Type: ${e.runtimeType}", name: 'SignupOtpController');
      developer.log("Exception Message: $e", name: 'SignupOtpController');
      developer.log("Stack Trace: ${e.toString()}", name: 'SignupOtpController');
      developer.log("=================================================================", name: 'SignupOtpController');
      
      Get.snackbar(
        "Error",
        "Network error: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> resendOtp() async {
    developer.log("================== RESEND OTP API CALL ==================", name: 'SignupOtpController');
    developer.log("Can Resend: ${canResend.value}", name: 'SignupOtpController');
    developer.log("Seconds Remaining: ${secondsRemaining.value}", name: 'SignupOtpController');
    
    if (!canResend.value && secondsRemaining.value > 0) {
      developer.log("Resend blocked: Timer still running", name: 'SignupOtpController');
      // Get.snackbar(
      //   "Wait",
      //   "Please wait for the timer to finish",
      //   backgroundColor: Colors.orange,
      //   colorText: Colors.white,
      // );
      return false;
    }
    
    isLoading.value = true;
    developer.log("Loading started for resend OTP", name: 'SignupOtpController');
    
    try {
      // Get email from the signup form
      final email = textCtrl.emailController.text.trim();
      developer.log("Email for resend: $email", name: 'SignupOtpController');
      
      if (email.isEmpty) {
        developer.log("Validation failed: Email is empty for resend", name: 'SignupOtpController');
        Get.snackbar(
          "Error",
          "Email is missing",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return false;
      }

      Map<String, dynamic> mapBody = {
        "email": email,
      };

      developer.log("API Endpoint: ${Urls.authResendOtp}", name: 'SignupOtpController');
      developer.log("Request Payload: $mapBody", name: 'SignupOtpController');

      final NetworkResponse response = await NetworkCall.postRequest(
        url: Urls.authResendOtp,
        body: mapBody,
      );

      developer.log("================== RESEND OTP API RESPONSE ==================", name: 'SignupOtpController');
      developer.log("Status Code: ${response.statusCode}", name: 'SignupOtpController');
      developer.log("Is Success: ${response.isSuccess}", name: 'SignupOtpController');
      developer.log("Response Body: ${response.responseData}", name: 'SignupOtpController');
      developer.log("==============================================================", name: 'SignupOtpController');

      if (response.isSuccess) {
        // Restart the timer
        startTimer();
        developer.log("Timer restarted", name: 'SignupOtpController');
        
        final successMessage = response.responseData?['message']?.toString() ?? "OTP sent to your email";
        developer.log("Success message: $successMessage", name: 'SignupOtpController');
        
        // Get.snackbar(
        //   "Success",
        //   successMessage,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   snackPosition: SnackPosition.BOTTOM,
        // );
        
        isLoading.value = false;
        developer.log("Resend OTP SUCCESSFUL", name: 'SignupOtpController');
        return true;
      } else {
        final message = response.responseData?['message']?.toString() ?? 
                       response.responseData?['detail']?.toString() ??
                       "Failed to resend OTP";
        
        developer.log("Resend OTP FAILED: $message", name: 'SignupOtpController');
        
        // Get.snackbar(
        //   "Error",
        //   message,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
        
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      developer.log("================== RESEND OTP EXCEPTION ==================", name: 'SignupOtpController');
      developer.log("Exception Type: ${e.runtimeType}", name: 'SignupOtpController');
      developer.log("Exception Message: $e", name: 'SignupOtpController');
      developer.log("Stack Trace: ${e.toString()}", name: 'SignupOtpController');
      developer.log("===========================================================", name: 'SignupOtpController');
      
      Get.snackbar(
        "Error",
        "Network error: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
      isLoading.value = false;
      return false;
    }
  }

  @override
  void onClose() {
    developer.log("SignupOtpController disposed", name: 'SignupOtpController');
    super.onClose();
  }
}