import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  final double? width, height;
  final IconData icon;
  final Color iconColor, fillColor;
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback onEditingComplete;

  const IconTextField({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.fillColor,
    required this.hintText,
    required this.onEditingComplete,
    this.controller,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 30,
      child: TextField(
        onEditingComplete: onEditingComplete,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
