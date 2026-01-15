import 'dart:async';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/services_class/shared_preferences_helper.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../user/user navbar/user_navbar_screen.dart';
class SplashController extends GetxController {
  var currentSplash = 1.obs;

  @override
  void onInit() {
    super.onInit();
    startSplashSequence();
  }
  Future<void> checkIsLogin() async {
    // 1. Wait for login status
    bool? isLogin = await SharedPreferencesHelper.checkLogin(); // <-- await + ()
    String? token = await SharedPreferencesHelper.getAccessToken(); // <-- await + ()

    // 2. Splash delay
    await Future.delayed(const Duration(seconds: 3));

    print("------------Is Login: $isLogin | -------Token: $token");
    if (token != null && token.isNotEmpty) {
      if (JwtDecoder.isExpired(token)) {
        Get.offAll(() => OnboardingScreen());
        return;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      String? role = decodedToken['role'];

      if (role == 'Client') {
        Get.offAll(() =>  UserBottomNavbar());
      } /*else if (role == 'Host') {
        //Get.offAll(() => HostOwnerSplashScreen());
      }*/ else {
        Get.offAll(() =>  OnboardingScreen());
      }
    } else {
      Get.offAll(() =>  OnboardingScreen());
    }
    // 3. Navigation logic

  }


  void startSplashSequence() {
    // Wait for 3 seconds and navigate to Onboarding view
    Timer(const Duration(seconds: 3), () {
      checkIsLogin(); // Navigate to onboarding view after 3 seconds
    });
  }

}
