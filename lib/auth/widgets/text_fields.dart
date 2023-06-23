import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String inputHintText;
  final TextEditingController inputController;
  const CustomTextField(
      {super.key, required this.inputHintText, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: inputHintText,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        filled: true,
        fillColor: const Color(0xFFF4F4F4),
      ),
    );
  }
}
