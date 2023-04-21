import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class OopsScreen extends StatelessWidget {
  final VoidCallback? onRefresh;
  final bool showHelp;
  const OopsScreen({Key? key, required this.onRefresh, required this.showHelp})
      : super(key: key);
  static Future<void> show(
      BuildContext context, VoidCallback? onRefresh, bool showHelp) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OopsScreen(
          onRefresh: onRefresh,
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
            onPressed: onRefresh,
          )),
      backgroundColor: Colors.white,
      appBar: showHelp
          ? WidgetsUtil.appBar(context,
              title: "", backButton: false, actions: const [HelpIconButton()])
          : null,
      body: Center(
          child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
            SvgPicture.asset('assets/splash/error_rocket_destroy.svg'),
            const Gap(40),
            Text(
              'Oops!',
              style: textTheme.headlineMedium?.copyWith(
                color: AppColor.kSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            Text(
              'Something went wrong.\nWe are already working to fix this.',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(100),
          ])),
    );
  }
}
