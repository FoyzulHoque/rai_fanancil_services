import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_field.dart';
import '../../../user/financial data collection/view/set_up_your_financial_profile.dart';
import '../../../user/user navbar/user_navbar_screen.dart';
import '../../forget password/screen/forget_password_screen.dart';
import '../../signup/screens/signup_screen.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final CustomTextEditingController customTextEditingController=Get.put(CustomTextEditingController());
  final LoginApiController _loginCtrl=Get.put(LoginApiController());
  bool _isRememberMeChecked = false;
  bool _isPasswordVisible = false;  // Add this variable for password visibility toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 0, // Hides the default AppBar
        backgroundColor: Colors.transparent, // Make it transparent
      ),
      body: SingleChildScrollView( // Wrap the entire body inside a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo at the top (centered)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0), // Top padding
                  child: Image.asset(
                    'assets/icons/logo_withtext.png', // Path to your logo image
                    height: 200, // Increased logo size
                    width: 200, // Increased logo size
                  ),
                ),
              ),
              SizedBox(height: 20), // Gap between logo and text fields

              Text(
                'Login to Your Account',
                style: AppTextStyles.title.copyWith(
                  fontSize: 24, // Adjust title size
                  fontWeight: FontWeight.bold, // Make it bolder
                  color: Colors.black
                ),
              ),
              SizedBox(height: 32), // Gap before text fields

              // Custom Email Text Field
              CustomTextField(
                controller: customTextEditingController.emailController,
                hintText: 'Enter Email Address',
                prefixIcon: 'assets/icons/email.png',
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: customTextEditingController.passwordController,
                hintText: 'Enter Password',
                prefixIcon: 'assets/icons/lock.png',
                obscureText: !_isPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.subcolor, // Change color as needed
                  ),
                ),
              ),
              SizedBox(height: 16), // Gap after text fields

              // Remember Me and Forgot Password
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _isRememberMeChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isRememberMeChecked = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  Text(
                    'Remember Me',
                    style: AppTextStyles.body.copyWith(fontSize: 16,color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 24), // Gap before the login button

              // Login Button
              CustomFloatingButton(
                customBackgroundColor: AppColors.primary,
                textColors: AppColors.white,
                onPressed:(){
                  Get.offAll(()=>UserBottomNavbar());
                }, // _apiCallButton,
                buttonText: 'Log in',
                 
              ),
              SizedBox(height: 10), // Gap after the login button
              TextButton(
                onPressed: () {
                  Get.to(()=>ForgetPasswordScreen());
                  print('Forgot Password?');
                },
                child: Text(
                  'Forgot the password?',
                  style: AppTextStyles.body.copyWith(
                      fontSize: 16,
                      color: AppColors.primary // Color for the link
                  ),
                ),
              ),
              SizedBox(height: 12), // Gap after the login button
              // Text: Already have an account? + Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey, // Grey color for this text
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to((SignUpScreen()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Bold and black text
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _apiCallButton() async {

    final isSuccess = await _loginCtrl.loginApiMethod();

    if (isSuccess) {
      if (_loginCtrl.userModel?.role == 'User') {
       Get.to(()=> UserBottomNavbar());
      } /*else if (_loginCtrl.userModel?.role == 'Host') {
        Get.to(()=> SetUpYourFinancialProfile());
      }*/ else {
        Get.snackbar(
          "Login Failed",
          "Role did not match",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid email or password",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
