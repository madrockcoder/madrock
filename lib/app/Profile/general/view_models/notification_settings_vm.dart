import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/settings_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationSettingsVM extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  NotificationOption? get notificationOption =>
      _authenticationService.user?.userProfile.notificationOption;
  final SettingsService _settingsService = sl<SettingsService>();
  BaseModelState baseModelState = BaseModelState.loading;

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> updateNotificationSettings(
      {required BuildContext context,
      required NotificationOption changedNotificationOption}) async {
    final result = await _settingsService.updateNotifcationOptin(
        notificationOption!.id!, changedNotificationOption);
    result.fold((l) {
      PopupDialogs(context).errorMessage(
          'Unable to save the notification details. Please try again');
    }, (r) async {
      PopupDialogs(context)
          .successMessage('Successfully updated notification settings');
      await _authenticationService.getUser();
      notifyListeners();
    });
  }
}
