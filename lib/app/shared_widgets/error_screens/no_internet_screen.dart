import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class NoInternetScreen extends StatelessWidget {
  final bool showHelp;
  final Function()? onPressed;
  const NoInternetScreen(
      {Key? key, required this.showHelp, required this.onPressed})
      : super(key: key);
  static Future<void> show(
      BuildContext context, bool showHelp, Function() onPressed) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NoInternetScreen(
          showHelp: showHelp,
          onPressed: onPressed,
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
            SvgPicture.asset('assets/splash/error_lamp_robot.svg'),
            const Gap(40),
            Text(
              'Connection Lost!',
              style: textTheme.headlineMedium?.copyWith(
                color: AppColor.kSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            Text(
              'There is a connection error.\nPlease check your internet and try again.',
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
