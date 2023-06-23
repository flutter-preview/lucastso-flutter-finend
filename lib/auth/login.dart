import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/grey_button.dart';
import 'package:finend/auth/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController inputEmailController = TextEditingController();
  TextEditingController inputPasswordController = TextEditingController();

  void onPressedLogin() {
    Navigator.pushNamed(
      context,
      '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: const Color(0xFF0047FF),
                  child: const Image(
                    image: AssetImage('assets/images/finend.png'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 40, bottom: 80),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Faça login para acessar\na aplicação",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF242424),
                            ),
                          ),
                          const SizedBox(height: 64),
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
                                inputController: inputEmailController,
                                inputHintText: "Insira seu e-mail aqui"),
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
                              inputController: inputPasswordController,
                              inputHintText: "Insira sua senha aqui",
                            ),
                          ),
                          const SizedBox(height: 32),
                          AuthBlueButton(
                            buttonLabel: 'Entrar',
                            onPressed: onPressedLogin,
                          ),
                          const SizedBox(height: 16),
                          const AuthGreyButton(
                            buttonLabel: 'Registrar-se',
                            pushToRoute: '/register',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
