import 'package:flutter/material.dart';

class CustomBackgroundWidget extends StatelessWidget {
  const CustomBackgroundWidget({
    super.key,
    this.topLeft = 0.0,
    this.topRight = 0.0,
    this.bottomLeft = 0.0,
    this.bottomRight = 0.0,
    required this.containerHeight,
    this.image, // asset path, e.g., "assets/images/background.jpg"
    required this.child,
  });

  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final double containerHeight;
  final String? image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get view width dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: containerHeight,
      width: screenWidth, // Use the view width here
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
        image: image != null
            ? DecorationImage(
          image: AssetImage(image!),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: child,
    );
  }
}
