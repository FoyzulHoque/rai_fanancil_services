import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class CustomNotificationToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomNotificationToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.notifications_outlined,
        color: Colors.black54,
        size: 28,
      ),
      title: const Text(
        "Notification",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing:  GestureDetector(
        onTap: () {
          onChanged(!value);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: 45.0,
          height: 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: value ? AppColors.primary : Colors.grey[400],
          ),
          child: AnimatedAlign(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}