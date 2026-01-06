import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/my_profile_controller.dart';

class MyProfileView extends StatefulWidget {
  MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  //final ProfileApiController controller = Get.find<ProfileApiController>();

  @override
  void initState() {
   // controller.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Column(
            children: [
              Text(
                "Profile",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              /// ---------------- PROFILE PICTURE ----------------
              Obx(() {
                return Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage('${controller.userProfile.value.profileImage}'),
                  ),
                );
              }),

              const SizedBox(height: 10),

              /// ---------------- USER NAME ----------------
              Obx(() {
                return Text(
                  "${controller.userProfile.value.firstName} ${controller.userProfile.value.lastName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                );
              }),

              const SizedBox(height: 25),

              /// ---------------- MENU LIST ----------------
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _menuItem(
                      icon: Icons.person_outline,
                      title: "Edit Profile",
                      onTap: () {
                        // Navigate to Edit Profile screen with callback
                        Get.to(() => EditProfileScreen())?.then((result) {
                          if (result == true) {
                            // Refresh profile data when coming back from edit
                            controller.getProfile();
                          }
                        });
                      },
                    ),
                    _menuItem(
                      icon: Icons.pin_drop_outlined,
                      title: "Address",
                      onTap: () {
                        Get.to(() => ShippingAddressScreen());
                      },
                    ),
                    _menuItem(
                      icon: Icons.lock_outline,
                      title: "Privacy Policy",
                      onTap: () {
                        Get.to(() => PrivacyPolicyView());
                      },
                    ),
                    const SizedBox(height: 10),

                    /// ---------------- LOGOUT ----------------
                    _menuItem(
                      icon: Icons.logout,
                      title: "Log out",
                      isLogout: true,
                      onTap: () {
                        _showCustomDialog(
                          context: context,
                          title: "Are you sure you want to log out?",
                          subtitle: "Thank you for spending time with us",
                          confirmText: "Log Out",
                          onConfirm: _logout,
                        );
                      },
                    ),
                    _menuItem(
                      icon: Icons.delete,
                      title: "Account Delete",
                      isLogout: true,
                      onTap: () {
                        _showCustomDialog(
                          context: context,
                          title: "Are you sure you want to delete account?",
                          subtitle: "Thank you for spending time with us",
                          confirmText: "Delete Account",
                          onConfirm: _deleteAccount,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),*/
    );
  }

  /// ---------------- REUSABLE LIST ITEM ----------------
  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: isLogout ? Colors.red : Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? Colors.red : Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                /// Subtitle
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),

                const SizedBox(height: 24),

                /// Buttons
                Row(
                  children: [
                    /// CANCEL BUTTON
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    /// CONFIRM BUTTON
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECEC1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          confirmText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

/*  Future<void> _logout() async {
    bool isSuccess = await controller.logout();
    if (isSuccess) {
      Get.snackbar('Success', 'Logged out successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _deleteAccount() async {
    bool isSuccess = await controller.deleteAccount();
    if (isSuccess) {
      Get.snackbar('Success', 'Account deleted successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }*/
}