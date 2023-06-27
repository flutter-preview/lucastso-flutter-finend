import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/expenses/models/expense.dart';
import 'package:finend/home/widgets/navbar.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    List<Color> getBarColors(double value) {
      if (value < 0) {
        return [Colors.red];
      } else {
        return [Colors.blue];
      }
    }

    Map<String, double> getMonthlyData(List<dynamic> transactions) {
      Map<String, double> monthlyData = {};

      for (var transaction in transactions) {
        String? transactionDate;
        double? amount;

        if (transaction is Expense) {
          transactionDate = transaction.date;
          amount = transaction.value;
        } else if (transaction is Income) {
          transactionDate = transaction.date;
          amount = -transaction.value;
        } else {
          continue;
        }

        if (transactionDate != null && amount != null) {
          DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(transactionDate);
          String month = DateFormat('MM').format(parsedDate);

          if (monthlyData.containsKey(month)) {
            monthlyData[month] = (monthlyData[month] ?? 0) + amount;
          } else {
            monthlyData[month] = amount;
          }
        }
      }

      return monthlyData;
    }

    Map<String, double> monthlyData = getMonthlyData(transactions);

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
                                                    const SnackBar(
                                                      content: Text(
                                                          "Despesa removida com sucesso"),
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            margin: 16,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 1:
                                  return 'Jan';
                                case 2:
                                  return 'Fev';
                                case 3:
                                  return 'Mar';
                                case 4:
                                  return 'Abr';
                                case 5:
                                  return 'Mai';
                                case 6:
                                  return 'Jun';
                                case 7:
                                  return 'Jul';
                                case 8:
                                  return 'Ago';
                                case 9:
                                  return 'Set';
                                case 10:
                                  return 'Out';
                                case 11:
                                  return 'Nov';
                                case 12:
                                  return 'Dez';
                                default:
                                  return '';
                              }
                            },
                          ),
                          leftTitles: SideTitles(showTitles: false),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: monthlyData.entries.map((entry) {
                          final double expenseValue = entry.value ?? 0.0;
                          final double incomeValue = entry.value ?? 0.0;
                          return BarChartGroupData(
                            x: int.parse(entry.key),
                            barRods: [
                              BarChartRodData(
                                y: expenseValue,
                                colors: getBarColors(expenseValue),
                              ),
                              BarChartRodData(
                                y: incomeValue,
                                colors: getBarColors(incomeValue),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  )
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
                  height: 152,
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
