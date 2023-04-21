import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/security/widgets/switch_tile.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DataPreference extends StatefulWidget {
  const DataPreference({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DataPreference(),
      ),
    );
  }

  @override
  State<DataPreference> createState() => _DataPreferenceState();
}

class _DataPreferenceState extends State<DataPreference> {
  final LocalBase localBase = sl<LocalBase>();
  bool performance = true;
  bool targeting = true;
  @override
  void initState() {
    performance =
        localBase.getPrivacySettings()['data_preference_performance'] as bool;
    targeting =
        localBase.getPrivacySettings()['data_preference_targeting'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Data Preference'),
        actions: const [HelpIconButton()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomElevatedButton(
          color: AppColor.kGoldColor2,
          child: const Text('SAVE'),
          onPressed: performance !=
                      (localBase.getPrivacySettings()[
                          'data_preference_performance']) ||
                  targeting !=
                      localBase
                          .getPrivacySettings()['data_preference_targeting']
              ? () {
                  localBase.setPrivacySettings({
                    'data_preference_performance': performance,
                    'data_preference_targeting': targeting,
                    'marketing_preference_pushnotif': localBase
                        .getPrivacySettings()['marketing_preference_pushnotif'],
                    'marketing_preference_email': localBase
                        .getPrivacySettings()['marketing_preference_email'],
                    'marketing_preference_sms': localBase
                        .getPrivacySettings()['marketing_preference_sms'],
                    'marketing_preference_parter': localBase
                        .getPrivacySettings()['marketing_preference_parter'],
                    'default_notification_actions': localBase
                        .getPrivacySettings()['default_notification_actions'],
                    'bills_calendar':
                        localBase.getPrivacySettings()['bills_calendar'],
                  });
                  PopupDialogs(context)
                      .successMessage('successfully updated settings');
                  setState(() {});
                }
              : null,
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const Gap(32),
            const Text(
                'We will collect data which is strictly necessary for us to provide our service whether via web or mobile. We would like your consent to collect data while you use your account for the purpose below'),
            const Gap(32),
            const Divider(
              height: 1,
              color: AppColor.kSecondaryColor,
            ),
            const Gap(32),
            SwitchTile(
              onChanged: (val) {
                setState(() {
                  performance = val;
                });
              },
              title: 'Performance',
              subtitle:
                  'The data is used to optimise the service and ensure the account runs smoothly including e.g crash logs',
              value: performance,
            ),
            const Gap(16),
            SwitchTile(
              onChanged: (val) {
                setState(() {
                  targeting = val;
                });
              },
              title: 'Targeting',
              subtitle: "This helps us decide which product "
                  "and offers may be relevant to you. We will use this data to tailor ads to you"
                  "on social media, in account and other websites",
              value: targeting,
            ),
          ]),
    );
  }
}
