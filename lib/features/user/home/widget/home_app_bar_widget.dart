import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class HomeAppBarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final int notificationCount;

  const HomeAppBarWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.onProfileTap,
    this.onNotificationTap,
    this.notificationCount = 0,
  });

  String _getGreetingWord() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "Good Morning";
    if (hour >= 12 && hour < 17) return "Good Afternoon";
    if (hour >= 17 && hour < 21) return "Good Evening";
    return "Good Night";
  }

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());
    final userName = (name ?? "User").trim().isEmpty ? "User" : name!.trim();

    return Container(
      width: double.infinity,
      color: AppColors.secondaryColors,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 52, bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ small avatar like screenshot
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.6),
              ),
              child: ClipOval(
                child: (imageUrl != null && imageUrl!.trim().isNotEmpty)
                    ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.white.withOpacity(0.25),
                      child: const Icon(Icons.person, size: 20, color: Colors.white),
                    );
                  },
                )
                    : Container(
                  color: Colors.white.withOpacity(0.25),
                  child: const Icon(Icons.person, size: 20, color: Colors.white),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ✅ date + greeting line like screenshot
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateText,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "${_getGreetingWord()}, $userName!",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ✅ Keep notification area available (optional)
          // (You can uncomment and style later if you want it on header)
        ],
      ),
    );
  }
}
