import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/mobile_network.dart';
import 'package:geniuspay/services/mobile_network_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SelectMobileNetworkVM extends BaseModel {
  List<MobileNetwork> _networks = [];
  List<MobileNetwork> get networks => _networks;
  List<MobileNetwork> _foundNetworks = [];
  List<MobileNetwork> get foundNetworks => _foundNetworks;

  final MobileNetworkServices _mobileNetworkService = sl<MobileNetworkServices>();

  BaseModelState baseModelState = BaseModelState.loading;
  BaseModelState searchNetworkBaseModel = BaseModelState.success;

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  void changeSearchNetworkState(BaseModelState state) {
    searchNetworkBaseModel = state;
    notifyListeners();
  }

  Future<void> resetFoundNetworks(BuildContext context) async {
    if (networks.isEmpty) {
      searchNetworkBaseModel = BaseModelState.loading;

      await getNetworks(context);
    }
    _foundNetworks = networks;
    changeSearchNetworkState(BaseModelState.success);
  }

  Future<void> searchNetwork({
    required String keyword,
    required BuildContext context,
  }) async {
    changeSearchNetworkState(BaseModelState.loading);
    final result = networks.where((element) =>
    element.networkName.toLowerCase().startsWith(keyword.toLowerCase()));
    _foundNetworks = result.toList();
    changeSearchNetworkState(BaseModelState.success);
  }

  Future<void> getNetworks(BuildContext context) async {
    final result = await _mobileNetworkService.fetchMobileNetworks();
    result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to proceed. Please try again later');
      changeState(BaseModelState.error);
    }, (r) {
      _networks = r.list;
      _foundNetworks = _networks;
      changeState(BaseModelState.success);
    });
  }
}
