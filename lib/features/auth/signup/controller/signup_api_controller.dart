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

        // Get.snackbar('Success', 'Account created! Please verify your email',
        //     backgroundColor: Colors.green, 
        //     colorText: Colors.white, 
        //     snackPosition: SnackPosition.BOTTOM);

        // Navigate to signup OTP view instead of login
        Get.off(() => SignupOtpScreen());

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
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}