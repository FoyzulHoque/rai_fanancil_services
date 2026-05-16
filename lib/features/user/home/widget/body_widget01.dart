import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBodyWidget extends StatelessWidget {
  final Color boxColor;
  final IconData image;
  final String title;
  final String totalNumber;
  final Color iconColor;

  const UserBodyWidget({
    super.key,
    required this.boxColor,
    required this.image,
    required this.title,
    required this.totalNumber,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: boxColor,
        border: Border.all(color: const Color(0xFF0C7BB9)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalNumber,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Icon(image, color: iconColor, size: 18),
          ),
        ],
      ),
    );
  }
}
