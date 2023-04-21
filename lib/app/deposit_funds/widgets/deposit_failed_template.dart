import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/label_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/round_button.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DepositFailedTemplate extends StatefulWidget {
  final String walletId;
  const DepositFailedTemplate({
    Key? key,
    required this.walletId,
  }) : super(key: key);

  static Future<void> show(BuildContext context, String walletId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DepositFailedTemplate(
          walletId: walletId,
        ),
      ),
    );
  }

  @override
  State<DepositFailedTemplate> createState() => _DepositFailedTemplateState();
}

class _DepositFailedTemplateState extends State<DepositFailedTemplate> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffFFB6C3), AppColor.kWhiteColor],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(240),
                        const CircleBorderIcon(
                            gradientStart: AppColor.kRedColor,
                            gradientEnd: Colors.white,
                            gapColor: Color(0xffFFB6C3),
                            bgColor: AppColor.kRedColor,
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 42,
                            )),
                        const Gap(22),
                        Text(
                          'Deposit failed!',
                          style: textTheme.displaySmall
                              ?.copyWith(color: AppColor.kRedColor),
                        ),
                        const Gap(22),
                        Text(
                          'Please try again later or use a\ndifferent transfer method',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 18),
                        ),
                        const Gap(60),
                        tryAgainButton(),
                        const Gap(10),
                        backHomeButton()
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget tryAgainButton() {
    return RoundButton(
      voidCallback: () {
        Navigator.pop(context);
      },
      backgroundColor: AppColor.kRedColor,
      label: 'TRY AGAIN',
    );
  }

  Widget backHomeButton() {
    return LabelButton(
      voidCallback: () {
        HomeWidget.show(context, defaultPage: 0, showWalletId: widget.walletId);
      },
      label: 'BACK HOME',
      labelColor: AppColor.kRedColor,
    );
  }
}
