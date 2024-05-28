import 'package:devu_app/asset_event.dart';
import 'package:devu_app/asset_state.dart';
import 'package:devu_app/data/repository/asset_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository _assetRepository;
  AssetBloc(this._assetRepository)
      : super(AssetInitState(_assetRepository.getAssetList())) {
    on<LoadAssetEvent>(
      (event, emit) {
        final assetList = _assetRepository.getAssetList();
        if (event.assetId != null) {
          emit(AssetLoadSuccessState(assetList,
              asset: _assetRepository.getAsset(event.assetId!)));
        } else {
          emit(AssetLoadSuccessState(assetList, asset: null));
        }
      },
    );
    on<CreateAssetEvent>(
      (event, emit) async {
        await _assetRepository.createAsset(event.asset);
        final assetList = _assetRepository.getAssetList();
        emit(AssetLoadSuccessState(assetList));
      },
    );
    on<UpdateAssetEvent>(
      (event, emit) async {
        await _assetRepository.updateAsset(event.updateAsset);
        final assetList = _assetRepository.getAssetList();
        final asset = _assetRepository.getAsset(event.updateAsset.id);
        emit(AssetLoadSuccessState(assetList, asset: asset));
      },
    );
    on<DeleteAssetEvent>(
      (event, emit) async {
        await _assetRepository.deleteAsset(event.deleteAsset);
        final assetList = _assetRepository.getAssetList();
        emit(AssetLoadSuccessState(assetList));
      },
    );
    on<CreateIncomeEvent>((event, emit) async {
      await _assetRepository.createIncome(event.asset, event.newIncome);
      final assetList = _assetRepository.getAssetList();
      final asset = _assetRepository.getAsset(event.asset.id);
      emit(AssetLoadSuccessState(assetList, asset: asset));
    });
    on<DeleteIncomeEvent>(
      (event, emit) async {
        await _assetRepository.deleteIncome(event.asset, event.deleteIncome);
        final assetList = _assetRepository.getAssetList();
        final asset = _assetRepository.getAsset(event.asset.id);
        emit(AssetLoadSuccessState(assetList, asset: asset));
      },
    );
    on<UpdateIncomeEvent>(
      (event, emit) async {
        await _assetRepository.updateIncome(event.asset, event.updateIncome);
        final assetList = _assetRepository.getAssetList();
        final asset = _assetRepository.getAsset(event.asset.id);
        emit(AssetLoadSuccessState(assetList, asset: asset));
      },
    );
  }
}
