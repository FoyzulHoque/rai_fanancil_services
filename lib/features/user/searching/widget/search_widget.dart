import 'package:flutter/material.dart';

class SearchsWidget extends StatelessWidget {
   SearchsWidget({super.key});
  final TextEditingController? searchingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextFormField(
        controller: searchingController,
        decoration: InputDecoration(
          hintText: 'Search location, suburb...',
          prefixIcon: const Icon(Icons.search),

          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
        ),
      ),

    );
  }
}
