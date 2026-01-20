/*
// lib/features/auth/views/edit_profile_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../../core/services_class/shared_preferences_data_helper.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_field.dart';
import '../controller/edit_profile_controller.dart';
import '../controller/edit_profile_api_controller.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers
  final EditProfileController controller = Get.put(EditProfileController());
  final EditProfileApiController apiController = Get.put(EditProfileApiController());

  @override
  void initState() {
    super.initState();
    // Remove the API call from initState - it's calling updateProfile which should not be called here
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthController.userModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black87)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update your Profile',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),

              const SizedBox(height: 30),

              // Profile Picture
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(() {
                      final hasNewImage = controller.newImagePath.value.isNotEmpty;
                      return CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: hasNewImage
                            ? FileImage(File(controller.newImagePath.value))
                            : user?.profileImage?.isNotEmpty == true
                            ? NetworkImage(user!.profileImage!)
                            : const AssetImage('assets/images/dp.png') as ImageProvider,
                        child: !hasNewImage && (user?.profileImage?.isEmpty ?? true)
                            ? const Icon(Icons.person, size: 60, color: Colors.white70)
                            : null,
                      );
                    }),
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                          ],
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // First Name
              CustomTextField(
                controller: controller.firstNameCtrl,
                hintText: 'First Name',
                prefixIcon: 'assets/icons/user.png',
              ),
              const SizedBox(height: 16),

              // Last Name
              CustomTextField(
                controller: controller.lastNameCtrl,
                hintText: 'Last Name',
                prefixIcon: 'assets/icons/user.png',
              ),
              const SizedBox(height: 16),

              // Gender
              Obx(() => DropdownButtonFormField<String>(
                value: controller.gender.value.isEmpty ? null : controller.gender.value,
                hint: const Text('Select Gender'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
                items: controller.genderList
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => controller.gender.value = v!,
              )),
              const SizedBox(height: 16),

              // Phone Number
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    controller.phoneNumber.value = number;
                  },
                  initialValue: controller.phoneNumber.value,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    showFlags: true,
                    useEmoji: true,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 16,
                  ),
                  textFieldController: controller.phoneCtrl,
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter phone number',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                  ),
                  formatInput: true,
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 16),

              // Country
              CustomTextField(
                controller: controller.countryCtrl,
                hintText: 'Country',
                prefixIcon: 'assets/icons/location.png',
              ),

              const SizedBox(height: 40),

               Obx(() => CustomFloatingButton(
                onPressed: () => _apiCallMethod(),
                buttonText: controller.isLoading.value ? 'Updating...' : 'Update Profile',
              )),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _apiCallMethod() async {
    bool isSuccess = await apiController.updateProfile(controller);
    if (isSuccess) {
      // Wait a bit for the data to be refreshed
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Navigate back with a result
      Get.back(result: true);
      
      // Show snackbar in the profile view
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Success', 'Profile updated successfully!',
            backgroundColor: Colors.green, 
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      });
    } else {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red, 
          colorText: Colors.white);
    }
  }
}*/
