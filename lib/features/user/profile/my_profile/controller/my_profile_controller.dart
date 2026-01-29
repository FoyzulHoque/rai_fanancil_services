
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../../../core/network_caller/network_config.dart';
import '../../../../../core/network_path/natwork_path.dart';
import '../../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../../../../core/services_class/shared_preferences_helper.dart';
import '../../../../auth/model/user_model.dart';
import '../../../../auth/signin/screens/signin_screens.dart';
import '../../../../auth/signup/screens/signup_otp_screen.dart';
import '../../../financial data collection/view/set_up_your_financial_profile.dart';
import '../../../user navbar/user_navbar_screen.dart';

class ProfileApiController extends GetxController {
  final Rx<UserModel> userProfile = UserModel().obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;


  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await NetworkCall.getRequest(url: Urls.getUserDataUrl);
      if (response.isSuccess) {
        final data = response.responseData?['data'] ?? response.responseData ?? {};
        userProfile.value = UserModel.fromJson(data);

        /*final bool emailVerified = data['emailVerification'] == true;
        final bool isFinancialProfileCompletes = data['isFinancialProfileComplete'] == true;
        if (!emailVerified) {
          Get.snackbar(
            "Email not verified",
            "Please verify your email ",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.to(() => SignupOtpScreens());
          return ;
        }else if(emailVerified && !isFinancialProfileCompletes){
          Get.snackbar(
            "Field not verified",
            "Please verify your field",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.to(()=>SetUpYourFinancialProfile());
        }else{
          Get.offAll(()=>UserBottomNavbar());
        }*/

      } else {
        errorMessage.value = response.errorMessage ?? 'Failed to load profile';
        if (response.statusCode == 401) Get.offAllNamed('/login');
      }
    } catch (e) {
      errorMessage.value = 'Network error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // lib/feature/profile/controllers/profile_controller.dart

  Future<bool> editProfile({
    required String firstName,
    required String lastName,
    required String dateTime,   // ← rename param to dob
    required String location,
    String? profileImagePath,
  }) async {
    isLoading.value = true;

    try {
      final fields = {
        'firstName': firstName,
        'lastName': lastName,
        'dob': dateTime,           // ← use correct field name
        'location': location,
      };

      NetworkResponse response;

      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        // Case 1: Send a multipart request WITH the image
        final imageFile = File(profileImagePath);
        response = await NetworkCall.multipartRequest(
          url: Urls.editUserDataUrl,
          fields: fields,
          imageFile: imageFile,
          methodType: 'PUT',
          // Backend expects the same field name as signup upload
          imageFieldName: 'image',
        );
      } else {
        // Case 2: Send a standard JSON PUT request WITHOUT an image
        response = await NetworkCall.putRequest(
          url: Urls.editUserDataUrl,
          body: fields,
        );
      }

      if (response.isSuccess) {
        _updateUserFromResponse(response);
        return true;
      } else {
        errorMessage.value = response.errorMessage ?? 'Update failed';
        return false;
      }
    } catch (e) {
      errorMessage.value = '$e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _updateUserFromResponse(dynamic response) {
    final updatedData = response.responseData?['data'] ?? {};
    if (updatedData.isNotEmpty) {
      userProfile.value = UserModel.fromJson(updatedData);
    } else {
      getProfile(); // fallback
    }
  }

  Future<bool> logout() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await SharedPreferencesHelper.clearAllData();
      await AuthController.dataClear();
      Get.offAll(() =>  LoginScreen());
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteAccount() async {
    isLoading.value = true;
    try {
      final response = await NetworkCall.deleteRequest(url: Urls.deleteUserDataUrl);
      if (response.isSuccess) {
        final token = await SharedPreferencesHelper.getAccessToken();
        print("-----------$token");
        await SharedPreferencesHelper.clearAllData();
        //Get.offAll(() => LoginScreen());
        Get.snackbar('Success', 'Account deleted successfully.',
            backgroundColor: Colors.green, colorText: Colors.white);
        return true;
      } else {
        errorMessage.value = response.errorMessage ?? 'Delete failed';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      Get.snackbar('Error', 'An unexpected error occurred.',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
