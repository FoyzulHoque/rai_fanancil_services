import 'package:flutter/material.dart';

class ItemMenuWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onTap;
  final bool isLogout;

  const ItemMenuWidget({
    super.key,
    this.icon,
    this.title,
    this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = isLogout ? Colors.red : Colors.black87;

    // ✅ background like screenshot (light square behind icon)
    final Color iconBg = isLogout
        ? (title?.toLowerCase().contains("log") == true
        ? const Color(0xFFFFF2E6) // light orange for logout
        : const Color(0xFFFFEAEA)) // light red for delete
        : const Color(0xFFF3F3F3); // light gray for normal rows

    final Color iconColor = isLogout
        ? (title?.toLowerCase().contains("log") == true
        ? const Color(0xFFFF8A00) // orange icon for logout
        : Colors.red) // red icon for delete
        : Colors.black54;

    final Color arrowColor = isLogout
        ? (title?.toLowerCase().contains("log") == true
        ? const Color(0xFFFF8A00)
        : Colors.red)
        : Colors.grey;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFEDEDED), width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            if (icon != null)
              Container(
                height: 36,
                width: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: iconColor,
                ),
              ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title ?? 'Menu Item',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? (arrowColor) : mainColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: arrowColor,
            ),
          ],
        ),
      ),
    );
  }
}
