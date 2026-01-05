/*
// lib/feature/profile/controllers/edit_profile_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'my_profile_controller.dart';

class EditProfileController extends GetxController {
  final ProfileApiController profileCtrl = Get.find<ProfileApiController>();

  // Reactive
  final RxString newProfileImagePath = ''.obs;
  final RxString gender = ''.obs;
  final RxBool isLoading = false.obs;

  // Text Controllers
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController countryCtrl;
  late final TextEditingController phoneCtrl;

  // Original values for change detection
  String _originalFirstName = '';
  String _originalLastName = '';
  String _originalCountry = '';
  String _originalPhone = '';
  String _originalGender = '';
  String _originalImage = '';

  @override
  void onInit() {
    super.onInit();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    countryCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    _loadProfileData();
  }

  void _loadProfileData() {
    final user = profileCtrl.userProfile.value;

    // সরাসরি firstName & lastName নাও — splitting বাদ!
    firstNameCtrl.text = user.firstName ?? '';
    lastNameCtrl.text = user.lastName ?? '';
    countryCtrl.text = user.country ?? '';
    phoneCtrl.text = user.phone ?? '';
    gender.value = user.gender ?? '';

    // Save originals
    _originalFirstName = firstNameCtrl.text.trim();
    _originalLastName = lastNameCtrl.text.trim();
    _originalCountry = countryCtrl.text.trim();
    _originalPhone = phoneCtrl.text.trim();
    _originalGender = gender.value;
    _originalImage = user.profileImage ?? '';

    // Reset new image
    newProfileImagePath.value = '';
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null && result.files.single.path != null) {
      newProfileImagePath.value = result.files.single.path!;
    }
  }

  bool get hasChanges {
    return firstNameCtrl.text.trim() != _originalFirstName ||
        lastNameCtrl.text.trim() != _originalLastName ||
        countryCtrl.text.trim() != _originalCountry ||
        phoneCtrl.text.trim() != _originalPhone ||
        gender.value != _originalGender ||
        newProfileImagePath.isNotEmpty;
  }

  Future<void> saveChanges() async {
    final first = firstNameCtrl.text.trim();
    final last = lastNameCtrl.text.trim();

    if (first.isEmpty || last.isEmpty) {
      Get.snackbar('Error', 'First name and last name are required',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    final success = await profileCtrl.editProfile(
      firstName: first,
      lastName: last,
      country: countryCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      gender: gender.value,
      profileImagePath:
      newProfileImagePath.isNotEmpty ? newProfileImagePath.value : null,
    );

    isLoading.value = false;

    if (success) {
      Get.snackbar('Success', 'Profile updated successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.back();
    } else {
      Get.snackbar('Failed', profileCtrl.errorMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    countryCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }
}*/
