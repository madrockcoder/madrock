import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/landing_page.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:provider/provider.dart';

class NotificationPermision extends StatefulWidget {
  const NotificationPermision({
    Key? key,
    required this.value,
    required this.signup,
  }) : super(key: key);
  final AuthProvider value;
  final bool signup;

  static Future<void> show(BuildContext context, bool signup) async {
    if (signup) {
      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => Consumer<AuthProvider>(
              builder: (_, value, __) => NotificationPermision(
                value: value,
                signup: signup,
              ),
            ),
          ),
          (route) => false);
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Consumer<AuthProvider>(
            builder: (_, value, __) => NotificationPermision(
              value: value,
              signup: signup,
            ),
          ),
        ),
      );
    }
  }

  @override
  State<NotificationPermision> createState() => _NotificationPermisionState();
}

class _NotificationPermisionState extends State<NotificationPermision> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: AppColor.kAccentColor2,
        actions: const [HelpIconButton()],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/iphone.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.46,
              // width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Keep on top of things',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'Get alerts and updates on your money in real-time\nas you spend it, when you\'re running low and when it is time to pay your bills',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  ContinueButton(
                    context: context,
                    color: AppColor.kGoldColor2,
                    textColor: Colors.black,
                    onPressed: () async {
                      FirebaseMessaging messaging = FirebaseMessaging.instance;

                      await messaging.requestPermission(
                        alert: true,
                        announcement: false,
                        badge: true,
                        carPlay: false,
                        criticalAlert: false,
                        provisional: false,
                        sound: true,
                      );
                      if (widget.signup) {
                        LandingPage.show(context);
                      } else {
                        Navigator.pop(context);
                      }

                      // }
                    },
                    text: 'GET NOTIFICATIONS ',
                  ),
                  const SizedBox(height: 23.0),
                  TextButton(
                      child: Text(
                        'NOT NOW',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        if (widget.signup) {
                          LandingPage.show(context);
                        } else {
                          Navigator.pop(context);
                        }
                      }
                      // onPressed: () => widget.value.authType == AuthType.logIn
                      //     ? TabsRouter.show(context)
                      //     : KYCPage.show(context, value: widget.value),
                      ),
                  const SizedBox(height: 10.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
