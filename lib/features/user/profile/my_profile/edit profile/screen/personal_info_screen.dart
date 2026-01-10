import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../../auth/text editing controller/custom_text_editing_controller.dart';


class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final CustomTextEditingController controller = Get.find<CustomTextEditingController>();

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
                      icon: const Icon(Icons.arrow_back,color: AppColors.white,),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 26),
                    Align(
                      alignment: Alignment.topCenter,
                      child: const Text(
                        'Your personal info',
                        style: TextStyle(fontSize: 20, color:AppColors.white,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // শুধু পরিবর্তনশীল অংশটাই Obx দিয়ে wrap করা হয়েছে
                    Obx(
                          () => CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: controller.profileImagePath.value.isNotEmpty
                              ? FileImage(File(controller.profileImagePath.value))
                              : null,
                          child: controller.profileImagePath.value.isEmpty
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
                  // First Name
                  _buildTextField(
                    icon: Icons.person_outline,
                    label: "First name",
                    controller: controller.firstNameController,
                    hint: "Enter first name",
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  _buildTextField(
                    icon: Icons.person_outline,
                    label: "Last name",
                    controller: controller.lastNameController,
                    hint: "Enter last name",
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth - Reactive
                  Obx(
                        () => _buildSelectableField(
                      icon: Icons.calendar_today_outlined,
                      label: "Date of birth",
                      value: controller.dateOfBirth.value.isEmpty
                          ? "Select date"
                          : controller.dateOfBirth.value,
                      onTap: () => _selectDate(context),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location
                  _buildTextField(
                    icon: Icons.location_on_outlined,
                    label: "Location",
                    controller: controller.locationController,
                    hint: "Enter your location",
                  ),

                  const SizedBox(height: 40),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Save changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
  //                HELPER FUNCTIONS
  // ────────────────────────────────────────────────

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        controller.profileImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      controller.dateOfBirth.value = formattedDate;
    }
  }

  Future<void> _saveProfile() async {
    // এখানে আসল সেভ লজিক লিখবে (API call, validation ইত্যাদি)
    Get.snackbar(
      "Success",
      "Profile updated successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Basic Text Field
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
        borderRadius: BorderRadius.circular(12),
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

  // Selectable Field (for date, location, etc.)
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
          borderRadius: BorderRadius.circular(12),
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