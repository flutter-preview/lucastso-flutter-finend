import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class DummyView extends StatelessWidget {
  const DummyView({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseManager = Provider.of<ExpenseIncomeManager>(context);
    final expenses = expenseManager.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search View'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense.name),
            subtitle: Text(expense.category),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                expenseManager.removeExpense(expense);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newExpense = Expense(
            name: 'New Expense',
            value: 50.0,
            date: '01/01/2022',
            type: 'Expense',
            category: 'Category',
          );
          expenseManager.addExpense(newExpense);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
