import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() => NewCategoryState();
}

class NewCategoryState extends State<NewCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/home',
                          );
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Color(0xFF242424),
                          size: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Registrar nova categoria",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 40),
                      Text(
                        "Nome:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                            inputHintText: "Insira o nome da categoria"),
                      ),
                      SizedBox(height: 32),
                      AuthBlueButton(
                        buttonLabel: "Inserir nova categoria",
                        pushToRoute: "/home",
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
