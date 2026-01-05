
// lib/core/di/dependency_injection.dart
import 'package:get/get.dart';

import '../auth/signin/controller/login_controller.dart';
import '../auth/signup/controller/signup_api_controller.dart';
import '../auth/text editing controller/custom_text_editing_controller.dart';
import '../host/home/controller/create_cart_api_controller.dart';
import '../host/home/controller/home_api_controller.dart';
import '../host/home/controller/searching_api_controller.dart';
import '../host/profile/my_profile/controller/my_profile_controller.dart';
import '../user/user navbar/navbar_controller.dart';

class GetXDependencyInjection extends Bindings{

  @override
  void dependencies() {
    // ====== TextEditingControllers ======
    Get.lazyPut(() => CustomTextEditingController(), fenix: true);

    // ====== Auth ======
    Get.lazyPut(() => LoginApiController(), fenix: true);
    Get.lazyPut(() => SignupApiController(), fenix: true);

    // ====== Home & Search ======
    Get.lazyPut(() => HomeApiController(), fenix: true);
    Get.lazyPut(() => SearchingApiController(), fenix: true);

    // ====== Cart ======
    Get.lazyPut(() => CreateCartApiController(), fenix: true);

    // ====== Profile ======
    Get.lazyPut(() => ProfileApiController(), fenix: true);


    // ====== Bottom Navbar ======
    Get.lazyPut(() => UserBottomNavbarController(), fenix: true);

  }
}


