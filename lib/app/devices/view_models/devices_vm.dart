import 'package:flutter/material.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/repos/devices_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DevicesVM extends BaseModel {
  final DevicesRepository _devicesRepository = sl<DevicesRepository>();

  DeviceModel? deviceModel;
  List<DeviceModel> devicesList = [];

  BaseModelState baseModelState = BaseModelState.loading;

// sample list of devices
  List<DeviceModel> devices = const [
    DeviceModel(
      id: '76768f68fsfshkh',
      name: 'iPhone 12',
      type: 'iOS 15.6.1',
      registrationID: "665uuyhutggd777",
      deviceID: "87878ejhhkjhweF",
      active: true,
      dateCreated: '2022-08-21T12:15:22Z',
      location: 'Poznan, Poland',
      activities: [
        Activity(
          activity: 'Safari on iPhone',
          location: 'Poznan, Poland',
          ipAddress: '12.123.12.123',
          timeAgo: '5 minutes ago',
          status: 'End Session',
        ),
        Activity(
          activity: 'Safari on iPhone',
          location: 'Poznan, Poland',
          ipAddress: '12.123.12.123',
          timeAgo: '11 minutes ago',
          status: 'End Session',
        ),
        Activity(
          activity: 'Safari on iPhone',
          location: 'Poznan, Poland',
          ipAddress: '12.123.12.123',
          timeAgo: '11 minutes ago',
          status: 'End Session',
        ),
      ],
    ),
    DeviceModel(
      id: '767448f68fsfshkh',
      name: 'iPhone 12',
      type: 'iOS 15.6.1',
      registrationID: "665WWyhutggd777",
      deviceID: "567078ejhhkjhETD",
      active: false,
      dateCreated: '2022-08-21T12:15:22Z',
      location: 'Poznan, Poland',
      activities: [
        Activity(
          activity: 'Safari on iPhone',
          location: 'Poznan, Poland',
          ipAddress: '12.123.12.123',
          timeAgo: '5 minutes ago',
          status: 'End Session',
        ),
        Activity(
          activity: 'Safari on iPhone',
          location: 'Poznan, Poland',
          ipAddress: '12.123.12.123',
          timeAgo: '11 minutes ago',
          status: 'End Session',
        ),
        Activity(
          activity: 'Safari on iPhone',
          location: 'Poznan, Poland',
          ipAddress: '12.123.12.123',
          timeAgo: '11 minutes ago',
          status: 'End Session',
        ),
      ],
    ),
  ];

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> fetchAllDevices({
    required BuildContext context,
    required String searchTerm,
    required int pageNumber,
    required int pageSize,
  }) async {
    baseModelState = BaseModelState.loading;
    final result =
        await _devicesRepository.fetchDevices(searchTerm, pageNumber, pageSize);
    result.fold((l) {
      //PopupDialogs(context).errorMessage('Unable to fetch devices. Try again');
      //setError(l); //TODO: Uncomment this section after testing with valid credentials
      changeState(BaseModelState
          .error); //TODO: Uncomment this section after testing with valid credentials
      devicesList = devices;
      changeState(BaseModelState.success);
    }, (r) {
      devicesList = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> createDevice(
    BuildContext context,
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  }) async {
    baseModelState = BaseModelState.loading;
    final result = await _devicesRepository.createDevice(
      deviceID,
      name: name,
      registrationID: registrationID,
      active: active,
      type: type,
    );
    result.fold((l) {
      setBusy(value: false);
      PopupDialogs(context).errorMessage(l.toString());
      //PopupDialogs(context).errorMessage('Unable to create device. Try again');
      //changeState(BaseModelState.error);
    }, (r) {
      deviceModel = r;
      changeState(BaseModelState.success);
      PopupDialogs(context)
          .successMessage('Your device was successfully created');
      setBusy(value: false);
    });
  }
}
