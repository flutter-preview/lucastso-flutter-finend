import 'dart:math';

class Income {
  String name;
  double value;
  String date;
  String category;

  Income({
    required this.name,
    required this.value,
    required this.date,
    required this.category,
  });

  @override
  String toString() {
    return '$name,$value,$date,$category';
  }

  static Income fromString(String incomeString) {
    final values = incomeString.split(',');
    return Income(
      name: values[0],
      value: double.parse(values[1]),
      date: values[2],
      category: values[3],
    );
  }
}

List<Income> generateMockIncomes() {
  List<Income> incomes = [];

  for (int i = 0; i < 6; i++) {
    Income income = Income(
      name: 'Income ${i + 1}',
      value: Random().nextDouble() * 1000,
      date: DateTime.now().subtract(Duration(days: i)).toString(),
      category: 'Category ${i + 1}',
    );
    incomes.add(income);
  }

  return incomes;
}
