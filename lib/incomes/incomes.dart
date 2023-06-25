import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';

class Incomes extends StatefulWidget {
  const Incomes({super.key});

  @override
  State<Incomes> createState() => _IncomesState();
}

class _IncomesState extends State<Incomes> {
  List<Income> incomes = generateMockIncomes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
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
                        "Suas receitas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: incomes.length,
                    itemBuilder: (context, index) {
                      final expense = incomes[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              content: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          expense.name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.close),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      expense.date,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "r\$${expense.value}",
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 40,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color(0xFF0047FF),
                                              ),
                                              shape:
                                                  const MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  side: BorderSide(
                                                    color: Color(0xFF002993),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              "Editar",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 160,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF356DFF),
                              border: Border.all(color: Color(0xFF002993)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  expense.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  expense.date,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.label_outline,
                                          color: const Color(0xFFFFFFFF)
                                              .withOpacity(0.5),
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          expense.category,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFFFFFFF)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      "r\$${expense.value}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
