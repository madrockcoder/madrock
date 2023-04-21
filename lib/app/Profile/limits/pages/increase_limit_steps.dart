import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

class IncreaseLimitSteps extends StatefulWidget {
  const IncreaseLimitSteps({Key? key}) : super(key: key);

  @override
  State<IncreaseLimitSteps> createState() => _IncreaseLimitStepsState();
}

class _IncreaseLimitStepsState extends State<IncreaseLimitSteps> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        centerTitle: true,
        title: Text(
          'Limits',
          style: textTheme.titleLarge
              ?.copyWith(color: AppColor.kOnPrimaryTextColor),
        ),
        actions: const [HelpIconButton()],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        // color: Colors.black,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1.',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium
                  ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 35),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Take a photo of one of the\nfollowing documents',
              style: textTheme.bodyMedium?.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Image.asset(
                  'assets/limits/utility_bill.png',
                  width: 22,
                ),
                backgroundColor: AppColor.kAccentColor2,
              ),
              title: Text(
                'Utility bill',
                style: textTheme.titleMedium,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Image.asset(
                  'assets/limits/bank_statement.png',
                  width: 22,
                ),
                backgroundColor: AppColor.kAccentColor2,
              ),
              title: Text(
                'Bank statement',
                style: textTheme.titleMedium,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Image.asset(
                  'assets/limits/tax.png',
                  width: 22,
                ),
                backgroundColor: AppColor.kAccentColor2,
              ),
              title: Text(
                'Council tax bill',
                style: textTheme.titleMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                '2.',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   'Send us these photos via in-app chat or send via email',
            //   style: textTheme.bodyText2,
            // ),
            RichText(
              text: TextSpan(
                text: 'Send us these photos via ',
                style: textTheme.bodyMedium?.copyWith(fontSize: 20),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final intercom = Intercom.instance;
                        await intercom.initialize(
                          'mv21loa3',
                          androidApiKey:
                              'android_sdk-45626d2f69fdc328a4efde6e1cb8a83b91b09389',
                          iosApiKey:
                              'ios_sdk-1fccbb06ca519b815fd7b7b559e3363edbb64595',
                        );
                        final AuthenticationService _authenticationService =
                            sl<AuthenticationService>();
                        if (_authenticationService.user == null) {
                          await intercom.loginUnidentifiedUser();
                        } else {
                          await intercom.loginIdentifiedUser(
                              userId: _authenticationService
                                  .user!.userProfile.customerNumber,
                              statusCallback: IntercomStatusCallback(
                                  onSuccess: () {}, onFailure: (failure) {}));
                          await intercom.updateUser(
                            email: _authenticationService.user!.email,
                            name:
                                "${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}",
                            phone: _authenticationService
                                .user?.userProfile.mobileNumber?.number,
                          );
                        }
                        await intercom.displayMessenger();
                      },
                    text: 'in-app chat ',
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: 20, color: AppColor.kSecondaryColor),
                  ),
                  TextSpan(
                    text: 'or send ',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 20),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        notNow(context);
                      },
                    text: 'via email',
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: 20, color: AppColor.kSecondaryColor),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                '3.',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Wait a bit',
              style: textTheme.bodyMedium?.copyWith(fontSize: 20),
            ),
            const Gap(120),
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: CustomElevatedButton(
            color: AppColor.kGoldColor2,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'NOT NOW',
              style: textTheme.bodyLarge,
            )),
      ),
    );
  }
}

Future<Future<String?>> notNow(BuildContext context) async {
  final authenticationService = sl<AuthenticationService>();
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      final height = MediaQuery.of(context).size.height;
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
            height: height / 2.6,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                Text(
                  'Or you can email the photos to\nkyc@geniuspay.com using '
                  '"KYC '
                  '${authenticationService.user?.userProfile.customerNumber}"'
                  ' as a subject line',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium,
                ),
                const Divider(
                  color: AppColor.kAccentColor2,
                  height: 50,
                  thickness: 1,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    Clipboard.setData(
                        const ClipboardData(text: 'kyc@geniuspay.com'));
                    PopupDialogs(context)
                        .informationMessage('Copied email to clipboard');
                  },
                  leading: SvgPicture.asset(
                    'assets/icons/copy.svg',
                    width: 16,
                    height: 16,
                  ),
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(
                      'Copy email',
                      style: textTheme.titleMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text:
                            'KYC ${authenticationService.user?.userProfile.customerNumber}'));
                    PopupDialogs(context)
                        .informationMessage('Copied subject to clipboard');
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/copy.svg",
                    width: 16,
                    height: 16,
                  ),
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(
                      'Copy subject line',
                      style: textTheme.titleMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ),
                )
              ],
            )),
      );
    },
  );
}
