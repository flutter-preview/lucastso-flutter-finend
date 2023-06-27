import 'package:finend/auth/auth_service.dart';
import 'package:finend/configs/expense_income_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.pushNamed(
      context,
      '/login',
    );
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ExpenseIncomeManager>(context);
    String userName = "";

    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/profile',
            );
          },
          child: Row(
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(999),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/person.png'),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF242424),
                    ),
                  ),
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF242424),
                  )
                ],
              )
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                color: Color(0xFF242424),
                size: 24,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/search',
                );
              },
              icon: const Icon(
                Icons.search,
                color: Color(0xFF242424),
                size: 24,
              ),
            ),
          ],
        )
      ],
    );
  }
}
