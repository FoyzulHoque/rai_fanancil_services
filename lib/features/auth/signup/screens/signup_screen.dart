// features/auth/views/sign_up_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_field.dart';
import '../../signin/screens/signin_screens.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../controller/signup_api_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  // Inject controllers
  final CustomTextEditingController controller = Get.put(CustomTextEditingController());
  final SignupApiController apiController = Get.put(SignupApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColors,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 83,
                      width: 76.78,
                      child: Image.asset("assets/logos/Primary-Logo 1.png"),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      'Register Your Account',
                      style: AppTextStyles.title.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),const SizedBox(height: 10,),
                    Text(
                      'Enter your information below',
                      style: AppTextStyles.title.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Profile Picture with Camera
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(() => CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: controller.profileImagePath.value.isNotEmpty
                          ? FileImage(File(controller.profileImagePath.value))
                          : const AssetImage('assets/images/dp.png') as ImageProvider,
                    )),

                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                        ),
                        child: Image.asset(
                          'assets/icons/camera.png',
                          color: AppColors.primary,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // First Name
              CustomTextField(
                controller: controller.firstNameController,
                hintText: 'First Name',
                prefixIcon: 'assets/icons/dp_mini.png',
              ),
              const SizedBox(height: 16),

              // Last Name
              CustomTextField(
                controller: controller.lastNameController,
                hintText: 'Last Name',
                prefixIcon: 'assets/icons/dp_mini.png',
              ),
              const SizedBox(height: 16),

              // Date of birth .
              CustomTextField(
                controller: controller.dateOfBirthController,
                hintText: 'Date of birth .',
                prefixIcon: 'assets/icons/calendar-03.png',
              ),
              const SizedBox(height: 16),
              // Location
              CustomTextField(
                controller: controller.dateOfBirthController,
                hintText: 'Location',
                prefixIcon: 'assets/icons/location-06.png',
              ),
              const SizedBox(height: 16),
              // Email
              CustomTextField(
                controller: controller.emailController,
                hintText: 'Email',
                prefixIcon: 'assets/icons/email.png',
              ),
              const SizedBox(height: 16),

              // Gender Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedGender.value,
                onChanged: (value) => controller.selectedGender.value = value!,
                decoration: InputDecoration(
                  hintText: 'Gender',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
                items: controller.genders
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
              )),
              const SizedBox(height: 16),

              // Phone Number Input
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  controller.phoneNumber.value = number;
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                initialValue: controller.phoneNumber.value,
                textFieldController: controller.phoneController,
                formatInput: true,
                keyboardType: TextInputType.phone,
                inputDecoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone, color: AppColors.primary),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),



              // Password
              Obx(() => CustomTextField(
                controller: controller.passwordController,
                hintText: 'Password',
                prefixIcon: 'assets/icons/lock.png',
                obscureText: !controller.isPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.primary,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              )),
              const SizedBox(height: 16),
              /*Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedRoll.value,
                onChanged: (value) => controller.selectedRoll.value = value!,
                decoration: InputDecoration(
                  hintText: 'Role',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
                items: controller.roll
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
              )),
              const SizedBox(height: 32),*/

              // Sign Up Button
              Obx(() => CustomFloatingButton(
                customBackgroundColor: AppColors.primary,
                textColors: AppColors.white,
                onPressed: _apiCallButton,
                buttonText: apiController.isLoading.value
                    ? 'Creating Account...'
                    : 'Sign Up',
              )),
              const SizedBox(height: 24),

              // Already have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () => Get.to(()=>LoginScreen()),
                    child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _apiCallButton() async{
    bool isSuccess=await apiController.signupApiMethod();
    if(isSuccess){
      Get.snackbar('Success', 'Account created successfully!', backgroundColor: Colors.green);
      Get.back();
    }else{
      Get.snackbar('Error', 'Something went wrong!', backgroundColor: Colors.red);
    }
  }

}