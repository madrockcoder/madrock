import 'package:flutter/material.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DeviceTitleWidget extends StatelessWidget {
  final DeviceModel appDeviceModel;
  final double? fontSize;
  const DeviceTitleWidget({
    Key? key,
    required this.appDeviceModel,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          appDeviceModel.name,
          textAlign: TextAlign.center,
          selectionColor: AppColor.kSecondaryColor,
          style: TextStyle(
            color: AppColor.kSecondaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: size.width * 0.012,
        ),
        const CircleAvatar(
          radius: 2,
          backgroundColor: AppColor.kScaffoldBackgroundColor,
        ),
        SizedBox(
          width: size.width * 0.012,
        ),
        Text(
          appDeviceModel.type,
          textAlign: TextAlign.center,
          selectionColor: AppColor.kSecondaryColor,
          style: TextStyle(
            color: AppColor.kSecondaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
