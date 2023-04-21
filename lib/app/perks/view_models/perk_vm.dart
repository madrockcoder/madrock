import 'package:flutter/material.dart';
import 'package:geniuspay/app/perks/pages/claim_offer_page.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/perk.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/perks_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PerksViewModel extends BaseModel {
  BaseModelState categoriesState = BaseModelState.loading;
  BaseModelState pointsListState = BaseModelState.loading;
  final PerksService _perksService = sl<PerksService>();
  final AuthenticationService authenticationService = sl<AuthenticationService>();

  void changeState(BaseModelState state) {
    pointsListState = state;
    notifyListeners();
  }

  void changeCategoriesState(BaseModelState state) {
    categoriesState = state;
    notifyListeners();
  }

  String get points => getPoints();
  List<Perk> perksList = [];
  List<String> categories = [];

  String getPoints() {
    return authenticationService.user!.userProfile.points!;
  }

  Future<void> getUser() async {
    await authenticationService.getUser();
    notifyListeners();
  }

  Future<void> getCategories() async {
    categoriesState = BaseModelState.loading;
    final result = await _perksService.getPerksCategories();
    result.fold((l) {
      changeCategoriesState(BaseModelState.error);
    }, (r) {
      categories = r;
      categories.insert(0, "All");
      changeCategoriesState(BaseModelState.success);
    });
  }

  Future<void> getPerks() async {
    pointsListState = BaseModelState.loading;
    final result = await _perksService.getPerkList();
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      perksList = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> claimPerk(BuildContext context, Perk perk) async {
    if (perk.claimCount == 0) {
      final result = await _perksService.claimPerk(authenticationService.user!.id, perk.id);
      if (result.isLeft()) {
        PopupDialogs(context).errorMessage('Unable to claim this perk');
      } else {
        await authenticationService.getUser();
        ClaimOfferPage.show(context, perk, authenticationService.user!);
      }
    } else {
      ClaimOfferPage.show(context, perk, authenticationService.user!);
    }
  }
}
