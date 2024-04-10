import 'package:hive/hive.dart';

part 'filter_data.g.dart';

@HiveType(typeId: 2)
class FilterData {
  FilterData({
    required this.key,
    required this.dataList,
  });

  @HiveField(0)
  String key;

  @HiveField(1)
  List<String> dataList;

  @override
  String toString() => '{key: $key, categoryList: $dataList}';
}
