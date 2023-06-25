import 'package:finend/expenses/models/expense.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Expense> expenses = generateMockExpenses();
  List<Income> incomes = generateMockIncomes();

  List<dynamic> combinedList = [];

  @override
  Widget build(BuildContext context) {
    combinedList.addAll(expenses);
    combinedList.addAll(incomes);
    combinedList.shuffle(Random());

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
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: combinedList.length,
                    itemBuilder: (context, index) {
                      final item = combinedList[index];
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
                                          item.name,
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
                                      item.date,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "r\$${item.value}",
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
                              color: item.type == "Despesa"
                                  ? const Color(0xFFFF5858)
                                  : const Color(0xFF356DFF),
                              border: Border.all(
                                  color: item.type == "Despesa"
                                      ? const Color(0xFFFF2828)
                                      : const Color(0xFF002993)),
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
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.date,
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
                                          item.category,
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
                                      "r\$${item.value}",
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
