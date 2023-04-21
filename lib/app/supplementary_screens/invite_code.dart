import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class InviteCode extends StatelessWidget {
  const InviteCode({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const InviteCode(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Gap(16),
          Text('Enter invite code\nif you have one',
              style: textTheme.displayMedium
                  ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 20)),
          const Gap(24),
          Text("You can also enter it later on the\ntransfer screen", style: textTheme.bodyMedium!,),
          const Gap(24),
          CustomTextField(
            radius: 8,
            validationColor: AppColor.kSecondaryColor,
            fillColor: Colors.transparent,
            hasBorder: false,
            onChanged: (val) {},
            hint: 'Invite',
          ),
          const Spacer(),
          const CustomYellowElevatedButton(text: "ADD CODE", disable: true,),
          const Gap(24),
        ]),
      ),
      appBar: WidgetsUtil.onBoardingAppBar(context,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 19.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: (){},
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text('Not Now', style: textTheme.titleSmall?.copyWith(fontSize: 16),),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }

  Widget customListTile(String asset, String title) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(asset),
          ),
          decoration: const BoxDecoration(
              color: AppColor.kSecondaryColor, shape: BoxShape.circle),
        ),
        const Gap(12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: AppColor.kOnPrimaryTextColor2,
            letterSpacing: 0.3,
          ),
        ),
        const Spacer(),
        SvgPicture.asset(
          "assets/icons/arrow.svg",
        )
      ],
    );
  }
}
