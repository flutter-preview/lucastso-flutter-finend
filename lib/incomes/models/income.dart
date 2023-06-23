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
