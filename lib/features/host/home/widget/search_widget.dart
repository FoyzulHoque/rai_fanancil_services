import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController? searchingController;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final double? height;
  final double? width;

  const SearchWidget({
    super.key,
    this.searchingController,
    this.onTap,
    this.onChanged, this.height, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: TextFormField(
        controller: searchingController,
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          hintText: "Search products, brands...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 28,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        ),
      ),
    );
  }
}