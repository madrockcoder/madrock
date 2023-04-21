import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/general/view_models/notification_settings_vm.dart';
import 'package:geniuspay/app/Profile/security/widgets/switch_tile.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/util/color_scheme.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NotificationsSettingsPage(),
      ),
    );
  }

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationsSettingsPage> {
  bool securityUnusual = false;

  bool newsLatest = true;
  bool newsFeatures = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<NotificationSettingsVM>(onModelReady: (p0) {
      securityUnusual = p0.notificationOption!.unusualActivity!;

      newsLatest = p0.notificationOption!.salesNews!;
      newsFeatures = p0.notificationOption!.newFeatures!;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    }, builder: (context, model, snapshot) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Notifications'),
            actions: const [HelpIconButton()],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(24),
            child: CustomElevatedButtonAsync(
              color: AppColor.kGoldColor2,
              child: const Text('SAVE'),
              onPressed: securityUnusual !=
                          model.notificationOption!.unusualActivity! ||
                      newsLatest != model.notificationOption!.salesNews! ||
                      newsFeatures != model.notificationOption!.newFeatures!
                  ? () async {
                      // _localBase.setNotificationSettings({
                      //   'security_unusual_activity': securityUnusual,
                      //   'security_new_signin': securityNewDevice,
                      //   'news_latest': newsLatest,
                      //   'news_updates': newsFeatures,
                      // });
                      await model.updateNotificationSettings(
                          context: context,
                          changedNotificationOption: NotificationOption(
                              unusualActivity: securityUnusual,
                              salesNews: newsLatest,
                              newFeatures: newsFeatures));

                      setState(() {});
                    }
                  : null,
            ),
          ),
          body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const Gap(16),
                Text(
                  'Security Alerts',
                  style: textTheme.bodyLarge,
                ),
                const Gap(16),
                SwitchTile(
                    onChanged: (val) {
                      setState(() {
                        securityUnusual = val;
                      });
                    },
                    titleStyle: textTheme.bodyMedium,
                    title: 'Notify me whenever there is an unsual activity.',
                    value: securityUnusual),
                const Gap(16),
                SwitchTile(
                    onChanged: null,
                    titleStyle: textTheme.bodyMedium,
                    title: 'Notify me when a new device is used to sign in.',
                    value: true),
                const Gap(16),
                const Divider(
                  height: 1,
                  color: AppColor.kAccentColor2,
                ),
                const Gap(16),
                Text(
                  'News',
                  style: textTheme.bodyLarge,
                ),
                const Gap(16),
                SwitchTile(
                    onChanged: (val) {
                      setState(() {
                        newsLatest = val;
                      });
                    },
                    titleStyle: textTheme.bodyMedium,
                    title: 'Notify me about sales and latest news',
                    value: newsLatest),
                const Gap(16),
                SwitchTile(
                    onChanged: (val) {
                      setState(() {
                        newsFeatures = val;
                      });
                    },
                    titleStyle: textTheme.bodyMedium,
                    title: 'Notify me about new features and updates',
                    value: newsFeatures),
              ]));
    });
  }
}
