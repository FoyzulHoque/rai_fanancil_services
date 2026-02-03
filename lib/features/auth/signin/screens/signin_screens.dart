import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_field.dart';
import '../../forget password/screen/forget_password_screen.dart';
import '../../signup/screens/signup_screen.dart';
import '../../text editing controller/custom_text_editing_controller.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final CustomTextEditingController customTextEditingController =
  Get.put(CustomTextEditingController());

  final LogInController loginCtrl = Get.put(LogInController());

  bool _isRememberMeChecked = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await loginCtrl.loadRememberMeStateForExternalFields(
        emailController: customTextEditingController.emailController,
        passwordController: customTextEditingController.passwordController,
      );

      setState(() {
        _isRememberMeChecked = loginCtrl.rememberMe.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image.asset(
                    'assets/icons/logo_withtext.png',
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Login to Your Account',
                style: AppTextStyles.title.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32),

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
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.subcolor,
                  ),
                ),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _isRememberMeChecked,
                    onChanged: (bool? value) async {
                      setState(() {
                        _isRememberMeChecked = value ?? false;
                      });
                      await loginCtrl.setRememberMe(_isRememberMeChecked);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  Text(
                    'Remember Me',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // ✅ Login Button with loader inside
              Obx(
                    () => CustomFloatingButton(
                  customBackgroundColor: AppColors.primary,
                  textColors: AppColors.white,
                  isLoading: loginCtrl.isLoading.value,
                  buttonText:
                  loginCtrl.isLoading.value ? "Logging in..." : "Log in",
                  onPressed: () async {
                    await loginCtrl.onSignIn(
                      email: customTextEditingController.emailController.text,
                      password:
                      customTextEditingController.passwordController.text,
                      remember: _isRememberMeChecked,
                    );
                  },
                ),
              ),

              SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Get.to(() => ForgetPasswordScreen());
                },
                child: Text(
                  'Forgot the password?',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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
                        color: Colors.black,
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
}
