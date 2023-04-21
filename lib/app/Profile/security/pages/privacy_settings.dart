import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/security/widgets/data_preference.dart';
import 'package:geniuspay/app/Profile/security/widgets/switch_tile.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PrivacySettingsPage(),
      ),
    );
  }

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  final LocalBase localBase = sl<LocalBase>();
  bool defaultNotificationActions = false;
  bool billsCalendar = false;
  @override
  void initState() {
    defaultNotificationActions =
        localBase.getPrivacySettings()['default_notification_actions'] as bool;
    billsCalendar = localBase.getPrivacySettings()['bills_calendar'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Privacy Settings'),
        actions: const [HelpIconButton()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomElevatedButton(
          color: AppColor.kGoldColor2,
          onPressed: defaultNotificationActions !=
                      (localBase.getPrivacySettings()[
                          'default_notification_actions']) ||
                  billsCalendar !=
                      localBase.getPrivacySettings()['bills_calendar']
              ? () {
                  localBase.setPrivacySettings({
                    'data_preference_performance': localBase
                        .getPrivacySettings()['data_preference_performance'],
                    'data_preference_targeting': localBase
                        .getPrivacySettings()['data_preference_targeting'],
                    'marketing_preference_pushnotif': localBase
                        .getPrivacySettings()['marketing_preference_pushnotif'],
                    'marketing_preference_email': localBase
                        .getPrivacySettings()['marketing_preference_email'],
                    'marketing_preference_sms': localBase
                        .getPrivacySettings()['marketing_preference_sms'],
                    'marketing_preference_parter': localBase
                        .getPrivacySettings()['marketing_preference_parter'],
                    'default_notification_actions': defaultNotificationActions,
                    'bills_calendar': billsCalendar
                  });
                  PopupDialogs(context)
                      .successMessage('successfully updated settings');
                  setState(() {});
                }
              : null,
          child: const Text('SAVE'),
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            ListTile(
                onTap: () {
                  DataPreference.show(context);
                },
                title: const Text('Data Preference'),
                trailing: const Icon(
                  Icons.arrow_right_rounded,
                  size: 38,
                  color: AppColor.kSecondaryColor,
                )),
            SwitchTile(
              onChanged: (val) {
                setState(() {
                  defaultNotificationActions = val;
                });
              },
              title: 'Default Notification Actions',
              subtitle:
                  'You want to receive bill reminders before a bill is due',
              value: defaultNotificationActions,
            ),
            const Gap(16),
            SwitchTile(
              onChanged: (val) {
                setState(() {
                  billsCalendar = val;
                });
              },
              title: 'Bills Calendar',
              subtitle:
                  'You want to receive bill reminder emails before a bill.',
              value: billsCalendar,
            ),
          ]),
    );
  }
}
