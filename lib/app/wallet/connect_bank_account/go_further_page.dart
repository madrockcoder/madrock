import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/widgets/payment_webview_template.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/select_bank_vm.dart';
import 'package:geniuspay/models/connect_bank_response.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/color_scheme.dart';

class GoFurtherPage extends StatelessWidget {
  final ConnectBankResponse response;
  final NordigenBank bank;
  const GoFurtherPage({Key? key, required this.response, required this.bank})
      : super(key: key);
  static Future<void> show(BuildContext context, ConnectBankResponse response,
      NordigenBank bank) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GoFurtherPage(
          response: response,
          bank: bank,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleTheme = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 25, color: AppColor.kSecondaryColor);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: AppColor.kAccentColor2,
          appBar: AppBar(
            backgroundColor: AppColor.kAccentColor2,
            title: const Text('Link a bank'),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  CircleBorderIcon(
                    gradientStart: const Color(0xff008AA7).withOpacity(.2),
                    gradientEnd: AppColor.kAccentColor2,
                    gapColor: AppColor.kAccentColor2,
                    bgColor: Colors.white,
                    child: Image.asset(
                      'assets/wallets/nordigen_logo.png',
                      width: 40,
                    ),
                  ),
                  const Gap(32),
                  Text(
                    'You will be redirected to the bank website to confirm the added account',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                        fontSize: 20, color: AppColor.kSecondaryColor),
                  ),
                  const Gap(16),
                  const Text(
                    'Prepare necessary data to log in to your account.',
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  const Text(
                    'After authorization, you will go back to geniuspay app.',
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  CustomElevatedButtonAsync(
                      color: AppColor.kSecondaryColor,
                      onPressed: () async {
                        final baseUrl =
                            RemoteConfigService.getRemoteData.baseUrl ??
                                'https://8b84-2a01-114f-400c-3800-b4a9-6ce9-ba01-5a42.ngrok.io';
                        final url = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentWebViewTemplate(
                                    url: "${response.initiateUrl}${bank.id}",
                                    completedUrl:
                                        '$baseUrl/events/nordigen-callback',
                                  )),
                        );
                        await SelectBankVM()
                            .getStatus(context, response.id, bank);
                      },
                      child: Text(
                        'GO FURTHER',
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        HomeWidget.show(context, resetUser: true);
                      },
                      child: Text('BACK HOME', style: textTheme.bodyLarge)),
                  const Gap(24),
                ],
              )),
        ));
  }
}
