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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 24,
                color: isLogout ? Colors.red : Colors.black87,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title ?? 'Menu Item', // fallback if title is null
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? Colors.red : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isLogout ? Colors.red.withOpacity(0.7) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}