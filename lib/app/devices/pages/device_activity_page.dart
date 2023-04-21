import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/app/devices/widgets/activity_widget.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DeviceActivityPage extends StatelessWidget {
  final DeviceModel appDeviceModel;
  const DeviceActivityPage({
    Key? key,
    required this.appDeviceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Activity'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
        ),
      ),
    );
  }
}
