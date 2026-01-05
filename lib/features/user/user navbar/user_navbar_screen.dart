import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bookings/screen/bookings_screen.dart';
import '../chat/screen/chat_screen.dart';
import '../home/screen/home_screen.dart';
import '../profile/my_profile/view/My_profile_view.dart';
import '../wishlist/screen/wishlist_screen.dart';
import 'navbar_controller.dart';

class UserBottomNavbar extends StatefulWidget {
  final int initialIndex;
  const UserBottomNavbar({super.key, this.initialIndex = 0});

  @override
  State<UserBottomNavbar> createState() => _UserBottomNavbarState();
}

class _UserBottomNavbarState extends State<UserBottomNavbar> {
  late final UserBottomNavbarController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UserBottomNavbarController(widget.initialIndex));
  }

  final List<Widget> pages = [
    HomeScreen(),       // index 0
    WishlistScreen(),       // index 1  → Cart
    BookingsScreen(),      // index 2
    ChatScreen(),    // index 3  → Profile
    MyProfileView(),    // index 3  → Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Container(
        height: 54,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(
                activeImage: "assets/icons/nav1_bold.png",
                passiveImage: "assets/icons/nav1.png",
                index: 0,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                activeImage: "assets/icons/nav2_bold.png",
                passiveImage: "assets/icons/nav2.png",
                index: 1, // Cart icon
              ),
            ),
            Expanded(
              child: _buildNavItem(
                activeImage: "assets/icons/nav3_bold.png",
                passiveImage: "assets/icons/nav3.png",
                index: 2,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                activeImage: "assets/icons/nav4_bold.png",
                passiveImage: "assets/icons/nav4.png",
                index: 3, // Profile icon
              ),
            ), Expanded(
              child: _buildNavItem(
                activeImage: "assets/icons/nav5_bold.png",
                passiveImage: "assets/icons/nav5.png",
                index: 4, // Profile icon
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;

        return Container(
          decoration: BoxDecoration(

            /*border: Border(
              top: BorderSide(
                color: isSelected ? const Color(0xFF0071E9) : Colors.transparent,
                width: 2,
              ),
            ),*/
          ),
          alignment: Alignment.center,
          child: Image.asset(
            isSelected ? activeImage : passiveImage,
            height: 28,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 30, color: Colors.grey);
            },
          ),
        );
      }),
    );
  }
}