import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomTextEditingController extends GetxController {
  static void initialize() {
    Get.put(CustomTextEditingController(), permanent: true);
  }

  // Reactive variables
  final RxString profileImagePath = ''.obs;
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedRoll = 'User'.obs;
  final RxBool isPasswordVisible = false.obs;
  static const int otpLength = 4;
  final RxString enteredOtp = ''.obs;

  // Text Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final countryController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final searchingController = TextEditingController();
  final locationController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  // OTP Controllers & Focus Nodes
  late final List<TextEditingController> otpControllersList;
  late final List<FocusNode> focusNodes;

  // Phone number with country
  final Rx<PhoneNumber> phoneNumber = PhoneNumber(isoCode: 'US').obs;

  // List of genders
  List<String> get genders => ['Male', 'Female', 'Other'];
  List<String> get roll => ['User', 'Host'];

  CustomTextEditingController() {
    // Initialize lists in constructor
    otpControllersList = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  // Operator overload to access OTP controller by index
  TextEditingController operator [](int index) => otpControllersList[index];

  // Get complete OTP as string
  String getOtpString() {
    return otpControllersList
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .join();
  }

  // Pick Image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      profileImagePath.value = result.files.single.path!;
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String get fullPhoneNumber {
    return phoneNumber.value.phoneNumber ?? '';
  }

  // Get only dial code: +880
  String get dialCode {
    return phoneNumber.value.dialCode ?? '';
  }

  // Clear all fields
  void clearAll() {
    profileImagePath.value = '';
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    searchingController.clear();
    countryController.clear();
    selectedGender.value = 'Male';
    phoneNumber.value = PhoneNumber(isoCode: 'US');
    clearOtpFields(); // Call the method instead of inline code
  }

  // Clear only OTP fields
  void clearOtpFields() {
    for (var controller in otpControllersList) {
      controller.clear();
    }
    // Also clear focus if needed
    for (var node in focusNodes) {
      node.unfocus();
    }
    enteredOtp.value = '';
  }

  /*@override
  void onClose() {
    // Dispose all text controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    searchingController.dispose();

    // Dispose OTP controllers and focus nodes
    for (var controller in otpControllersList) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }

    super.onClose();
  }*/
}