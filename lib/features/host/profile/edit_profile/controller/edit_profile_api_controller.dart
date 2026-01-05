// lib/features/auth/controllers/edit_profile_api_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/network_caller/network_config.dart';
import '../../../../../core/network_path/natwork_path.dart';
import '../../../../../core/services_class/shared_preferences_data_helper.dart';
import 'edit_profile_controller.dart';

class EditProfileApiController extends GetxController {
  Future<bool> updateProfile(EditProfileController ctrl) async {
    ctrl.isLoading.value = true;

    try {
      File? imageFile = ctrl.newImagePath.value.isNotEmpty
          ? File(ctrl.newImagePath.value)
          : null;

      final response = await NetworkCall.multipartRequest(
        url: Urls.editUserDataUrl,
        methodType: 'PUT',
        fields: {
          'firstName': ctrl.firstNameCtrl.text.trim(),
          'lastName': ctrl.lastNameCtrl.text.trim(),
          'location': ctrl.countryCtrl.text.trim(),
          'phone': ctrl.fullPhoneNumber,
          'gender': ctrl.gender.value,
        },
        imageFile: imageFile,
        imageFieldName: 'image',
      );

      if (response.isSuccess) {
        // Force refresh user data
        await AuthController.getUserData();
        
        // Clear new image path after successful upload
        ctrl.newImagePath.value = '';
        
        return true;
      } else {
        final msg = response.responseData?['message'] ?? 'Update failed';
        Get.snackbar('Error', msg.toString(), 
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e', 
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      ctrl.isLoading.value = false;
    }
  }
}