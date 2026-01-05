// lib/features/profile/controller/edit_profile_controller.dart

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../core/services_class/shared_preferences_data_helper.dart';

class EditProfileController extends GetxController {
  // Text Controllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  // Reactive
  final RxString newImagePath = ''.obs;
  final Rx<PhoneNumber> phoneNumber = PhoneNumber(isoCode: 'BD').obs;
  final RxString gender = ''.obs;
  final RxBool isLoading = false.obs;

  final List<String> genderList = ['Male', 'Female', 'Other'];

  @override
  void onInit() {
    super.onInit();
    // Use Future.microtask to schedule the call after the current build frame
    Future.microtask(() => _loadUserData());
  }

  void _loadUserData() {
    final user = AuthController.userModel;
    if (user == null) {
      // Schedule the navigation for after the current build frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', 'User not found!');
        Get.back();
      });
      return;
    }

    firstNameCtrl.text = user.firstName ?? '';
    lastNameCtrl.text = user.lastName ?? '';
    countryCtrl.text = user.location ?? '';
    gender.value = user.gender ?? '';

    // Phone number parse safely
    final phone = user.phone ?? '';
    if (phone.isNotEmpty) {
      PhoneNumber.getRegionInfoFromPhoneNumber(phone, 'BD')
          .then((parsed) => phoneNumber.value = parsed)
          .catchError((_) => phoneNumber.value = PhoneNumber(isoCode: 'BD', phoneNumber: phone));
    }
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    if (result?.files.single.path != null) {
      newImagePath.value = result!.files.single.path!;
    }
  }

  String get fullPhoneNumber => phoneNumber.value.phoneNumber ?? '';

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    countryCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }
}