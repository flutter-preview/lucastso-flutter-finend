import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/grey_button.dart';
import 'package:finend/auth/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
                    children: const [
                      SizedBox(height: 40),
                      Text(
                        "Nome:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira seu nome aqui",
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "E-mail:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                            inputHintText: "Insira seu e-mail aqui"),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Senha:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                            inputHintText: "Insira sua senha aqui"),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Foto:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                            inputHintText: "Pesquise no dispositivo"),
                      ),
                      SizedBox(height: 32),
                      AuthBlueButton(
                        buttonLabel: "Editar perfil",
                        pushToRoute: "/home",
                      ),
                      SizedBox(height: 16),
                      AuthGreyButton(
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
