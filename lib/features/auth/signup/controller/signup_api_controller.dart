/*
// features/auth/controllers/signup_api_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../../model/user_model.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../screens/signup_otp_screen.dart';

class SignupApiController extends GetxController {
  final CustomTextEditingController textCtrl = Get.find<CustomTextEditingController>();

  final RxBool isLoading = false.obs;

  Future<bool> signupApiMethod() async {
    bool isSuccess=false;
    // ভ্যালিডেশন
    if (textCtrl.firstNameController.text.trim().isEmpty ||
        textCtrl.lastNameController.text.trim().isEmpty ||
        textCtrl.emailController.text.trim().isEmpty ||
        textCtrl.passwordController.text.isEmpty ||
        textCtrl.fullPhoneNumber.isEmpty) {
      Get.snackbar('Warning', 'All fields are required', backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }

    isLoading.value = true;

    try {
      File? imageFile;
      if (textCtrl.profileImagePath.value.isNotEmpty) {
        imageFile = File(textCtrl.profileImagePath.value);
      }

      final response = await NetworkCall.multipartRequest(
        url: Urls.authSignUp,
        methodType: 'POST',
        fields: {
          'firstName': textCtrl.firstNameController.text.trim(),
          'lastName': textCtrl.lastNameController.text.trim(),
          'email': textCtrl.emailController.text.trim(),
          'password': textCtrl.passwordController.text,
          'phone': textCtrl.fullPhoneNumber,
          'gender': textCtrl.selectedGender.value,
        },
        imageFile: imageFile,
        imageFieldName: 'image',
      );

      if (response.isSuccess) {
        final data = response.responseData?['data'];
        final token = data['token'] as String;
        final user = UserModel.fromJson(data['newUser']);

        // Save token temporarily (user not fully verified yet)
        await SharedPreferencesHelper.saveAccessToken(token);
        AuthController.setUserData(token, user);

        Get.snackbar('Success', 'Account created! Please verify your email',
             backgroundColor: Colors.green,
             colorText: Colors.white,
             snackPosition: SnackPosition.BOTTOM);

        // Navigate to signup OTP view instead of login
        Get.off(() => SignupOtpScreens());

        return true;
      } else {
        String msg = 'Signup failed';
        if (response.responseData != null && response.responseData!['message'] != null) {
          msg = response.responseData!['message'].toString();
        }

        // Get.snackbar('Error', msg,
        //     backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    } catch (e) {
      // Get.snackbar('Error', 'Network error: $e',
      //     backgroundColor: Colors.red, colorText: Colors.white);
      return isSuccess;
    } finally {
      isLoading.value = false;
    }
  }
}*/
// features/auth/controllers/signup_api_controller.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../model/user_model.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../screens/signup_otp_screen.dart';

class SignupApiController extends GetxController {
  final CustomTextEditingController textCtrl = Get.find<CustomTextEditingController>();

  final RxBool isLoading = false.obs;

  Future<bool> signupApiMethod() async {
    // Validation
    if (textCtrl.firstNameController.text.trim().isEmpty ||
        textCtrl.lastNameController.text.trim().isEmpty ||
        textCtrl.emailController.text.trim().isEmpty ||
        textCtrl.passwordController.text.isEmpty ||
        textCtrl.fullPhoneNumber.isEmpty||
        textCtrl.locationController.text.isEmpty) {
      Get.snackbar('Warning', 'All fields are required',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }

    isLoading.value = true;

    try {
      File? imageFile;
      if (textCtrl.profileImagePath.value.isNotEmpty) {
        imageFile = File(textCtrl.profileImagePath.value);
      }

      final response = await NetworkCall.multipartRequest(
        url: Urls.authSignUp,
        methodType: 'POST',
        fields: {
          'firstName': textCtrl.firstNameController.text.trim(),
          'lastName': textCtrl.lastNameController.text.trim(),
          'email': textCtrl.emailController.text.trim(),
          'password': textCtrl.passwordController.text,
          'location': textCtrl.locationController.text.trim(),
          'phone': textCtrl.fullPhoneNumber,
          'gender': textCtrl.selectedGender.value,
          'dob': textCtrl.dateOfBirth.value,
        },
        imageFile: imageFile,
        imageFieldName: 'image',
      );

      // ── DEBUG PRINTS ── (remove later if not needed)
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("response.isSuccess: ${response.isSuccess}");
      debugPrint("Raw response body: ${response.responseData}");

      // More reliable success check (recommended)
      final body = response.responseData;
      final bool apiSuccess =
          (response.statusCode == 200 || response.statusCode == 201) &&
              (body != null && body['success'] == true);

      if (apiSuccess) {
        final data = body['data'];
        if (data == null || data['newUser'] == null) {
          Get.snackbar('Error', 'Invalid response format from server',
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }

        final user = UserModel.fromJson(data['newUser']);
        
        // Save userId for later use (token will be received after email verification)
        if (data['userId'] != null) {
          await AuthController.saveUserId(data['userId'] as String);
        }
        
        // Save user data temporarily (without token, as token comes after email verification)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user-data', jsonEncode(user.toJson()));
        AuthController.userModel = user;
        AuthController.userModelRx.value = user;

        Get.snackbar(
          'Success',
          body['message']?.toString() ?? 'Account created! Please verify your email',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.off(() => const SignupOtpScreens());

        return true;
      } else {
        // Failure message from server or fallback
        String msg = 'Signup failed';
        if (body != null && body['message'] != null) {
          msg = body['message'].toString();
        } else if (!response.isSuccess) {
          msg = 'Request marked as failed (status: ${response.statusCode})';
        }

        Get.snackbar('Error', msg,
            backgroundColor: Colors.red, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);

        return false;
      }
    } catch (e, stackTrace) {
      debugPrint("Signup error: $e");
      debugPrint("Stack trace: $stackTrace");

      Get.snackbar('Error', 'Network or processing error occurred',
          backgroundColor: Colors.red, colorText: Colors.white);

      return false;
    } finally {
      isLoading.value = false;
    }
  }
}