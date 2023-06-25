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

  static Income fromString(String incomeString) {
    final values = incomeString.split(',');
    return Income(
      name: values[0],
      value: double.parse(values[1]),
      date: values[2],
      type: values[3],
      category: values[4],
    );
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
