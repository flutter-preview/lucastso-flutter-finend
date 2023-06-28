import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/expenses/edit_expense.dart';
import 'package:finend/expenses/models/expense.dart';
import 'package:finend/home/widgets/navbar.dart';
import 'package:finend/incomes/edit_income.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ExpenseIncomeManager>(context);
    final expenses = manager.expenses;
    final incomes = manager.incomes;
    List<dynamic> transactions = manager.filterTransactions("");

    Widget buildBarChart(List<Income> incomes, List<Expense> expenses) {
      Map<String, double> incomeByMonth = {};
      for (var income in incomes) {
        String month = income.date.substring(3, 5);
        if (incomeByMonth.containsKey(month)) {
          incomeByMonth[month] = (incomeByMonth[month] ?? 0) + income.value;
        } else {
          incomeByMonth[month] = income.value;
        }
      }

      Map<String, double> expenseByMonth = {};
      for (var expense in expenses) {
        String month = expense.date.substring(3, 5);
        if (expenseByMonth.containsKey(month)) {
          expenseByMonth[month] = (expenseByMonth[month] ?? 0) + expense.value;
        } else {
          expenseByMonth[month] = expense.value;
        }
      }

      List<BarChartGroupData> barChartGroups = [];
      List<String> months = [
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12'
      ];

      for (int i = 0; i < months.length; i++) {
        String month = months[i];

        double income = incomeByMonth[month] ?? 0;
        double expense = expenseByMonth[month] ?? 0;

        BarChartGroupData barChartGroup = BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: income,
              colors: [Colors.blue],
            ),
            BarChartRodData(
              y: expense,
              colors: [Colors.red],
            ),
          ],
        );

        barChartGroups.add(barChartGroup);
      }

      return BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          barGroups: barChartGroups,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              margin: 10,
              getTitles: (double value) {
                int index = value.toInt();
                if (index >= 0 && index < months.length) {
                  return months[index];
                }
                return '';
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NavBar(),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Receitas + (5 últimos)",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const Spacer(),
                      incomes.isNotEmpty
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/incomes',
                                );
                              },
                              child: const Text(
                                "Ver todos",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA8A8A8),
                                ),
                              ),
                            )
                          : const Text(""),
                    ],
                  ),
                  incomes.isNotEmpty
                      ? SizedBox(
                          height: 148,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: incomes.length <= 5 ? incomes.length : 5,
                            itemBuilder: (context, index) {
                              final income = incomes[index];
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      content: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  income.name,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(Icons.close),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              income.date,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "r\$${income.value}",
                                              style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    manager
                                                        .removeIncome(income);
                                                    Navigator.of(context).pop();
                                                  },
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
                                                          MaterialStateProperty
                                                              .all(
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
                                                            color: Color(
                                                                0xFF002993),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Income incomeToEdit =
                                                          income;
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditIncome(
                                                                  income:
                                                                      incomeToEdit),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Editar",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                child: Container(
                                  width: 148,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF356DFF),
                                    border: Border.all(
                                        color: const Color(0xFF002993)),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12, left: 16, right: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        income.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        income.date,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "r\$${income.value}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 12);
                            },
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Sem dados de receitas",
                            textAlign: TextAlign.center,
                          ),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Despesas - (5 últimos)",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const Spacer(),
                      expenses.isNotEmpty
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/expenses',
                                );
                              },
                              child: const Text(
                                "Ver todos",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA8A8A8),
                                ),
                              ),
                            )
                          : const Text(""),
                    ],
                  ),
                  expenses.isNotEmpty
                      ? SizedBox(
                          height: 148,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                expenses.length <= 5 ? expenses.length : 5,
                            itemBuilder: (context, index) {
                              final expense = expenses[index];
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      content: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  constraints:
                                                      const BoxConstraints(),
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
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    manager
                                                        .removeExpense(expense);
                                                    Navigator.of(context).pop();
                                                  },
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
                                                          MaterialStateProperty
                                                              .all(
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
                                                            color: Color(
                                                                0xFF002993),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Expense expenseToEdit =
                                                          expense;
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditExpense(
                                                                  expense:
                                                                      expenseToEdit),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Editar",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                child: Container(
                                  width: 148,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF5858),
                                    border: Border.all(
                                      color: const Color(0xFFFF2828),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12, left: 16, right: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        expense.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        expense.date,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
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
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 12);
                            },
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Sem dados de despesas",
                            textAlign: TextAlign.center,
                          ),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Gráfico de movimentação",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF242424),
                    ),
                  ),
                  transactions.isNotEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 320,
                          child: buildBarChart(incomes, expenses),
                        )
                      : const Center(
                          child: Text(
                            "Sem dados de transações recentes",
                            textAlign: TextAlign.center,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.0, color: Colors.black),
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/newincome',
                          );
                        },
                        child: const Text(
                          "Nova receita",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF242424),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/newexpense',
                          );
                        },
                        child: const Text(
                          "Nova despesa",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF242424),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
