import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../../model/user_model.dart';
import '../../signup/screens/signup_otp_screen.dart';
import '../../text editing controller/custom_text_editing_controller.dart';

class LoginApiController extends GetxController {
  var isChecked = false.obs;
  var isPasswordHidden = true.obs;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final CustomTextEditingController userTextEditingController =
  Get.put(CustomTextEditingController());

  UserModel? userModel;

  Future<bool> loginApiMethod() async {
    bool isSuccess = false;
    try {
      final Map<String, dynamic> mapBody = {
        "email": userTextEditingController.emailController.text.trim(),
        "password": userTextEditingController.passwordController.text.trim(),
      };

      final NetworkResponse response = await NetworkCall.postRequest(
        url: Urls.login,
        body: mapBody,
      );

      if (response.isSuccess) {
        final data = response.responseData!["data"];

        final String? token = data['token'];
        if (token == null || token.isEmpty) {
          _errorMessage = 'Invalid token received';
          return false;
        }

        // If server says email not verified, route to OTP flow
        final bool emailVerified = data['emailVerification'] == true;
        if (!emailVerified) {
          _errorMessage = 'Email not verified';
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

        // Build minimal user model from login response (API doesn't return full user object)
        userModel = UserModel(
          id: data['userId']?.toString(),
          email: userTextEditingController.emailController.text.trim(),
          role: data['role']?.toString(),
        );

        await AuthController.saveAccessToken(token);
        await SharedPreferencesHelper.saveAccessToken(token);
        await SharedPreferencesHelper.saveUserEmail(userModel?.email ?? '');
        if (userModel?.id != null && userModel!.id!.isNotEmpty) {
          await AuthController.saveUserId(userModel!.id!);
        }
        // Save user data + token together for later usage
        await AuthController.setUserData(token, userModel!);

        _errorMessage = null;
        isSuccess = true;
        update();
      } else {
        _errorMessage = response.errorMessage ??
            response.responseData?['message'] ??
            'Login failed';
      }
    } catch (e) {
      _errorMessage = 'Exception: $e';
      print(e);
    }
    return isSuccess;
  }
}
