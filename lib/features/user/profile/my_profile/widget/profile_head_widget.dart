import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class ProfileHeadWidget extends StatelessWidget {
  const ProfileHeadWidget({super.key, this.imageUrl, this.email, this.name});

  final String? imageUrl;
  final String? email;
  final String? name;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.secondaryColors,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 28),
      child: Column(
        children: [
          SizedBox(height: 20),
          // Profile Picture
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 44,
              backgroundImage: NetworkImage(
                '$imageUrl',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Email
           Text(
            "$name",
            style: TextStyle(
              color: Colors.white,
              fontSize:24,
              fontWeight: FontWeight.bold,
            ),
          ),
           Text(
            "$email",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
