import 'package:flutter/material.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/size_util.dart';

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  const ActivityWidget({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
      child: Column(
        children: [
          // row for activity name and time spent
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  activity.activity,
                  textAlign: TextAlign.start,
                  selectionColor: AppColor.kSecondaryColor,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColor.kSecondaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Text(
                activity.timeAgo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: AppColor.kPinDesColor,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          // row for location and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${activity.location} (${activity.ipAddress})',
                  textAlign: TextAlign.start,
                  selectionColor: AppColor.kSecondaryColor,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColor.kPinDesColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: AppColor.kRedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  activity.status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColor.kWhiteColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
