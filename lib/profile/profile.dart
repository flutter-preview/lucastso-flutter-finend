import 'dart:convert';

import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/grey_button.dart';
import 'package:finend/auth/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputEmailController = TextEditingController();
  TextEditingController inputPasswordController = TextEditingController();
  TextEditingController inputPictureController = TextEditingController();

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = {
      'name': inputNameController.text,
      'email': inputEmailController.text,
      'password': inputPasswordController.text,
      'imageUrl': inputPictureController.text,
    };
    await prefs.setString('userData', json.encode(userData));
  }

  void onPressedEditProfile() {
    saveUserData().then((_) {
      Navigator.pushNamed(
        context,
        '/home',
      );
    });
  }

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
                        "Editar dados do perfil",
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
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Nome:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira seu nome aqui",
                          inputController: inputNameController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "E-mail:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira seu e-mail aqui",
                          inputController: inputEmailController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Senha:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira sua senha aqui",
                          inputController: inputPasswordController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Foto:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Pesquise no dispositivo",
                          inputController: inputPictureController,
                        ),
                      ),
                      const SizedBox(height: 32),
                      AuthBlueButton(
                        buttonLabel: "Editar perfil",
                        onPressed: onPressedEditProfile,
                      ),
                      const SizedBox(height: 16),
                      const AuthGreyButton(
                        buttonLabel: 'Log out',
                        pushToRoute: '/login',
                      )
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
