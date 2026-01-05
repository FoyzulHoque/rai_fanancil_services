import 'package:flutter/material.dart';

class CustomAppBarDetailsWidget extends StatefulWidget {
  CustomAppBarDetailsWidget({super.key, this.arrowBack, this.initialIsLike});
  final VoidCallback? arrowBack;
  final bool? initialIsLike;

  @override
  State<CustomAppBarDetailsWidget> createState() =>
      _CustomAppBarDetailsWidgetState();
}

class _CustomAppBarDetailsWidgetState extends State<CustomAppBarDetailsWidget> {
  late bool isLike;

  @override
  void initState() {
    super.initState();
    // Initialize isLike with the initial value passed, or set to false if null
    isLike = widget.initialIsLike ?? false; // Defaulting to false if null
  }

  Future<void> toggleFavorite() async {
    setState(() {
      isLike = !isLike;
    });

    // Simulate API response with a delay
    await Future.delayed(Duration(seconds: 1));

    // Simulate the response, where true means liked (color red) and false means unliked (color gray)
    if (isLike) {
      print("API: Favorite is true");
    } else {
      print("API: Favorite is false");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.arrowBack,
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child:  Icon(Icons.arrow_back_ios,size: 20, color: Colors.black),

            ),
          ),
        ),
        Spacer(),
        Center(
          child: IconButton(
            onPressed: toggleFavorite, // Toggle favorite status on button press
            icon: isLike
                ? Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            )
                : Icon(
              Icons.favorite_border,
              color: Colors.grey,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
