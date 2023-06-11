import 'package:finend/auth/login.dart';
import 'package:finend/auth/register.dart';
import 'package:finend/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Outfit",
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView()
      },
    );
  }
}
