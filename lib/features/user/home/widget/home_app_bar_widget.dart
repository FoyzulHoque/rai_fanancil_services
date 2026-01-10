import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class HomeAppBarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final int notificationCount; // Optional: pass 0 to hide badge

  const HomeAppBarWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.onProfileTap,
    this.onNotificationTap,
    this.notificationCount = 0,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning!";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon!";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening!";
    } else {
      return "Good Night!";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColors,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Row(
          children: [
            // Profile Avatar
            InkWell(
              onTap: onProfileTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.person, size: 28, color: Colors.grey),
                      );
                    },
                  )
                      : Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 28, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Greeting & Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   _getGreeting(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),

      // উইজেটের নিচে বা আলাদা ফাইলে
              const SizedBox(height: 2),
                  Text(
                    name ?? "User",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

           /* // Notification Bell with Badge
            InkWell(
              onTap: onNotificationTap,
              borderRadius: BorderRadius.circular(30),
              child: Badge(
                label: notificationCount > 0
                    ? Text(
                  notificationCount > 99 ? "99+" : "$notificationCount",
                  style: const TextStyle(fontSize: 10),
                )
                    : null,
                isLabelVisible: notificationCount > 0,
                backgroundColor: Colors.red,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/icons/Notification_icon.png",
                    height: 26,
                    width: 26,
                    fit: BoxFit.contain,
                    // Optional: tint if needed
                    // color: Colors.grey[800],
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}