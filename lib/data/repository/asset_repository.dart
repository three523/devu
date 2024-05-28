import 'package:devu_app/data/model/asset.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:hive/hive.dart';

class AssetRepository {
  final Box<Asset> assetBox = Hive.box<Asset>('Asset');

  List<Asset> getAssetList() {
    return assetBox.values.toList();
  }

  Asset getAsset(String id) {
    return assetBox.values.toList().singleWhere((element) => element.id == id);
  }

  Future<void> createAsset(Asset asset) async {
    await assetBox.put(asset.id, asset);
  }

  Future<void> deleteAsset(Asset asset) async {
    await assetBox.delete(asset.id);
  }

  Future<void> updateAsset(Asset asset) async {
    await assetBox.put(asset.id, asset);
  }

  Future<void> createIncome(Asset asset, Money income) async {
    asset.incomeList.add(income);
    await assetBox.put(asset.id, asset);
  }

  Future<void> updateIncome(Asset asset, Money income) async {
    final updateIndex =
        asset.incomeList.indexWhere((element) => element.id == income.id);
    asset.incomeList[updateIndex] = income;
    await assetBox.put(asset.id, asset);
  }

  Future<void> deleteIncome(Asset asset, Money income) async {
    asset.incomeList.removeWhere((element) => element.id == income.id);
    await assetBox.put(asset.id, asset);
  }
}
