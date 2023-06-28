import 'package:finend/auth/auth_service.dart';
import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final inputEmailController = TextEditingController();
  final inputPasswordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
          inputEmailController.text, inputPasswordController.text);

      Navigator.pushNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro"),
        ),
      );
    }
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
                      child: Form(
                        key: _formKey,
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
                              child: TextFormField(
                                controller: inputEmailController,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.emailAddress,
                                validator: (email) {
                                  if (email == null || email.isEmpty) {
                                    return "Digite seu e-mail!";
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(inputEmailController.text)) {
                                    return 'Por favor, digite um e-mail correto';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Insira seu e-mail aqui",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF4F4F4),
                                ),
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
                              child: TextFormField(
                                controller: inputPasswordController,
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: true,
                                validator: (password) {
                                  if (password == null || password.isEmpty) {
                                    return "Digite sua senha!";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Insira sua senha aqui",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF4F4F4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            AuthBlueButton(
                              buttonLabel: 'Entrar',
                              onPressed: signIn,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
