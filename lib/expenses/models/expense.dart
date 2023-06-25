import 'dart:math';
import 'package:intl/intl.dart';

class Expense {
  String name;
  double value;
  String date;
  String type;
  String category;

  Expense({
    required this.name,
    required this.value,
    required this.date,
    required this.type,
    required this.category,
  });

  @override
  String toString() {
    return '$name,$value,$date,$type,$category';
  }

  static Expense fromString(String expenseString) {
    final values = expenseString.split(',');
    return Expense(
      name: values[0],
      value: double.parse(values[1]),
      date: values[2],
      type: values[3],
      category: values[4],
    );
  }
}

List<Expense> generateMockExpenses() {
  List<Expense> expenses = [];

  for (int i = 0; i < 6; i++) {
    Expense expense = Expense(
      name: 'Expense ${i + 1}',
      value: double.parse((Random().nextDouble() * 1000).toStringAsFixed(2)),
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      type: "Despesa",
      category: 'Category ${i + 1}',
    );
    expenses.add(expense);
  }

  return expenses;
}
