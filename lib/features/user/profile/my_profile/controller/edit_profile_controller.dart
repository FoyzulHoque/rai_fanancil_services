// lib/feature/profile/controllers/edit_profile_controller.dart

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
  final RxBool hasChanges = false.obs;
  final RxString dateTime = ''.obs; // Changed to RxString

  // Text Controllers
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController location;

  // Original values for change detection
  String _originalFirstName = '';
  String _originalLastName = '';
  String _originalDateTime = '';
  String _originalLocation = '';
  String _originalImage = '';

  @override
  void onInit() {
    super.onInit();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    location = TextEditingController();
    _loadProfileData();

    // Add listeners to check for changes automatically
    firstNameCtrl.addListener(_checkForChanges);
    lastNameCtrl.addListener(_checkForChanges);
    location.addListener(_checkForChanges);
    dateTime.listen((_) => _checkForChanges()); // Listen to RxString
    newProfileImagePath.listen((_) => _checkForChanges());
  }

  void _loadProfileData() {
    final user = profileCtrl.userProfile.value;

    firstNameCtrl.text = user.firstName ?? '';
    lastNameCtrl.text = user.lastName ?? '';
    location.text = user.location ?? '';
    dateTime.value = user.dob ?? ''; // Set RxString value

    // Save originals
    _originalFirstName = firstNameCtrl.text.trim();
    _originalLastName = lastNameCtrl.text.trim();
    _originalDateTime = dateTime.value.trim();
    _originalLocation = location.text.trim();
    _originalImage = user.profileImage ?? '';

    // Reset new image and check initial state
    newProfileImagePath.value = '';
    _checkForChanges();
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

  void _checkForChanges() {
    hasChanges.value = firstNameCtrl.text.trim() != _originalFirstName ||
        lastNameCtrl.text.trim() != _originalLastName ||
        location.text.trim() != _originalLocation ||
        dateTime.value.trim() != _originalDateTime ||
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
      location: location.text.trim(),
      dateTime: dateTime.value.trim(),
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
    location.dispose();
    super.onClose();
  }
}
