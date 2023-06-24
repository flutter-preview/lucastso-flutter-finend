import 'dart:math';

class Expense {
  String name;
  double value;
  String date;
  String category;

  Expense({
    required this.name,
    required this.value,
    required this.date,
    required this.category,
  });

  @override
  String toString() {
    return '$name,$value,$date,$category';
  }

  static Expense fromString(String expenseString) {
    final values = expenseString.split(',');
    return Expense(
      name: values[0],
      value: double.parse(values[1]),
      date: values[2],
      category: values[3],
    );
  }
}

List<Expense> generateMockExpenses() {
  List<Expense> expenses = [];

  for (int i = 0; i < 6; i++) {
    Expense expense = Expense(
      name: 'Expense ${i + 1}',
      value: Random().nextDouble() * 1000,
      date: DateTime.now().subtract(Duration(days: i)).toString(),
      category: 'Category ${i + 1}',
    );
    expenses.add(expense);
  }

  return expenses;
}
