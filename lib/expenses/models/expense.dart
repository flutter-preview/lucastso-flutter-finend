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

  static Expense fromJson(Map<String, dynamic> json) {
    return Expense(
      name: json['name'],
      value: json['value'].toDouble(),
      date: json['date'],
      type: json['type'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'date': date,
      'type': type,
      'category': category,
    };
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
