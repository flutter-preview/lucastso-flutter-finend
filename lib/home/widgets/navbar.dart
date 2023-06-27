import 'package:finend/configs/expense_income_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

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
        )
      ],
    );
  }
}
