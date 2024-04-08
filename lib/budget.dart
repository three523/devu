import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 0)
class Budget {
  Budget({
    required this.id,
    required this.price,
    required this.date,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  int price;

  @HiveField(2)
  DateTime date;

  @override
  String toString() => '{id: $id, price: $price, date: $date}';
}
