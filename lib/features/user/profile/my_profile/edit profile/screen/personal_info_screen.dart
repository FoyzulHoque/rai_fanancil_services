import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

import '../../controller/edit_profile_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final EditProfileController controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ✅ Top Blue Header (like screenshot)
          Container(
            width: double.infinity,
            color: AppColors.secondaryColors,
            padding: const EdgeInsets.only(top: 18, bottom: 18),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  // back circle icon
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Your personal info",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // to balance back button width
                ],
              ),
            ),
          ),

          // ✅ Avatar section (white area below header)
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(
                        () => CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                        controller.newProfileImagePath.value.isNotEmpty
                            ? FileImage(
                            File(controller.newProfileImagePath.value))
                            : (controller.profileCtrl.userProfile.value
                            .profileImage !=
                            null
                            ? NetworkImage(controller.profileCtrl
                            .userProfile.value.profileImage!)
                            : null) as ImageProvider?,
                        child: controller.newProfileImagePath.value.isEmpty &&
                            controller.profileCtrl.userProfile.value
                                .profileImage ==
                                null
                            ? const Icon(Icons.person,
                            size: 48, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),

                  // camera button
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Light blue input area (like screenshot)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                children: [
                  _flatBlueField(
                    icon: Icons.person_outline,
                    child: TextField(
                      controller: controller.firstNameCtrl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "First name",
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _flatBlueField(
                    icon: Icons.person_outline,
                    child: TextField(
                      controller: controller.lastNameCtrl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Last name",
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Obx(
                        () => _flatBlueField(
                      icon: Icons.calendar_today_outlined,
                      trailing: const Icon(Icons.chevron_right,
                          color: Colors.black45),
                      onTap: () => _selectDate(context),
                      child: Text(
                        controller.dateTime.value.isEmpty
                            ? "Date of birth"
                            : controller.dateTime.value,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: controller.dateTime.value.isEmpty
                              ? Colors.black45
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _flatBlueField(
                    icon: Icons.location_on_outlined,
                    child: TextField(
                      controller: controller.location,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Location",
                        isDense: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ✅ Save button (same functionality)
                  Obx(
                        () => SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: controller.hasChanges.value
                            ? () => controller.saveChanges()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.hasChanges.value
                              ? AppColors.primary
                              : Colors.grey.shade400,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "Save changes",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ UI helper (blue flat row like screenshot) — NO logic changed
  Widget _flatBlueField({
    required IconData icon,
    required Widget child,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFD9EEF8), // light blue like screenshot
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 20),
            const SizedBox(width: 12),
            Expanded(child: child),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // FUNCTIONALITY (UNCHANGED)
  // ────────────────────────────────────────────────
  Future<void> _pickImage() async {
    await controller.pickImage();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.dateTime.value.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(controller.dateTime.value)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.dateTime.value = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
