import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

import '../../controller/edit_profile_controller.dart';

// ────────────────────────────────────────────────

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final EditProfileController controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue header with profile picture
          Container(
            width: double.infinity,
            color: AppColors.secondaryColors,
            padding: const EdgeInsets.only(top: 24, bottom: 32),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 26),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Your personal info',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                          () => CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage:
                          controller.newProfileImagePath.value.isNotEmpty
                              ? FileImage(
                              File(controller.newProfileImagePath.value)) 
                              : (controller.profileCtrl.userProfile.value.profileImage != null
                              ? NetworkImage(controller.profileCtrl.userProfile.value.profileImage!)
                              : null) as ImageProvider?,
                          child: controller.newProfileImagePath.value.isEmpty &&
                              controller.profileCtrl.userProfile.value.profileImage == null
                              ? const Icon(Icons.person, size: 50, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Form fields
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  _buildTextField(
                    icon: Icons.person_outline,
                    label: "First name",
                    controller: controller.firstNameCtrl,
                    hint: "Enter first name",
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    icon: Icons.person_outline,
                    label: "Last name",
                    controller: controller.lastNameCtrl,
                    hint: "Enter last name",
                  ),
                  const SizedBox(height: 16),
                  Obx(
                        () => _buildSelectableField(
                      icon: Icons.calendar_today_outlined,
                      label: "Date of birth",
                      value: controller.dateTime.value.isEmpty ? "Select date" : controller.dateTime.value,
                      onTap: () => _selectDate(context),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    icon: Icons.location_on_outlined,
                    label: "Location",
                    controller: controller.location,
                    hint: "Enter your location",
                  ),
                  const SizedBox(height: 40),
                  Obx(
                        () => SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.hasChanges.value
                            ? () => controller.saveChanges()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.hasChanges.value
                              ? AppColors.primary
                              : Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Save changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // HELPER FUNCTIONS
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

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableField({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade700, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
