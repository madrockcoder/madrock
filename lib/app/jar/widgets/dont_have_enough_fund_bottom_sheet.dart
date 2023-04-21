import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/jar/widgets/assets.gen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

dontHaveEnoughFundButtomSheet(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  return showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
    ),
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 21),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Center(
                child: FractionalTranslation(
                  translation: const Offset(0, -0.5),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Assets.backgrounds.yellowArc.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
        Text('Oops!', style: textTheme.titleLarge),
        const Gap(16),
        SizedBox(
          width: 260,
          child: Text(
              'It looks like you don’t have enough funds in your Wallet to complete this request',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge),
        ),
        const Gap(47),
        FractionallySizedBox(
            widthFactor: 0.8,
            child: CustomElevatedButton(
              onPressed: () {},
              radius: 8,
              color: AppColor.kGoldColor2,
              child: Text('ADD MONEY', style: textTheme.bodyLarge),
            )),
        const Gap(19),
        CustomElevatedButton(
          onPressed: () {},
          radius: 8,
          color: Colors.transparent,
          child: Text('CANCEL', style: textTheme.bodyLarge),
        ),
        const Gap(56),
      ],
    ),
  );
}
