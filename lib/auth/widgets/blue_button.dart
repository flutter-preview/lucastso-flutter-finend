import 'package:flutter/material.dart';

class AuthBlueButton extends StatelessWidget {
  final String buttonLabel;
  final String pushToRoute;
  const AuthBlueButton(
      {super.key, required this.buttonLabel, required this.pushToRoute});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF0047FF),
          ),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              side: BorderSide(
                color: Color(0xFF002993),
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
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
