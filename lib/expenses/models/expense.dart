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
