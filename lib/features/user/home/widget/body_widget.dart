import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class UserBodyWidget extends StatefulWidget {
  final String? locationImage;
  final String? locationName;
  final String? title;
  final String? presentRating;
  final String? totalRating;
  final String? amount;
  final bool initialIsLike;

  const UserBodyWidget({
    super.key,
    this.locationImage,
    this.locationName,
    this.title,
    this.amount,
    this.presentRating,
    this.totalRating,
    required this.initialIsLike,
  });

  @override
  _UserBodyWidgetState createState() => _UserBodyWidgetState();
}

class _UserBodyWidgetState extends State<UserBodyWidget> {
  late bool isLike;

  @override
  void initState() {
    super.initState();
    // Initialize isLike with the initial value passed
    isLike = widget.initialIsLike;
  }

  // Simulate API Call to toggle favorite status
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
    return Stack(
      children: [
        Center(
          child: Container(
            width: 335,
            height: 328,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 335,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            "${widget.locationImage}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColors,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${widget.locationName}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber.shade500),
                    const SizedBox(width: 5),
                    Text(
                      "${widget.presentRating}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "(${widget.totalRating}) Ratings",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "\$${widget.amount} /night",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}