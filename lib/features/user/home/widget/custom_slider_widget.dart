import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({super.key, this.image, this.text});

  final String? image;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,  // Align text to the bottom-left
      children: [
        // Image container with fixed height and width
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            "$image",
            height: 109, // Set height explicitly
            width: 158,  // Set width explicitly
            fit: BoxFit.cover,  // Ensure the image fills the space properly
          ),
        ),
        // Text overlay with padding and alignment
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$text",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis, // Prevent text overflow
          ),
        ),
      ],
    );
  }
}
