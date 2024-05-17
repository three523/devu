import 'package:devu_app/data/model/asset.dart';

sealed class AssetState {}

class AssetInitState extends AssetState {
  final List<Asset> assetList;
  AssetInitState(this.assetList);
}

class AssetLoadSuccessState extends AssetState {
  final List<Asset> assetList;
  AssetLoadSuccessState(this.assetList);
}

class AssetErrorState extends AssetState {
  final String message;
  AssetErrorState(this.message);
}
