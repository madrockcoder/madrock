import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class ServerDownScreen extends StatelessWidget {
  final Function()? onPressed;
  final bool showHelp;
  const ServerDownScreen({Key? key, this.onPressed, required this.showHelp})
      : super(key: key);
  static Future<void> show(
      {required BuildContext context,
      Function()? onPressed,
      required bool showHelp}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServerDownScreen(
          onPressed: onPressed,
          showHelp: showHelp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButton(
            child: Text(
              'TRY AGAIN',
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            onPressed: onPressed,
          )),
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
            SvgPicture.asset('assets/splash/error_broken_robot.svg'),
            const Gap(40),
            Text(
              'Our Server is feeling down!',
              style: textTheme.headlineMedium?.copyWith(
                color: AppColor.kSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            Text(
              'Please try again in a few moments.\nWe\'ll be back up in no time.',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(100),
          ])),
      appBar: showHelp
          ? WidgetsUtil.appBar(context,
              title: "", backButton: false, actions: const [HelpIconButton()])
          : null,
    );
  }
}
