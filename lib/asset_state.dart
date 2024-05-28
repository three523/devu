import 'package:devu_app/data/model/asset.dart';

sealed class AssetState {}

class AssetInitState extends AssetState {
  final List<Asset> assetList;
  AssetInitState(this.assetList);
}

class AssetLoadSuccessState extends AssetState {
  final List<Asset> assetList;
  final Asset? asset;
  AssetLoadSuccessState(this.assetList, {this.asset});
}

class IncomeUpdateSuccessState extends AssetState {
  final Asset asset;
  IncomeUpdateSuccessState(this.asset);
}

class AssetSingleDeleteSuccessState extends AssetState {
  AssetSingleDeleteSuccessState();
}

class AssetErrorState extends AssetState {
  final String message;
  AssetErrorState(this.message);
}
