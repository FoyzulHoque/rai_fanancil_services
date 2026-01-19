import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../../model/user_model.dart';
import '../../text editing controller/custom_text_editing_controller.dart';

class AddNewPassword extends GetxController {
  String? _errorMessage;
  String? _successMessage;  // ✅ Add success message
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  final CustomTextEditingController accountTextEditingController = Get.find<CustomTextEditingController>();

  Future<bool> addNewPasswordApiCallMethod() async {
    bool isSuccess = false;
    _errorMessage = null;
    _successMessage = null;

    final email = accountTextEditingController.emailController.text.trim();
    final newPassword = accountTextEditingController.newPasswordController.text;
    final confirmPassword = accountTextEditingController.newPasswordController.text;

    // Validation
    if (email.isEmpty) {
      _errorMessage = "Email is missing.";
      update();
      return false;
    }

    if (newPassword.isEmpty ) {
      _errorMessage = "Please fill both password fields.";
      update();
      return false;
    }

    if (newPassword != confirmPassword) {
      _errorMessage = "Passwords do not match.";
      update();
      return false;
    }

    if (newPassword.length < 8) {
      _errorMessage = "Password must be at least 8 characters.";
      update();
      return false;
    }

    try {
      Map<String, dynamic> mapBody = {
        "email": email,
        "password": newPassword,
      };

      final NetworkResponse response = await NetworkCall.putRequest(
        url: Urls.authForgetResetPassword,
        body: mapBody,
      );

      if (response.isSuccess) {
        _successMessage = response.responseData?['message'] ?? "Password reset successful.";
        var data=response.responseData!['data'];
        isSuccess = true;
        final String? token = data['token'];
        if (token == null || token.isEmpty) {
          _errorMessage = 'Invalid token received';
          return false;
        }

        UserModel userModel =  UserModel.fromJson(data);
        await AuthController.setUserData(token,userModel);
        await SharedPreferencesHelper.saveAccessToken(token);
        await AuthController.getUserData();
      } else {
        _errorMessage = response.responseData?['message'] ??
            response.responseData?['detail'] ??
            "Failed to reset password.";
      }
    } catch (e) {
      _errorMessage = "Network error: $e";
      debugPrint("❌ Reset Exception: $e");
    }

    update();
    return isSuccess;
  }
}