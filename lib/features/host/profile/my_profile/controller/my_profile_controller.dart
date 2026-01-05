
import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../../../core/network_caller/network_config.dart';
import '../../../../../core/network_path/natwork_path.dart';
import '../../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../../../../core/services_class/shared_preferences_helper.dart';
import '../../../../auth/model/user_model.dart';
import '../../../../auth/signin/screens/signin_screens.dart';

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

  /*Future<bool> editProfile({
    required String firstName,
    required String lastName,
    required String country,
    required String phone,
    required String gender,
    String? profileImagePath,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        final File imageFile = File(profileImagePath);

        final response = await NetworkCall.multipartRequest(
          url: Urls.editUserDataUrl,
          fields: {
            'firstName': firstName,
            'lastName': lastName,
            'country': country,
            'phone': phone,
            'gender': gender,
          },
          imageFile: imageFile,
          methodType: 'PUT',
          imageFieldName: 'profileImage',
        );

        if (!response.isSuccess) {
          errorMessage.value = response.errorMessage ?? 'Image upload failed';
          return false;
        }

        _updateUserFromResponse(response);
        return true;
      }

      else {
        final response = await NetworkCall.putRequest(
          url: Urls.editUserDataUrl,
          body: {
            'firstName': firstName,
            'lastName': lastName,
            'country': country,
            'phone': phone,
            'gender': gender,
          },
        );

        if (response.isSuccess) {
          _updateUserFromResponse(response);
          return true;
        } else {
          errorMessage.value = response.errorMessage ?? 'Update failed';
          if (response.statusCode == 401) Get.offAllNamed('/login');
          return false;
        }
      }
    } catch (e) {
      errorMessage.value = 'Exception: $e';
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
  }*/
  Future<bool> logout() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await SharedPreferencesHelper.clearAccessToken();
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
        await SharedPreferencesHelper.clearAccessToken();
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
