import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/themes/app_colors.dart';
import '../../otp/screen/otp_screen.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../controller/send_email_with_otp_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  CustomTextEditingController accountTextEditingController =
  Get.find<CustomTextEditingController>();
  ResetPasswordController resetPasswordController = Get.put(
    ResetPasswordController(),
  );

  // Focus nodes for highlighting on focus
  final FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    accountTextEditingController.emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColors,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColors,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Scrollable
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(ForgetPasswordScreen()),
                      child: Text(
                        "Forget Password".tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      "Select which contact details should we use to reset your password"
                          .tr,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Center(
                child: Container(
                  height: 277,
                  width: 247.26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset("assets/images/forget_images.png"),
                ),
              ),
              const SizedBox(height: 40),

              // Email Field
              Container(
                height: 85,
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.black, width: 1),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/icons/email_logo.png"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            "Email Address".tr,
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              controller:
                              accountTextEditingController.emailController,
                              focusNode: emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "example@email.com".tr,
                                border: InputBorder.none,
                                /*focusedBorder: OutlineInputBorder(
                                  // Blue on focus
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                  const BorderSide(color: AppColors.primary),
                                ),*/
                                /*border: OutlineInputBorder(),*/
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _otpApiCallMethod,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Continue".tr,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _otpApiCallMethod() async {
    Get.to(() => OtpScreen());
    /*bool isSuccess = await resetPasswordController.resetPasswordApiCallMethod();
    if (isSuccess) {
      Get.to(() => OtpScreen());
    } else {
      //Get.snackbar("Error", "Something went wrong".tr);
    }*/
  }
}
