import 'package:flutter/material.dart';

class AuthGreyButton extends StatelessWidget {
  final String buttonLabel;
  final String pushToRoute;
  const AuthGreyButton(
      {super.key, required this.buttonLabel, required this.pushToRoute});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFFF4F4F4),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              side: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            pushToRoute,
          );
        },
        child: Text(
          buttonLabel,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
          ),
        ),
      ),
    );
  }
}
