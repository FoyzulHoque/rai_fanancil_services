// features/auth/signup_verification/screens/signup_otp_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../user/user navbar/user_navbar_screen.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../controller/signup_otp_controller.dart';

class SignupOtpScreens extends StatefulWidget {
  const SignupOtpScreens({super.key});

  @override
  _SignupOtpScreenState createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreens> { // Fixed class name
  final SignupOtpController otpController = Get.put(SignupOtpController());
  final CustomTextEditingController textCtrl = Get.find<CustomTextEditingController>();

  @override
  void initState() {
    super.initState();
    // Clear any previous OTP when view loads
    textCtrl.clearOtpFields();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < CustomTextEditingController.otpLength - 1) {
      FocusScope.of(context).requestFocus(textCtrl.focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(textCtrl.focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Verify Your Email'.tr,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent a verification code to your email. Please check your inbox and enter the code below to verify your account.'.tr,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                textCtrl.emailController.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(CustomTextEditingController.otpLength, (index) {
                  return SizedBox(
                    width: 56,
                    height: 56,
                    child: TextField(
                      controller: textCtrl.otpControllersList[index],
                      focusNode: textCtrl.focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) {
                        _onChanged(value, index);
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Timer and Resend Section
              Obx(() => Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(text: 'Resend code in '.tr),
                        TextSpan(
                          text: '${otpController.secondsRemaining.value} s',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Resend Code Button
                  GestureDetector(
                    onTap: otpController.canResend.value && !otpController.isLoading.value
                        ? () => _handleResendOtp()
                        : null,
                    child: Text(
                      'Resend Code'.tr,
                      style: TextStyle(
                        color: otpController.canResend.value && !otpController.isLoading.value
                            ? AppColors.primary
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )),

              const SizedBox(height: 40),

              // Verify Button using CustomFloatingButton
              Obx(() {
                // Create a different widget when loading
                if (otpController.isLoading.value) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: null, // Disabled during loading
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.btncolor.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Verifying...'.tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomFloatingButton(
                      onPressed: () => _handleVerifyOtp(),
                      buttonText: 'Verify & Continue'.tr,
                      height: 50.0,
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Wrap verifyOtp in a void-returning function
  void _handleVerifyOtp() {
    verifyOtp();
  }

  // Wrap resendOtp in a void-returning function
  void _handleResendOtp() {
    resendOtp();
  }

  // Verify OTP
  Future<void> verifyOtp() async {
    final otp = textCtrl.getOtpString();

    if (otp.length != 4 || !RegExp(r'^\d{4}$').hasMatch(otp)) {
      Get.snackbar(
        "Error".tr,
        "Please enter a valid 4-digit OTP".tr,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    bool isSuccess = await otpController.verifySignupOtp();
    if (isSuccess) {
      Get.offAll(() => const UserBottomNavbar());
      // After successful verification, navigate to bottom navigation bar
    } else {
      if (otpController.errorMessage != null) {

        Get.snackbar(
          "Error".tr,
          otpController.errorMessage!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  // Resend OTP
  Future<void> resendOtp() async {
    if (otpController.isLoading.value) return;

    bool isSuccess = await otpController.resendOtp();
    if (!isSuccess) {
      Get.snackbar(
        "Error".tr,
        "Failed to resend OTP".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}