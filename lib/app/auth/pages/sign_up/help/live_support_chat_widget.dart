import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:geniuspay/app/supplementary_screens/about.dart';

class LiveSupportChatWidget extends StatefulWidget {
  const LiveSupportChatWidget({Key? key}) : super(key: key);

  @override
  State<LiveSupportChatWidget> createState() => _LiveSupportChatWidgetState();
}

class _LiveSupportChatWidgetState extends State<LiveSupportChatWidget> {
  final intercom = Intercom.instance;
  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await intercom.initialize(
      'mv21loa3',
      androidApiKey: 'android_sdk-45626d2f69fdc328a4efde6e1cb8a83b91b09389',
      iosApiKey: 'ios_sdk-1fccbb06ca519b815fd7b7b559e3363edbb64595',
    );
    final AuthenticationService _authenticationService =
        sl<AuthenticationService>();
    if (_authenticationService.user == null) {
      await intercom.loginUnidentifiedUser();
    } else {
      await intercom.loginIdentifiedUser(
          userId: _authenticationService.user!.userProfile.customerNumber,
          statusCallback: IntercomStatusCallback(
              onSuccess: () {}, onFailure: (failure) {}));
      await intercom.updateUser(
          email: _authenticationService.user!.email,
          name:
              "${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}",
          phone: _authenticationService.user?.userProfile.mobileNumber?.number,
          customAttributes: {"app_version": version});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.kAccentColor2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/images/help_chat.svg'),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Support chat',
                  style: textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.kSecondaryColor,
                  ),
                ),
                const Gap(10),
                Text(
                  'We are here to support you 24/7, start a conversation with us if you experience any questions, issues or concerns.',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.kOnPrimaryTextColor2,
                  ),
                ),
                const Gap(10),
                SizedBox(
                  width: 150,
                  child: CustomElevatedButton(
                    onPressed: () async {
                      await intercom.displayMessenger();
                    },
                    color: AppColor.kGoldColor2,
                    disabledColor: AppColor.kAccentColor2,
                    child: Text(
                      'ENTER A CHAT',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
