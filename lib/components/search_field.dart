import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  double? width, height;

  SearchField({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 30,
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          hintText: '검색',
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
