import 'package:flutter/material.dart';

class GlobalInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final double height;

  const GlobalInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePassword,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Row(
        children: [
          /// Prefix Icon (Optional)
          if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 10)],

          /// TextField
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: isPassword && !isPasswordVisible,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ),

          /// Password Toggle Icon
          if (isPassword)
            GestureDetector(
              onTap: onTogglePassword,
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 20,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
