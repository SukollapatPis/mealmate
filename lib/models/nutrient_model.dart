// models/nutrient_model.dart
class Nutrient {
  final String name;
  final double amount;
  final String unit;
  final double percentOfDailyNeeds;

  Nutrient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.percentOfDailyNeeds,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      name: json['name'],
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'],
      percentOfDailyNeeds: (json['percentOfDailyNeeds'] as num).toDouble(),
    );
  }
}
