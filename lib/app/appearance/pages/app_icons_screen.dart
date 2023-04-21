// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

//for Radio button

var _groupValue = 0;

//
class AppIcons extends StatefulWidget {
  const AppIcons({Key? key}) : super(key: key);

  @override
  State<AppIcons> createState() => _AppIconsState();
}

class _AppIconsState extends State<AppIcons> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/share_with_contact/arrowback.svg',
              fit: BoxFit.scaleDown,
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          title: Center(
            child: Text(
              'App icon',
              style: textTheme.titleLarge
                  ?.copyWith(color: AppColor.kOnPrimaryTextColor),
            ),
          ),
          actions: [
            HelpIconButton(
              onTap: () {},
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/blue.svg'),
                title: Text(
                  'Blue',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 0
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 0,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/orange.svg'),
                title: Text(
                  "Orange",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 1
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 1,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/yellow.svg'),
                title: Text(
                  "Yellow",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 2
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 2,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/red.svg'),
                title: Text(
                  "Red",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 3
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 3,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/white.svg'),
                title: Text(
                  "White",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 4
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 4,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/black.svg'),
                title: Text(
                  "Black",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 5
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 5,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/app_icons/ukraine.png'),
                title: Text(
                  "Ukraine",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 6
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 6,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/app_icons/pride.svg'),
                title: Text(
                  "Pride",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                trailing: _groupValue == 7
                    ? Container(
                        margin: EdgeInsets.only(right: 12.5),
                        child: Icon(
                          Icons.check_circle,
                          size: 22,
                          color: Color(0xff008AA7),
                        ),
                      )
                    : Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xff008AA7)),
                        value: 7,
                        groupValue: _groupValue,
                        activeColor: Color(0xff008AA7),
                        onChanged: (value) {
                          setState(() {
                            _groupValue = value as int;
                          });
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
