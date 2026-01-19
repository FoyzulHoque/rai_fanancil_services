import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/profile/my_profile/edit%20profile/screen/personal_info_screen.dart';
import '../../../../auth/signin/screens/signin_screens.dart';
import '../../../../auth/signup/screens/signup_screen.dart';
import '../../subscription plan/screen/subscription_plan.dart';
import '../controller/my_profile_controller.dart';
import '../controller/switch_controller.dart';
import '../widget/item_menue_widget.dart';
import '../widget/notification_widget.dart';
import '../widget/profile_head_widget.dart';
import '../widget/show_show_custom_dialog_widget.dart';

class MyProfileView extends StatelessWidget {
   MyProfileView({super.key});

final SwitchController switchController=Get.put(SwitchController());

final ProfileApiController profileApiController=Get.put(ProfileApiController());

  @override
  Widget build(BuildContext context) {
    final urlClt=profileApiController.userProfile;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Obx((){
              return ProfileHeadWidget(
              imageUrl: "${urlClt.value.profileImage}",
      email: "${urlClt.value.email}",
      );
            }),
            // Profile Header
            const SizedBox(height: 24),

            // Account Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // List Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Obx(()=> CustomNotificationToggle(
                    value: switchController.isSwitched.value,
                    onChanged: (val) {
                      // Handle notification toggle
                      switchController.toggleSwitch(val);
                    },
                  ),),
                  ItemMenuWidget(
                    icon: Icons.person_outline_rounded,
                    title: "Your personal info",
                    onTap: () => Get.to(() =>  PersonalInfoScreen()),
                    isLogout: false,
                  ),
                  ItemMenuWidget(
                    icon: Icons.subscriptions_outlined,
                    title: "Subscription Plans",
                    onTap: (){
                      Get.to(()=>SubscriptionPlansScreen());
                    },
                    isLogout: false,
                  ),
                  ItemMenuWidget(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () => showCustomDialog(
                      context: context,
                      cancelText: "Cancel",
                      confirmText: "Confirm",
                      confirmColor: AppColors.red,
                      onConfirm: _logoutApiCall,
                      subtitle: "Are you sure you want to logout?",
                      title: "Logout",
                    ),
                    isLogout: true,
                  ),
                  ItemMenuWidget(
                    icon: Icons.delete,
                    title: "Delete Account",
                    onTap: () => showCustomDialog(
                      context: context,
                      cancelText: "Cancel",
                      confirmText: "Confirm",
                      confirmColor: AppColors.red,
                      onConfirm: _userDeleteAccount,
                      subtitle: "Are you sure you want to Delete?",
                      title: "Delete",
                    ),
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logoutApiCall() async{
    bool isSuccess=await profileApiController.logout();
    if (isSuccess) {
      Get.offAll(()=>LoginScreen());
    }
  }

  Future<void> _userDeleteAccount()async {
    bool isSuccess = await profileApiController.deleteAccount();
    if (isSuccess) {
      Get.offAll(()=>SignUpScreen());
    }
  }
}
