// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geniuspay/app/auth/pages/sign_up/permissions/notification_permission_page.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class SupportPin extends StatefulWidget {
  const SupportPin({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SupportPin()),
    );
  }

  @override
  State<SupportPin> createState() => _SupportPinState();
}

class _SupportPinState extends State<SupportPin> {
  late ScreenshotController screenshotController = ScreenshotController();

  Future<void> getSupportPin() async {
    final AuthenticationService _authenticationService = sl<AuthenticationService>();
    final result = await _authenticationService.getSupportPIN(_authenticationService.user!.id);
    result.fold((l) => null, (r) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          supportPin = r;
        });
      });
    });
  }

  String supportPin = '';
  @override
  void initState() {
    getSupportPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [AppColor.kAccentColor2, Colors.white],
      )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.kAccentColor2,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: const [Padding(padding: EdgeInsets.only(right: 20), child: HelpIconButton())],
        ),
        backgroundColor: Colors.transparent,
        // backgroundColor: AppColor.kWhiteColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 15,
              right: 30,
              left: 30,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 55),
                  // color: Colors.grey,
                  width: width,
                  child: Column(
                    children: [
                      Text(
                        'Support PIN',
                        style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              'You will be asked to provide',
                              style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'it whenever you contact',
                              style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'geniuspay support team',
                              style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          alignment: Alignment.center,
                          height: height / 5,
                          width: width / 1.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Color(0xffD3F4FE),
                              border: Border.all(color: Color(0xff008AA7), width: 1)
                              // gradient: LinearGradient(
                              //   begin: Alignment.topCenter,
                              //   end: Alignment.bottomCenter,
                              //   colors: const [Color(0xff008AA7), Color(0xffD3F4FE)],
                              // ),
                              ),
                          child: supportPin.isEmpty
                              ? CircularProgressIndicator()
                              : Screenshot(
                                  controller: screenshotController,
                                  child: Text(supportPin,
                                      style: TextStyle(
                                          letterSpacing: 3, color: Color(0xff000000), fontWeight: FontWeight.w600, fontSize: 70)),
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: 'Your geniuspay Support PIN is $supportPin\nKeep it safe. Don\'t share with anyone.'));
                                PopupDialogs(context).informationMessage('Copied to clipboard');
                              },
                              child: SvgPicture.asset(
                                'assets/onboarding/Vector.svg',
                                width: 24.0,
                                height: 24.0,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                if (supportPin.isEmpty) {
                                  PopupDialogs(context).errorMessage('Can not take screenshot now!Please try again.');
                                } else {
                                  takeScreenShotAndSaveImage();
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/onboarding/Vector1.svg',
                                width: 24.0,
                                height: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width / 1.6,
                        margin: EdgeInsets.only(top: 25),
                        child: Text(
                          'geniuspay will never ask you for the PIN on e-mail or SMS. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            right: 30,
            left: 30,
          ),
          height: height / 4,
          width: width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: height / 18, bottom: 25),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Once you close this window, you won’t be able to retrieve this PIN again. ',
                      style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w300, fontSize: 14),
                      children: [
                        TextSpan(
                            text: 'Keep it safe.',
                            style: TextStyle(color: Color(0xff008AA7), fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    )),
              ),
              CustomElevatedButtonAsync(
                child: Text(
                  'PIN IS SAFE',
                  style: TextStyle(color: Color(0xffffffff), fontSize: 14, fontWeight: FontWeight.w600),
                ),
                color: Color(0xff008AA7),
                onPressed: () async {
                  if (Platform.isIOS) {
                    FirebaseMessaging messaging = FirebaseMessaging.instance;
                    await messaging.getNotificationSettings().then((settings) {
                      if (settings.authorizationStatus == AuthorizationStatus.denied ||
                          settings.authorizationStatus == AuthorizationStatus.notDetermined) {
                        NotificationPermision.show(context, true);
                      } else {
                        HomeWidget.show(context);
                      }
                    });
                  } else {
                    HomeWidget.show(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> takeScreenShotAndSaveImage() async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    screenshotController.capture(pixelRatio: pixelRatio, delay: Duration(milliseconds: 10)).then((capturedImage) async {
      if (capturedImage != null) {
        final directory = (await getExternalStorageDirectories(type: StorageDirectory.dcim))!.first;
        final imagePath = await File('${directory.path}/pin.png').create();
        await imagePath.writeAsBytes(capturedImage);

        GallerySaver.saveImage(imagePath.path).then((value) {
          PopupDialogs(context).informationMessage('Success ');
        });
      }
    }).catchError((onError) {
      PopupDialogs(context).errorMessage('Could not take screenshot.Please try again');
    });
  }
}
