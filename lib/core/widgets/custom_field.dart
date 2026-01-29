import 'package:flutter/material.dart';

// Custom Text Field Widget (Soft active background like your 2nd image)
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon; // asset path
  final Widget? suffixIcon;
  final bool obscureText;

  final Color activeColor;     // Color(0xFF24BAED)
  final double activeOpacity;  // light bg opacity
  final Color inactiveColor;
  final double borderRadius;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.activeColor = const Color(0xFF24BAED),
    this.activeOpacity = 0.12, // ✅ this makes it look like 2nd image
    this.inactiveColor = const Color(0xffFAFAFA),
    this.borderRadius = 0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (mounted) setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = _isFocused
        ? widget.activeColor.withOpacity(widget.activeOpacity)
        : widget.inactiveColor;
    final iconColor = _isFocused
        ? widget.activeColor
        : Colors.grey.withOpacity(0.7);

    final hintColor =
    _isFocused ? widget.activeColor : Colors.grey.withOpacity(0.7);

    final textColor = _isFocused ? Colors.black38 : Colors.black87;

    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      cursorColor: widget.activeColor,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: hintColor),

        prefixIcon: (widget.prefixIcon != null && widget.prefixIcon!.isNotEmpty)
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            widget.prefixIcon!,
            color: iconColor,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            // NOTE: PNG icon tint হবে না (SVG/Icon হলে করা যায়)
          ),
        )
            : null,

        suffixIcon: widget.suffixIcon,

        filled: true,
        fillColor: fillColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),

        contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
    );
  }
}
