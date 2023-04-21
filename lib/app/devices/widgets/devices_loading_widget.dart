import 'package:flutter/material.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/app/devices/widgets/devices_widget.dart';
import 'package:shimmer/shimmer.dart';

class DevicesLoadingWidget extends StatelessWidget {
  final int number;
  const DevicesLoadingWidget({Key? key, required this.number})
      : super(key: key);
  final device = const DeviceModel(
    id: '76768f68fsfshkh',
    name: 'iPhone 12',
    type: 'iOS 15.6.1',
    registrationID: "665uuyhutggd777",
    deviceID: "87878ejhhkjhweF",
    active: true,
    dateCreated: '2022-08-21T12:15:22Z',
    location: 'Poznan, Poland',
    activities: <Activity>[],
  );
  @override
  Widget build(BuildContext context) {
    final devices = [for (int i = 0; i < number; i++) device];
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return DevicesWidget(appDeviceModel: devices[index]);
        },
      ),
    );
  }
}
