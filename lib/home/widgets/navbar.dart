import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
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
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Lucas",
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
