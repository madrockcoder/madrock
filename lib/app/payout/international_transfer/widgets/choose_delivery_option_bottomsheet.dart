import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class ChooseDeliveryOptionBottomSheet extends StatefulWidget {
  const ChooseDeliveryOptionBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChooseDeliveryOptionBottomSheet> createState() =>
      _ChooseDeliveryOptionBottomSheetState();
}

class _ChooseDeliveryOptionBottomSheetState
    extends State<ChooseDeliveryOptionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              "Choose delivery option",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.kSecondaryColor),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DeliveryOption deliveryOption = deliveryOptions[index];
              return customDeliveryOptionListTile(deliveryOption);
            },
            itemCount: deliveryOptions.length,
            separatorBuilder: (context, index) {
              return const Divider(
                  color: AppColor.kSecondaryColor, thickness: 0.1);
            },
          ),
        ],
      ),
    );
  }

  Widget customDeliveryOptionListTile(DeliveryOption deliveryOption) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, deliveryOption);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCircularIcon(deliveryOption.iconAsset),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryOption.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColor.kOnPrimaryTextColor2),
                  ),
                  InkWell(
                    onTap: () {
                      deliveryOptions
                          .where((element) => element.key != deliveryOption.key)
                          .forEach((element) {
                        element.isOpened = false;
                      });
                      deliveryOption.isOpened = !deliveryOption.isOpened;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Text(
                          deliveryOption.subtitle,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.kOnPrimaryTextColor2,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          deliveryOption.isOpened
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColor.kSecondaryColor,
                          size: 10,
                        )
                      ],
                    ),
                  ),
                  if (deliveryOption.isOpened)
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(
                            color: AppColor.kSecondaryColor,
                            thickness: 0.1,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                deliveryOption.body.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: RichText(
                                        text: TextSpan(
                                            text: deliveryOption.body[index]
                                                .split("|")[0],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColor
                                                    .kOnPrimaryTextColor2,
                                                fontWeight: deliveryOption
                                                            .body[index]
                                                            .split("|")
                                                            .length >
                                                        1
                                                    ? FontWeight.bold
                                                    : FontWeight.w300),
                                            children: deliveryOption.body[index]
                                                        .split("|")
                                                        .length >
                                                    1
                                                ? [
                                                    TextSpan(
                                                        text: " " +
                                                            deliveryOption
                                                                .body[index]
                                                                .split("|")[1],
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300))
                                                  ]
                                                : null),
                                      ),
                                    )),
                          )
                        ],
                      ),
                    )
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 22.35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (deliveryOption.discountedPrice !=
                        deliveryOption.actualPrice)
                      Text(
                        deliveryOption.discountedPrice.toInt() == 0
                            ? "Free"
                            : "${deliveryOption.currency}${deliveryOption.discountedPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColor.kSecondaryColor,
                            fontSize: 12),
                      ),
                    Text(
                        "${deliveryOption.currency}${deliveryOption.actualPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColor.kOnPrimaryTextColor2,
                            fontSize: 12,
                            decoration: deliveryOption.discountedPrice !=
                                    deliveryOption.actualPrice
                                ? TextDecoration.lineThrough
                                : null))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryOption {
  final Widget iconAsset;
  final String title;
  final String subtitle;
  final String key;
  final List<String> body;
  final double actualPrice;
  final double discountedPrice;
  final String currency;
  final PaymentDeliveryTime deliveryTime;
  bool isOpened = false;

  DeliveryOption(
      {required this.iconAsset,
      required this.title,
      required this.subtitle,
      required this.body,
      required this.actualPrice,
      this.discountedPrice = 0,
      required this.deliveryTime,
      required this.key,
      required this.currency});
}

List<DeliveryOption> deliveryOptions = [
  DeliveryOption(
      iconAsset: SvgPicture.asset('assets/icons/electric_thunder.svg',
          width: 19.24, height: 24),
      title: "Instant",
      subtitle: "Within 30 minutes ",
      key: "instant",
      deliveryTime: PaymentDeliveryTime.instant,
      body: [
        "Your money will reach your receiver’s bank account in 30 minutes",
        "Available for|transfers up to 4,000.00 USD.",
        "Please note|that some banks accept card\npayents only."
      ],
      actualPrice: 0,
      currency: "\$"),
  DeliveryOption(
      iconAsset: SvgPicture.asset('assets/icons/urgent_bell.svg',
          width: 25.41, height: 24),
      title: "Urgent",
      subtitle: "Within 3h",
      deliveryTime: PaymentDeliveryTime.urgent,
      key: "urgent",
      body: [
        "Your money will reach your receiver’s bank account in 30 minutes",
        "Available for|transfers up to 4,000.00 USD.",
        "Please note|that some banks accept card\npayents only."
      ],
      actualPrice: 0,
      currency: "\$"),
  DeliveryOption(
      iconAsset:
          SvgPicture.asset('assets/icons/turtle.svg', width: 24, height: 16.52),
      title: "Regular",
      deliveryTime: PaymentDeliveryTime.regular,
      subtitle: "By today 20:00",
      key: "regular",
      body: [
        "Your money will reach your receiver’s bank account on the next business day.",
      ],
      actualPrice: 0,
      currency: "\$"),
];
