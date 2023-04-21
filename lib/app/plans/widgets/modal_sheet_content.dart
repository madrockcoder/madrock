import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ModalSheet extends StatelessWidget {
  final PlanModalContent modalContent;
  const ModalSheet({Key? key, required this.modalContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: AppColor.kSecondaryColor,
                ))),
        const Gap(16),
        CircleBorderIcon(
            gradientStart: AppColor.kSecondaryColor,
            gradientEnd: Colors.white,
            gapColor: Colors.white,
            bgColor: AppColor.kAccentColor2,
            child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  modalContent.asset,
                  width: 55,
                ))),
        const Gap(16),
        Text(
          modalContent.title,
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(16),
        Text(
          modalContent.subtitle,
          textAlign: TextAlign.center,
        ),
        const Gap(24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 50,
                color: Color.fromRGBO(7, 5, 26, 0.07),
                offset: Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'PLAN COMPARISON',
              style: textTheme.bodyLarge
                  ?.copyWith(color: AppColor.kSecondaryColor),
            ),
            const Gap(16),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: AppColor.kAccentColor2),
                itemCount: modalContent.tileContents.length,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 80,
                            child: Text(
                              modalContent.tileContents[index].planName,
                              style: textTheme.headlineSmall,
                            )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              modalContent.tileContents[index].title,
                              style: textTheme.headlineSmall?.copyWith(
                                  color:
                                      modalContent.tileContents[index].color),
                            ),
                            const Gap(4),
                            Text(
                              modalContent.tileContents[index].subtitle,
                            ),
                          ],
                        ))
                      ],
                    )))
          ]),
        ),
        const Gap(36),
        CustomElevatedButton(
          color: AppColor.kGoldColor2,
          child: const Text('GOT IT'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class PlanModalContent {
  final Color color;
  final String asset;
  final String title;
  final String subtitle;
  final List<ComparisonContent> tileContents;
  PlanModalContent({
    required this.tileContents,
    required this.color,
    required this.asset,
    required this.title,
    required this.subtitle,
  });
}

class ComparisonContent {
  final Color color;
  final String planName;
  final String title;
  final String subtitle;
  ComparisonContent({
    required this.planName,
    required this.color,
    required this.title,
    required this.subtitle,
  });
}
