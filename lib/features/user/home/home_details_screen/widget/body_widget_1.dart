import 'package:flutter/material.dart';

class BodyWidget1 extends StatefulWidget {
  const BodyWidget1({
    super.key,
    required this.starCount,
    this.ratingPercentage,
    this.totalRating,
    this.buttonText,
    this.buttonCallBack,
    this.description = '',
  });

  final int starCount;
  final String? ratingPercentage;
  final String? totalRating;
  final String? buttonText;
  final VoidCallback? buttonCallBack;
  final String description;

  @override
  State<BodyWidget1> createState() => _BodyWidget1State();
}

class _BodyWidget1State extends State<BodyWidget1> {
  bool _isExpanded = false;
  static const int _maxLines = 3; // প্রথমে ৩ লাইন দেখাবে

  @override
  Widget build(BuildContext context) {
    // যদি ডেসক্রিপশন খুব ছোট হয় তাহলে Read more দেখানোর দরকার নেই
    final bool needsReadMore = widget.description.split('\n').length > _maxLines ||
        widget.description.length > 150; // approximate check

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stars in a Row (not ListView)
                Row(
                  children: List.generate(
                    widget.starCount,
                        (_) => const Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${widget.ratingPercentage ?? ''} (${widget.totalRating ?? ''} Ratings)",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: widget.buttonCallBack,
              child: Container(
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    widget.buttonText ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Description with expandable
        Text(
          widget.description,
          maxLines: _isExpanded ? null : _maxLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (needsReadMore)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _isExpanded ? "Read less" : "...Read more",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }
}