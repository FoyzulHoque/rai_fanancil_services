import 'package:flutter/material.dart';

class DetailsSliderWidget extends StatefulWidget {
  const DetailsSliderWidget({
    super.key,
    required this.images,
    this.selectImage = false, // এটা যদি ভবিষ্যতে দরকার হয়
  });

  final List<String> images;
  final bool selectImage;

  @override
  State<DetailsSliderWidget> createState() => _DetailsSliderWidgetState();
}

class _DetailsSliderWidgetState extends State<DetailsSliderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final int totalImages = widget.images.length;

    return Stack(
      children: [
        // Main Image Slider
        SizedBox(
          height: 300,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: totalImages,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.images[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                );
              },
            ),
          ),
        ),

        // Dots Indicator
        Positioned(
          bottom: 40, // কাউন্টারের সাথে ওভারল্যাপ না হওয়ার জন্য উপরে তুলেছি
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalImages,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.orangeAccent
                      : Colors.grey.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),

        // Image Count Badge (e.g., 1 / 10)
        Positioned(
          bottom: 12,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${_currentIndex + 1} / $totalImages",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}