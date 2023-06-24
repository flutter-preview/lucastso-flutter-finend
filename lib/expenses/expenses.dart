import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  /*List<Expense> expenses = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadExpenses();
  }

  void loadExpenses() {
    expenses = Provider.of<ExpenseIncomeProvider>(context).expenses;
  }*/

  @override
  Widget build(BuildContext context) {
    List<Expense> expenses = generateMockExpenses();

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
                        "Suas despesas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          return ListTile(
                            title: Text(expense.name),
                            subtitle: Text(expense.category),
                            trailing:
                                Text('\$${expense.value.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
