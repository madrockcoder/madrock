import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/profile/confirm_delete_account.dart';
import 'package:geniuspay/app/Profile/security/pages/privacy_settings.dart';
import 'package:geniuspay/app/Profile/security/widgets/marketing_preference.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/supplementary_screens/copy_of_data.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';

class DataPrivacy extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DataPrivacy(),
      ),
    );
  }

  const DataPrivacy({Key? key}) : super(key: key);

  @override
  State<DataPrivacy> createState() => _DataPrivacyState();
}

class _DataPrivacyState extends State<DataPrivacy> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Data & Privacy'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        actions: const [HelpIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomSectionHeading(
                  heading: 'Manage your privacy\nsettings',
                  headingTextStyle: textTheme.titleMedium
                      ?.copyWith(fontSize: 25, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Column(
                    children: [
                      customListTile(
                          title: 'Permissions you’ve given',
                          onTap: () => PrivacySettingsPage.show(context),
                          subtitle:
                              'Keep track of the data and permissions you’re sharing with\nthe apps and sites you use.',
                          icon: "assets/icons/permissions.svg"),
                      customListTile(
                          title: 'Interest-based marketing',
                          onTap: () => MarketingPreference.show(context),
                          subtitle:
                              'See offers and promotions\nbased on your interest on and\noff geniuspay.',
                          icon: "assets/icons/blow-horn.svg")
                    ],
                  ),
                  headingAndChildGap: 16),
              CustomSectionHeading(
                  heading: 'Manage your data',
                  headingTextStyle: textTheme.titleMedium
                      ?.copyWith(fontSize: 25, color: AppColor.kSecondaryColor),
                  topSpacing: 8,
                  child: Column(
                    children: [
                      if(!shouldTemporaryHideForEarlyLaunch)...[
                        customListTile(
                            title: 'Download your data',
                            onTap: () => CopyOfData.show(context),
                            subtitle:
                            'Get a copy of your account data, such as personal and financial information, and activity.',
                            icon: "assets/icons/download-2.svg"),
                        customListTile(
                            title: 'Correct your data',
                            subtitle:
                            'Change or update your personal\nor financial information.',
                            icon: "assets/icons/info-2.svg"),
                      ],
                      customListTile(
                          title: 'Delete your data / close\naccount',
                          onTap: () => ConfirmDeleteAccount.show(context),
                          subtitle:
                              'Ask us to delete your data. To do this, we’ll also need to close your account.',
                          icon: "assets/icons/delete.svg")
                    ],
                  ),
                  headingAndChildGap: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile(
      {required String title, required String subtitle, required String icon, GestureTapCallback? onTap}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap??() {},
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kSecondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCircularIcon(SvgPicture.asset(icon),
                    color: AppColor.kSecondaryColor),
                const Gap(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.headlineSmall,
                      ),
                      Text(
                        subtitle,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kPinDesColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
