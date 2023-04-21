import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/pages/choose_genio_card.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
// import 'package:taskproject/app/shared_widgets/size_config.dart';
// import 'package:taskproject/application/rich_txt_widget.dart';
// import 'package:taskproject/util/button.dart';

// import '../../../application/const.dart';
// import '../../../gen/assets.gen.dart';
// import '../../../presentation/router/routes.dart';
import '../../../util/color_scheme.dart';

class CardCreateScreen extends StatefulWidget {
  const CardCreateScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CardCreateScreen()),
    );
  }

  @override
  State<CardCreateScreen> createState() => _CardCreateScreenState();
}

class _CardCreateScreenState extends State<CardCreateScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        elevation: 0,
        actions: const [HelpIconButton()],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColor.kAccentColor2, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/backgrounds/cards.png',
            ),
            RichText(
              text: TextSpan(
                  text: 'Create a ',
                  style: Theme.of(context).textTheme.displayMedium,
                  children: [
                    TextSpan(
                        text: 'Genio',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 28)),
                    TextSpan(
                        text: ' Card',
                        style: Theme.of(context).textTheme.displayMedium)
                  ]),
            ),
            const Gap(24),
            Text(
              'The customizable, no hidden fee, instant discount debit or credit card',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  side: const BorderSide(color: AppColor.kSecondaryColor),
                  activeColor: AppColor.kSecondaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isSelected,
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {
                    setState(() {
                      isSelected = value!;
                    });
                  },
                ),
                Expanded(
                    child: RichText(
                  text: TextSpan(
                      text: 'I have read and agree to ',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                        TextSpan(
                            text: 'Card related agreements ',
                            style: TextStyle(
                                color: AppColor.kSecondaryColor,
                                fontSize: 12,
                                decoration: TextDecoration.underline)),
                      ]),
                )),
              ],
            ),
            const Gap(32),
            CustomElevatedButton(
              child: Text(
                'GET FREE CARD',
                style: isSelected
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.bodyMedium,
              ),
              onPressed: () {
                if (isSelected) {
                  // Navigator.pushNamed(context, AppRouter.chooseGenioCard);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ChooseGenioCard())));
                }
              },
              color: isSelected ? AppColor.kGoldColor2 : AppColor.kAccentColor2,
              radius: 8,
            ),
            const Gap(32),
          ],
        )),
      ),
    );
  }
}
