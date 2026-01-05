import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double size;
  final Color color;

  // Constructor to customize the loading widget
  const CustomLoadingWidget({
    Key? key,
    this.size = 50.0, // Default size
    this.color = Colors.white, // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: color,
        size: size,
      ),
    );
  }
}
