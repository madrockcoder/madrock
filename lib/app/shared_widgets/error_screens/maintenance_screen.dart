// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/time_zone_offsets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';

class MaintenanceBreak extends StatefulWidget {
  const MaintenanceBreak({Key? key}) : super(key: key);

  @override
  State<MaintenanceBreak> createState() => _MaintenanceBreakState();
}

class _MaintenanceBreakState extends State<MaintenanceBreak> {
  late String dateTime;

  @override
  void initState() {
    getLocalDateTime();
    dateTime = DateFormat("HH:mm")
            .format(RemoteConfigService.getRemoteData.maintenanceTime!) +
        " CEST";
    super.initState();
  }

  getLocalDateTime() async {
    String country;
    final LocalBase _localBase = sl<LocalBase>();
    Country? _country = _localBase.getdeviceCountry();
    if (_country == null) {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;
      final position = await Geolocator.getCurrentPosition();
      List<Placemark> address =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = address.first;
      country = placeMark.isoCountryCode!;
    } else {
      country = _country.iso2;
    }
    initializeTimeZones();
    var _d1 = TZDateTime.now(getLocation('Europe/Berlin'));
    var _d2 = TZDateTime.now(getLocation(countryTimeZones[country]!));
    var d1 = DateTime(_d1.year, _d1.month, _d1.day, _d1.hour, _d1.minute,
        _d1.second, _d1.millisecond, _d1.microsecond);
    var d2 = DateTime(_d2.year, _d2.month, _d2.day, _d2.hour, _d2.minute,
        _d2.second, _d2.millisecond, _d2.microsecond);
    Duration duration = d2.difference(d1);
    DateTime _dateTime = RemoteConfigService.getRemoteData.maintenanceTime!;
    if (duration.isNegative) {
      dateTime = DateFormat("HH:mm").format(_dateTime.subtract(duration));
    } else {
      dateTime = DateFormat("HH:mm").format(_dateTime.add(duration));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [HelpIconButton()],
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/maintenance/maintenance.png',
                  height: 300,
                  width: width,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Maintenance break',
                      style: textTheme.headlineMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'The mobile application is unavailabel until ',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                      children: [
                        TextSpan(
                          text: dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.kblue),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'We apologize for the inconvenience. We are working to improve our application to make it work even better.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.kblue),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
