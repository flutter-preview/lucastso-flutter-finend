class Income {
  String id;
  String name;
  double value;
  String date;
  String type;
  String category;

  Income({
    required this.id,
    required this.name,
    required this.value,
    required this.date,
    required this.type,
    required this.category,
  });

  @override
  String toString() {
    return '$id,$name,$value,$date,$type,$category';
  }

  static Income fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'],
      name: json['name'],
      value: json['value'].toDouble(),
      date: json['date'],
      type: json['type'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'date': date,
      'type': type,
      'category': category,
    };
  }
}
