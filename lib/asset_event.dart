import 'package:devu_app/data/model/asset.dart';
import 'package:devu_app/data/model/money.dart';

sealed class AssetEvent {}

class LoadAssetEvent extends AssetEvent {
  final String? assetId;
  LoadAssetEvent({this.assetId});
}

class CreateAssetEvent extends AssetEvent {
  Asset asset;
  CreateAssetEvent(this.asset);
}

class UpdateAssetEvent extends AssetEvent {
  Asset updateAsset;
  UpdateAssetEvent(this.updateAsset);
}

class DeleteAssetEvent extends AssetEvent {
  Asset deleteAsset;
  DeleteAssetEvent(this.deleteAsset);
}

class CreateIncomeEvent extends AssetEvent {
  Asset asset;
  Money newIncome;
  CreateIncomeEvent(this.asset, this.newIncome);
}

class DeleteIncomeEvent extends AssetEvent {
  Asset asset;
  Money deleteIncome;
  DeleteIncomeEvent(this.asset, this.deleteIncome);
}

class UpdateIncomeEvent extends AssetEvent {
  Asset asset;
  Money updateIncome;
  UpdateIncomeEvent(this.asset, this.updateIncome);
}
