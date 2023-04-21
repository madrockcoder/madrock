import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/select_document.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class ProofIdentity extends StatelessWidget {
  const ProofIdentity({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ProofIdentity(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: WidgetsUtil.onBoardingAppBar(context,
          backButton: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Text.rich(
              TextSpan(
                text: 'We need to verify\nyour ',
                style: textTheme.bodyMedium?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                children: const [
                  TextSpan(
                    text: 'identity',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const Gap(20),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/bx_id-card.svg'),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        'Make sure you have your Passport or ID Document at hand',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(44),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/video.svg'),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        'We will ask you to record a short video of yourself using the app',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(30),
                ContinueButton(
                  context: context,
                  color: AppColor.kGoldColor2,
                  textColor: Colors.black,
                  onPressed: () async {
                    SelectDocumentPage.show(context);
                  },
                ),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
