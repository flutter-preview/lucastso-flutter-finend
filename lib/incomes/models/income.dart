import 'dart:math';
import 'package:intl/intl.dart';

class Income {
  String name;
  double value;
  String date;
  String type;
  String category;

  Income({
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

  static Income fromJson(Map<String, dynamic> json) {
    return Income(
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

List<Income> generateMockIncomes() {
  List<Income> incomes = [];

  for (int i = 0; i < 6; i++) {
    Income income = Income(
      name: 'Income ${i + 1}',
      value: double.parse((Random().nextDouble() * 1000).toStringAsFixed(2)),
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      type: "Receita",
      category: 'Category ${i + 1}',
    );
    incomes.add(income);
  }

  return incomes;
}
