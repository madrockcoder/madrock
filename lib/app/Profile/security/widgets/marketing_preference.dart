import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/general/view_models/notification_settings_vm.dart';
import 'package:geniuspay/app/Profile/security/widgets/switch_tile.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/util/color_scheme.dart';

class MarketingPreference extends StatefulWidget {
  const MarketingPreference({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const MarketingPreference(),
      ),
    );
  }

  @override
  State<MarketingPreference> createState() => _MarketingPreferenceState();
}

class _MarketingPreferenceState extends State<MarketingPreference> {
  bool pushnotif = true;
  bool emailoffers = true;
  bool smsoffers = true;
  bool partneroffers = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationSettingsVM>(onModelReady: (p0) {
      pushnotif = p0.notificationOption!.pushNotificationOffers!;
      emailoffers = p0.notificationOption!.emailOffers!;
      smsoffers = p0.notificationOption!.smsOffers!;
      partneroffers = p0.notificationOption!.partnerOffers!;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    }, builder: (context, model, snapshot) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Marketing Preference'),
          actions: const [HelpIconButton()],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButtonAsync(
            color: AppColor.kGoldColor2,
            child: const Text('SAVE'),
            onPressed: pushnotif !=
                        model.notificationOption!.pushNotificationOffers! ||
                    emailoffers != model.notificationOption!.emailOffers! ||
                    smsoffers != model.notificationOption!.smsOffers! ||
                    partneroffers != model.notificationOption!.partnerOffers!
                ? () async {
                    await model.updateNotificationSettings(
                        context: context,
                        changedNotificationOption: NotificationOption(
                            pushNotificationOffers: pushnotif,
                            emailOffers: emailoffers,
                            smsOffers: smsoffers,
                            partnerOffers: partneroffers));
                    setState(() {});
                  }
                : null,
          ),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const Gap(32),
              SwitchTile(
                onChanged: (val) {
                  setState(() {
                    pushnotif = val;
                  });
                },
                title: 'Push Notifications Offers',
                subtitle:
                    'Get marketing messages, promotions and exclusive offers on your mobile phone. If switched off, you would still receive notification about your account status and transactions.',
                value: pushnotif,
              ),
              const Gap(16),
              SwitchTile(
                onChanged: (val) {
                  setState(() {
                    emailoffers = val;
                  });
                },
                title: 'Email Offers',
                subtitle:
                    'Get marketing messages, promotions and exclusive offers in your inbox.',
                value: emailoffers,
              ),
              const Gap(16),
              SwitchTile(
                onChanged: (val) {
                  setState(() {
                    smsoffers = val;
                  });
                },
                title: 'SMS Offers',
                subtitle:
                    "Get marketing messages, promotions and exclusive offers via text.",
                value: smsoffers,
              ),
              const Gap(16),
              SwitchTile(
                onChanged: (val) {
                  setState(() {
                    partneroffers = val;
                  });
                },
                title: 'Partner Offers',
                subtitle:
                    "Get offers from geniuspay partners. We'll not share your personal data",
                value: partneroffers,
              ),
            ]),
      );
    });
  }
}
