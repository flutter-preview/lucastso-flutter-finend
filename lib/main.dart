import 'package:finend/auth/auth_gate.dart';
import 'package:finend/auth/auth_service.dart';
import 'package:finend/auth/login.dart';
import 'package:finend/auth/register.dart';
import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/expenses/expenses.dart';
import 'package:finend/expenses/new_expense.dart';
import 'package:finend/firebase_options.dart';
import 'package:finend/home/home.dart';
import 'package:finend/incomes/incomes.dart';
import 'package:finend/incomes/new_income.dart';
import 'package:finend/profile/profile.dart';
import 'package:finend/search/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExpenseIncomeManager()..getExpensesAndIncomes(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/authgate',
      routes: {
        '/authgate': (context) => const AuthGate(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(),
        '/profile': (context) => const ProfileView(),
        '/search': (context) => const SearchView(),
        '/incomes': (context) => const Incomes(),
        '/newincome': (context) => const NewIncome(),
        '/expenses': (context) => const Expenses(),
        '/newexpense': (context) => const NewExpense(),
      },
    );
  }
}
