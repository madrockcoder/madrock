import 'package:flutter/cupertino.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/points_stat.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProfilePointsVM extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  BaseModelState baseModelState = BaseModelState.loading;

  List<PointStat> pointsList = [];
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> getPointsList(BuildContext context) async {
    baseModelState = BaseModelState.loading;
    final result =
        await _authenticationService.getPoints(_authenticationService.user!.id);
    result.fold((l) => changeState(BaseModelState.error), (r) {
      pointsList = r;
      changeState(BaseModelState.success);
    });
  }
}
