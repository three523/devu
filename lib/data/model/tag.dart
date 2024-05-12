import 'package:hive/hive.dart';

part 'tag.g.dart';

@HiveType(typeId: 3)
class Tag {
  Tag(this.name, this.color);

  @HiveField(0)
  String name;

  @HiveField(1)
  int color;

  @override
  String toString() => '{name: $name, color: $color}';
}
