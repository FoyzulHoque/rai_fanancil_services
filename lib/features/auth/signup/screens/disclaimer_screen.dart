import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../user/user navbar/user_navbar_screen.dart';

class DisclaimerPage extends StatelessWidget {
  DisclaimerPage({super.key});

  // ✅ State inside Stateless using ValueNotifier
  final ValueNotifier<bool> _accepted = ValueNotifier<bool>(false);

  static const Color kPrimary = Color(0xFF24BAED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 18),

              // Title
              const Text(
                "Disclaimer",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Divider(
                color: AppColors.primary,
                thickness: 2,
              ),

              const SizedBox(height: 10),

              // Scrollable text area (like screenshot)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Forem ipsum dolor sit amet, consectetur adipiscing elit. "
                            "Etiam eu turpis molestie, dictum est a, mattis tellus. "
                            "Sed dignissim, metus nec fringilla accumsan, risus sem "
                            "sollicitudin lacus, ut interdum tellus elit sed risus. "
                            "Maecenas eget condimentum velit, sit amet feugiat lectus. "
                            "Class aptent taciti sociosqu ad litora torquent per conubia nostra, "
                            "per inceptos himenaeos. Praesent auctor purus luctus enim egestas, "
                            "ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac "
                            "rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi "
                            "convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.\n\n"
                            "Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque "
                            "quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo "
                            "vestibulum venenatis. Suspendisse quis arcu sem. Aenean feugiat ex eu "
                            "vestibulum vestibulum. Morbi a eleifend magna. Nam metus lacus, "
                            "porttitor eu mauris a, blandit ultrices nibh. Mauris sit amet magna "
                            "non ligula vestibulum eleifend. Nulla varius volutpat turpis sed "
                            "lacinia. Nam eget mi in purus lobortis eleifend. Sed nec ante dictum "
                            "sem condimentum ullamcorper quis venenatis nisi. Proin vitae facilisis "
                            "nisi, ac posuere leo.",
                        style: TextStyle(
                          fontSize: 15.6,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 18),
                    ],
                  ),
                ),
              ),

              // Checkbox row
              ValueListenableBuilder<bool>(
                valueListenable: _accepted,
                builder: (context, accepted, _) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 22,
                        width: 22,
                        child: Checkbox(
                          value: accepted,
                          activeColor: kPrimary,
                          onChanged: (v) => _accepted.value = v ?? false,
                          side: const BorderSide(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "By clicking this,\nI am accepting this disclaimer",
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.3,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 18),

              // Continue button (works only when checked)
              ValueListenableBuilder<bool>(
                valueListenable: _accepted,
                builder: (context, accepted, _) {
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: accepted
                          ? () {
                        Get.offAll(() => const UserBottomNavbar());
                      }
                          : null, // disabled until checked
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.primary.withOpacity(0.35),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text(
                        "Continue to Home",
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
