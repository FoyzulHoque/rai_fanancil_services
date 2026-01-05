import 'package:flutter/material.dart';

class UserMapWidget extends StatefulWidget {
  final String? worldMapImage;
  final String? countryName;
  final bool selectCountry;

  const UserMapWidget({
    super.key,
    this.worldMapImage,
    this.countryName,
    required this.selectCountry,
  });

  @override
  _UserMapWidgetState createState() => _UserMapWidgetState();
}

class _UserMapWidgetState extends State<UserMapWidget> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.selectCountry; // Initialize state based on passed data
  }

  // Method to handle the selection on tap
  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection, // Toggle selection when tapped
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 124,
                width: 124,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isSelected ? Colors.blue : Colors.grey, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "${widget.worldMapImage}",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      // Return a placeholder image on error
                      return Image.network(
                        'https://via.placeholder.com/150', // Placeholder image
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${widget.countryName}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
