import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:hive/hive.dart';

part 'asset.g.dart';

@HiveType(typeId: 5)
class Asset {
  Asset(
    this.id,
    this.title,
    this.startTimeStamp,
    this.goalTimestamp,
    this.goalMoney,
    this.goalRate,
    this.incomeList,
    this.memo,
    this.tagList,
  );

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int startTimeStamp;

  @HiveField(3)
  int goalMoney;

  @HiveField(4)
  double goalRate;

  @HiveField(5)
  int goalTimestamp;

  @HiveField(6)
  List<Money> incomeList;

  @HiveField(7)
  String memo;

  @HiveField(8)
  List<Tag> tagList;

  @override
  String toString() =>
      '{id: $id, title: $title, startTimeStamp: $startTimeStamp, goalMoney: $goalMoney, goalRate: $goalRate, goalTimestamp: ${goalTimestamp}, assetList: $incomeList, memo: $memo, tagList: $tagList}';
}
