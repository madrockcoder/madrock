import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/app/devices/pages/device_activity_page.dart';
import 'package:geniuspay/app/devices/widgets/activity_widget.dart';
import 'package:geniuspay/app/devices/widgets/device_title_widget.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/format_date.dart';
import 'package:geniuspay/util/size_util.dart';

class DeviceDetailPage extends StatelessWidget {
  final DeviceModel appDeviceModel;
  const DeviceDetailPage({
    Key? key,
    required this.appDeviceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateCreated =
        '${FormatDate.getDate(appDeviceModel.dateCreated, 'yMMMd')}, ${FormatDate.getDate(appDeviceModel.dateCreated, 'Hm')}';
    return Scaffold(
      backgroundColor: AppColor.kButton2Color,
      appBar: AppBar(
        backgroundColor: AppColor.kButton2Color,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Transform.scale(
            scale: 0.35,
            child: SvgPicture.asset(
              'assets/icons/backArrow.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: const Text(''),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for device information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeviceTitleWidget(
                      appDeviceModel: appDeviceModel,
                      fontSize: 18,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(
                      appDeviceModel.active ? 'Active now' : dateCreated,
                      textAlign: TextAlign.center,
                      selectionColor: AppColor.kSecondaryColor,
                      style: TextStyle(
                        fontSize: 16,
                        color: appDeviceModel.active
                            ? AppColor.kDepositColor
                            : AppColor.kGreyColor,
                        fontWeight: appDeviceModel.active
                            ? FontWeight.w500
                            : FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 33,
                  backgroundColor: AppColor.kAccentColor2,
                  child: SvgPicture.asset(
                    'assets/devices/mobile.svg',
                    width: 35,
                    height: 35,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.03,
            ),
            // Section for device details
            const Text(
              'Details',
              textAlign: TextAlign.center,
              selectionColor: AppColor.kSecondaryColor,
              style: TextStyle(
                fontSize: 15,
                color: AppColor.kSecondaryColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.015,
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColor.kWhiteColor,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4.0, 4.0),
                    blurRadius: 4,
                    color: AppColor.kGrayColor,
                  )
                ],
              ),
              child: Column(
                children: [
                  // Row for device name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Device',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.kSecondaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        appDeviceModel.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.kGreyColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.025,
                  ),
                  // Row for os type & version
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'OS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.kSecondaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        appDeviceModel.type,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.kGreyColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.025,
                  ),
                  // Row for First login timestamp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'First login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.kSecondaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        dateCreated,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.kGreyColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: displayHeight(context) * 0.04,
            ),
            // Section for device activity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Activity',
                  textAlign: TextAlign.center,
                  selectionColor: AppColor.kSecondaryColor,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.kSecondaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeviceActivityPage(
                        appDeviceModel: appDeviceModel,
                      ),
                    ),
                  ),
                  child: const Text(
                    'View All',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: AppColor.kPinDesColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.015,
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColor.kWhiteColor,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4.0, 4.0),
                    blurRadius: 4,
                    color: AppColor.kGrayColor,
                  )
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: appDeviceModel.activities!.length,
                itemBuilder: (context, index) => ActivityWidget(
                  activity: appDeviceModel.activities![index],
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: AppColor.kAccentColor2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
