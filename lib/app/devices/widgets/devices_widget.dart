import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/app/devices/widgets/device_title_widget.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/format_date.dart';
import 'package:geniuspay/util/size_util.dart';

class DevicesWidget extends StatelessWidget {
  final DeviceModel appDeviceModel;
  const DevicesWidget({Key? key, required this.appDeviceModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateCreated =
        '${FormatDate.getDate(appDeviceModel.dateCreated, 'MMMd')}, ${FormatDate.getDate(appDeviceModel.dateCreated, 'Hm')}';
    return Container(
      padding: const EdgeInsets.all(7.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      // decoration: BoxDecoration(
      //   color: AppColor.kWhiteColor,
      //   // borderRadius: BorderRadius.circular(46.0),
      // ),
      child: Row(
        children: [
          // device container
          Stack(
            children: [
              CircleAvatar(
                radius: 33,
                backgroundColor: AppColor.kAccentColor2,
                child: SvgPicture.asset(
                  'assets/devices/mobile.svg',
                  width: 35,
                  height: 35,
                ),
              ),
              appDeviceModel.active
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        'assets/devices/check.svg',
                        width: 20,
                        height: 20,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(
            width: displayWidth(context) * 0.03,
          ),
          // mobile name, ios version, status & location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // device name & ios version
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child:
                            DeviceTitleWidget(appDeviceModel: appDeviceModel)),
                    Text(
                      appDeviceModel.active ? 'This device' : '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.kGreyColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                // device status and location
                Row(
                  children: [
                    Text(
                      appDeviceModel.active ? 'Active now' : dateCreated,
                      textAlign: TextAlign.center,
                      selectionColor: AppColor.kSecondaryColor,
                      style: TextStyle(
                        //fontSize: 15,
                        color: appDeviceModel.active
                            ? AppColor.kDepositColor
                            : AppColor.kGreyColor,
                        fontWeight: appDeviceModel.active
                            ? FontWeight.w500
                            : FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.012,
                    ),
                    const CircleAvatar(
                      radius: 2,
                      backgroundColor: AppColor.kGreyColor,
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.012,
                    ),
                    Text(
                      appDeviceModel.location,
                      textAlign: TextAlign.center,
                      selectionColor: AppColor.kGrayColor,
                      style: const TextStyle(
                        //fontSize: 15,
                        color: AppColor.kGreyColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
