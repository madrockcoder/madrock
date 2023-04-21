import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/category.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AssignCategoryBottomSheet extends StatefulWidget {
  const AssignCategoryBottomSheet({Key? key}) : super(key: key);

  @override
  State<AssignCategoryBottomSheet> createState() =>
      _AssignCategoryBottomSheetState();
}

class _AssignCategoryBottomSheetState extends State<AssignCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(37),
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: AppColor.kSecondaryColor,
              )),
          const Gap(24.5),
          Text(
            'Assign a category',
            style:
                textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
          const Gap(8),
          Text(
            'We\'ll show you insights based on this',
            style: textTheme.bodyMedium
                ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
          ),
          const Gap(32),
          Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .80),
              child: GridView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    category(categoryIcons[index], textTheme),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 16),
                itemCount: categoryIcons.length,
              )),
          const Gap(32),
        ],
      ),
    );
  }

  Widget category(Category icon, textTheme) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context, icon);
        },
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.kAccentColor2),
              child: icon.getIcon(22),
            ),
            const Gap(16),
            Center(
              child: Text(
                icon.text,
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
