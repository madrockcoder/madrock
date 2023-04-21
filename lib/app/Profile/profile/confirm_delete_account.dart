import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/profile/delete_account_page.dart';
import 'package:geniuspay/app/Profile/profile/delete_account_vm.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ConfirmDeleteAccount extends StatefulWidget {
  const ConfirmDeleteAccount({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ConfirmDeleteAccount(),
      ),
    );
  }

  @override
  State<ConfirmDeleteAccount> createState() => _ConfirmDeleteAccountState();
}

class _ConfirmDeleteAccountState extends State<ConfirmDeleteAccount> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomElevatedButtonAsync(
            color: AppColor.kGoldColor2,
            child: Text('DELETE ACCOUNT', style: textTheme.bodyLarge),
            onPressed: () async {
              if (await DeleteAccountVM().canCloseAccount(context)) {
                DeleteAccountPage.show(context);
                // await DeleteAccountVM().closeAccount(context, widget.reason);
              } else {
                final textTheme = Theme.of(context).textTheme;
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 50),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                padding: EdgeInsets.only(
                                    top: 26,
                                    left: 26,
                                    right: 26,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Gap(30),
                                    Text(
                                      'Oops, there was a problem deleting your account',
                                      textAlign: TextAlign.center,
                                      style: textTheme.headlineMedium
                                          ?.copyWith(fontSize: 20),
                                    ),
                                    const Gap(17),
                                    Text(
                                      'Go to the Home screen to check you have no pending transactions or money in your Wallet.\n\nMake sure you have no unclaimed earnings by choosing “Refer a friend” from the profile menu.',
                                      textAlign: TextAlign.center,
                                      style: textTheme.bodyMedium,
                                    ),
                                    const Gap(51),
                                    CustomElevatedButtonAsync(
                                        color: AppColor.kGoldColor2,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'OK',
                                          style: textTheme.titleLarge,
                                        )),
                                    const Gap(32),
                                  ],
                                )),
                            Positioned(
                                top: 0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const CircleAvatar(
                                      backgroundColor: AppColor.kGoldColor2,
                                      child: Icon(
                                        Icons.close,
                                        size: 64,
                                        color: Colors.white,
                                      )),
                                )),
                          ]);
                    });
              }
            }),
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        const CircleBorderIcon(
            gradientStart: AppColor.kSecondaryColor,
            gradientEnd: Colors.white,
            bgColor: AppColor.kSecondaryColor,
            gapColor: Colors.white,
            child: Icon(
              Icons.priority_high,
              size: 41,
              color: Colors.white,
            )),
        const Gap(24),
        Text(
          'Deleting your account is permanent and can’t be undone. It’s free to keep it open.',
          style: textTheme.bodyLarge?.copyWith(fontSize: 16),
        ),
        const Gap(8),
        const Divider(
          color: AppColor.kSecondaryColor,
        ),
        const Gap(8),
        Text(
          'Please note that when you close your account, we’re required by law to store your personal data for 5 years. Please read our privacy policy to find out more.',
          style: textTheme.bodyMedium?.copyWith(color: AppColor.kGreyColor),
        ),
        const Gap(24),
        Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: AppColor.kAccentColor2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColor.kSecondaryColor,
                      size: 16,
                    ),
                    const Gap(16),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'If you would still like to delete your account, please make sure you:\n',
                          style: textTheme.bodyLarge
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                        const Gap(4),
                        Text(
                          '1. You have no pending transactions\n'
                          '2. Your Wallet balance is empty\n'
                          '3. You have no unpaid earnings from invited friends',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                      ],
                    )),
                  ],
                )))
      ]),
    );
  }
}
