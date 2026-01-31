// lib/core/di/dependency_injection.dart
import 'package:get/get.dart';
import 'package:rai_fanancil_services/features/user/home/controller/home_dashboard_controller.dart';
import 'package:rai_fanancil_services/features/user/property/controller/saved_properties_controller.dart';
import 'package:rai_fanancil_services/features/user/searching/controller/all_properties_controller.dart';

import '../auth/signin/controller/login_controller.dart';
import '../auth/signup/controller/signup_api_controller.dart';
import '../auth/text editing controller/custom_text_editing_controller.dart';
import '../user/financial calculators/property investment/controller/select_custom_button_controller.dart';
import '../user/profile/my_profile/controller/edit_profile_controller.dart';
import '../user/profile/my_profile/controller/my_profile_controller.dart';
import '../user/searching/searching filter/controller/pricing_controller.dart';
import '../user/user navbar/controller/navbar_controller.dart';

class GetXDependencyInjection extends Bindings {
  @override
  void dependencies() {
    // ====== TextEditingControllers ======
    Get.lazyPut(() => CustomTextEditingController(), fenix: true);

    // ====== Auth ======
    Get.lazyPut(() => LoginApiController(), fenix: true);
    Get.lazyPut(() => SignupApiController(), fenix: true);

    // ====== Home & Search ======

    // ====== Profile ======
    Get.lazyPut(() => ProfileApiController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);

    Get.lazyPut(() => LoanTypeController());

    // ====== Bottom Navbar ======
    Get.lazyPut(() => UserBottomNavbarController(), fenix: true);
    Get.lazyPut(
      () => PriceRangeController(
        minLimit: 0,
        maxLimit: 1000000,
        initialMin: 0,
        initialMax: 1000000,
      ),
      fenix: true,
    );
    // user dashboard
    Get.lazyPut(() => HomeDashboardController(), fenix: true);
    // user saved properties
    Get.lazyPut(() => SavedPropertiesController(), fenix: true);
    // search page
    Get.lazyPut(() => AllPropertiesController(), fenix: true);
  }
}
