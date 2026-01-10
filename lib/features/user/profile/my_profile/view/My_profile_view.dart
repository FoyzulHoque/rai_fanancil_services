import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/profile/my_profile/edit%20profile/screen/personal_info_screen.dart';
import '../../subscription plan/screen/subscription_plan.dart';
import '../controller/switch_controller.dart';
import '../widget/item_menue_widget.dart';
import '../widget/notification_widget.dart';
import '../widget/profile_head_widget.dart';
import '../widget/show_show_custom_dialog_widget.dart';

class MyProfileView extends StatelessWidget {
   MyProfileView({super.key});
final SwitchController switchController=Get.put(SwitchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            ProfileHeadWidget(
              imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=40",
              email: "john.doe@example.com",
            ),

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
                      onConfirm: () {
                        Get.back();
                      },
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
                      onConfirm: () {
                        Get.back();
                      },
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
}
