import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/appearance/pages/app_icons_screen.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

//for dark theme swicth
bool darkThemeSwitch = false;

//
class AppAppearance extends StatefulWidget {
  const AppAppearance({Key? key}) : super(key: key);

  @override
  State<AppAppearance> createState() => _AppAppearanceState();
}

class _AppAppearanceState extends State<AppAppearance> {
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
              'App appearance',
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
              ListTile(
                leading:
                    SvgPicture.asset('assets/app_appearance/dark-mode.svg'),
                title: Text(
                  'Dark mode',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                ),
                subtitle: Text(
                  'Change your app theme',
                  style: textTheme.titleSmall
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                ),
                trailing: CupertinoSwitch(
                  activeColor: const Color(0xffE0F7FE),
                  trackColor: const Color(0xffE0F7FE),
                  value: darkThemeSwitch,
                  onChanged: (value) {
                    setState(() {
                      darkThemeSwitch = value;
                    });
                  },
                ),
              ),
              ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AppIcons())));
                  },
                  leading:
                      SvgPicture.asset('assets/app_appearance/app-icon.svg'),
                  title: Text(
                    'App icon',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                  subtitle: Text(
                    'Choose your app icon',
                    style: textTheme.titleSmall
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                  ),
                  trailing: SvgPicture.asset(
                    'assets/faq/Arrow - Down.svg',
                    width: 14.0,
                    height: 14.0,
                  )),
              ListTile(
                  leading: SvgPicture.asset('assets/app_appearance/home.svg'),
                  title: Text(
                    'Home',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                  subtitle: Text(
                    'customise your home screen',
                    style: textTheme.titleSmall
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                  ),
                  trailing: SvgPicture.asset(
                    'assets/faq/Arrow - Down.svg',
                    width: 14.0,
                    height: 14.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
