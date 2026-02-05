import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomTextEditingController extends GetxController {
  static void initialize() {
    // permanent so it will NOT dispose when screen changes
    if (!Get.isRegistered<CustomTextEditingController>()) {
      Get.put(CustomTextEditingController(), permanent: true);
    }
  }

  // Reactive variables
  final RxString profileImagePath = ''.obs;
  final RxString dateOfBirth = ''.obs;
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedRoll = 'User'.obs;

  // ✅ keep default "Select" because dropdown expects it
  final RxString selectedROIGrowthFilter = 'Select'.obs;
  final RxString selectedLoanTerm = 'Select'.obs;

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

  // ✅ SEARCH / LOCATION controller (use ONE controller app-wide)
  // Use this for SearchsWidget Location input
  final locationController = TextEditingController();

  // (keep if you use elsewhere)
  final searchingController = TextEditingController();

  // OTP Controllers & Focus Nodes
  late final List<TextEditingController> otpControllersList;
  late final List<FocusNode> focusNodes;

  // Phone number with country
  final Rx<PhoneNumber> phoneNumber = PhoneNumber(isoCode: 'US').obs;

  // Lists
  List<String> get genders => ['Male', 'Female', 'Other'];
  List<String> get roll => ['User', 'Host'];

  List<String> get growthFilter =>
      ['5 years', '10 years', '15 years', '20 years', '25 years', '30 years'];

  List<String> get loanTerm => [
    'ROI ≥ 3%',
    'ROI ≥ 5%',
    'ROI ≥ 7%',
    'Capital Growth (1yr)',
    'Capital Growth (5yr)',
    'Capital Growth (10yr)',
  ];

  CustomTextEditingController() {
    otpControllersList =
        List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  TextEditingController operator [](int index) => otpControllersList[index];

  String getOtpString() {
    return otpControllersList
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .join();
  }

  // ✅ Used by Filter screen
  String getLocationText() => locationController.text;

  // ✅ Used by Filter screen Reset/Clear All
  void clearLocationIfAny() {
    locationController.clear();
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

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String get fullPhoneNumber => phoneNumber.value.phoneNumber ?? '';
  String get dialCode => phoneNumber.value.dialCode ?? '';

  void clearAll() {
    profileImagePath.value = '';
    dateOfBirth.value = '';
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    searchingController.clear();
    countryController.clear();
    locationController.clear(); // ✅

    selectedGender.value = 'Male';
    phoneNumber.value = PhoneNumber(isoCode: 'US');

    selectedROIGrowthFilter.value = 'Select';
    selectedLoanTerm.value = 'Select';

    clearOtpFields();
  }

  void clearOtpFields() {
    for (var controller in otpControllersList) {
      controller.clear();
    }
    for (var node in focusNodes) {
      node.unfocus();
    }
    enteredOtp.value = '';
  }

  // ✅ Do NOT dispose if permanent (avoid disposed error)
  @override
  void onClose() {
    // If you used permanent:true, GetX won't call onClose normally.
    // But still keep safe:
    super.onClose();
  }
}
