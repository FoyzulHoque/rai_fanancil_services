// features/auth/signup_verification/screens/signup_otp_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../controller/signup_otp_controller.dart';
import 'disclaimer_screen.dart';

class SignupOtpScreens extends StatefulWidget {
  const SignupOtpScreens({super.key});

  @override
  _SignupOtpScreenState createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreens> {
  final SignupOtpController otpController = Get.put(SignupOtpController());
  final CustomTextEditingController textCtrl =
  Get.find<CustomTextEditingController>();

  @override
  void initState() {
    super.initState();
    textCtrl.clearOtpFields();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 &&
        index < CustomTextEditingController.otpLength - 1) {
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
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        centerTitle: false,
        title: const Text("OTP Code Verification"),
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
                'Code has been send to and***ley@yourdomain.com',
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                children:
                List.generate(CustomTextEditingController.otpLength, (index) {
                  return SizedBox(
                    width: 56,
                    height: 56,
                    child: TextField(
                      controller: textCtrl.otpControllersList[index],
                      focusNode: textCtrl.focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 12),
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
                      style: const TextStyle(
                          color: Colors.black, fontSize: 14),
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
                    onTap: otpController.canResend.value &&
                        !otpController.isLoading.value
                        ? () async {
                      await resendOtp();
                    }
                        : null,
                    child: Text(
                      'Resend Code'.tr,
                      style: TextStyle(
                        color: otpController.canResend.value &&
                            !otpController.isLoading.value
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

              // Verify Button
              Obx(() => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomFloatingButton(
                  customBackgroundColor: AppColors.primary,
                  textColors: Colors.white,
                  isLoading: otpController.isLoading.value,
                  onPressed: () async {
                    if (otpController.isLoading.value) return;
                    await verifyOtp();
                  },
                  buttonText: otpController.isLoading.value
                      ? 'Verifying...'.tr
                      : 'Verify'.tr,
                  height: 50.0,
                ),
              )),
            ],
          ),
        ),
      ),
    );
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

    final bool isSuccess = await otpController.verifySignupOtp();
    if (isSuccess) {
      Get.offAll(() => DisclaimerPage());
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

    final bool isSuccess = await otpController.resendOtp();
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
