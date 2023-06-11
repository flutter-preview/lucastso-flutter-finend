import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String inputHintText;
  const CustomTextField({super.key, required this.inputHintText});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: 'Insira seu e-mail aqui',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        filled: true,
        fillColor: Color(0xFFF4F4F4),
      ),
    );
  }
}
