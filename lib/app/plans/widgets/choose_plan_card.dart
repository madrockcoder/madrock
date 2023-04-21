import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ChoosePlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final Function() onTap;
  final bool badge;
  final Color? subtitleColor;
  const ChoosePlanCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onTap,
      this.badge = false,
      this.subtitleColor = AppColor.kSecondaryColor,
      required this.items})
      : super(key: key);
  Widget _checkTile({required String title, required BuildContext context}) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
            width: 12,
            height: 12,
            decoration:
                BoxDecoration(color: subtitleColor, shape: BoxShape.circle),
            child: const Icon(
              Icons.check,
              size: 10,
              color: Colors.white,
            )),
        const Gap(12),
        Expanded(
            child: Text(
          title,
          style: textTheme.bodyMedium,
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: AppColor.kAccentColor2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: textTheme.displaySmall?.copyWith(fontSize: 18),
                          ),
                          Text(
                            subtitle,
                            style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: subtitleColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (badge)
                        const Icon(
                          Icons.verified,
                          size: 32,
                          color: AppColor.kSecondaryColor,
                        )
                    ],
                  ),
                  const Gap(24),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(12),
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        _checkTile(title: items[index], context: context),
                  )
                ],
              ))),
    );
  }
}
