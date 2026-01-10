import 'package:flutter/material.dart';

class ProfileHeadWidget extends StatelessWidget {
  const ProfileHeadWidget({super.key, this.imageUrl, this.email});

  final String? imageUrl;
  final String? email;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 28),
      child: Column(
        children: [
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
