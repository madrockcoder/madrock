import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';

class VerifyDocuments extends StatefulWidget {
  static Future<void> show(BuildContext context, String customerNumber) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VerifyDocuments(customerNumber: customerNumber),
      ),
    );
  }

  final String customerNumber;

  const VerifyDocuments({Key? key, required this.customerNumber})
      : super(key: key);

  @override
  State<VerifyDocuments> createState() => _VerifyDocumentsState();
}

class _VerifyDocumentsState extends State<VerifyDocuments> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: const Text('')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleBorderIcon(
              gradientStart: const Color(0xff7ed8fc).withOpacity(.2),
              gradientEnd: AppColor.kWhiteColor,
              gapColor: Colors.white,
              size: 200,
              bgColor: AppColor.kAccentColor2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/briefcase.png',
                ),
              ),
            ),
            const Gap(40),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('Oops, we need to verify some documents',
                    style: textTheme.headlineMedium
                        ?.copyWith(color: AppColor.kSecondaryColor),
                    textAlign: TextAlign.center)),
            const Gap(16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    'Another person is indicated as the Director in the register of legal entities. Please open an account via our website at ',
                style: textTheme.bodyMedium
                    ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                children: [
                  TextSpan(
                    text: 'www.geniuspay.com',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Essentials.launchCustomUrl(
                          Uri.parse(
                              "https://geniuspay.com/business-onboarding/submit-documents/${widget.customerNumber}"),
                          context),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.kblue),
                  ),
                ],
              ),
            ),
            const Gap(32),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: CustomYellowElevatedButton(
                onTap: () {
                  Essentials.launchCustomUrl(
                      Uri.parse(
                          "https://geniuspay.com/business-onboarding/submit-documents/${widget.customerNumber}"),
                      context);
                },
                text: "OPEN VIA WEBSITE",
              ),
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
