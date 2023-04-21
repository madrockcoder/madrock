import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/home/view_models/home_view_model.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class HomeWalletWidget extends StatefulWidget {
  final TotalAmount? totalAmount;
  final HomeViewModel model;
  const HomeWalletWidget(
      {Key? key, required this.totalAmount, required this.model})
      : super(key: key);

  @override
  State<HomeWalletWidget> createState() => _HomeWalletWidgetState();
}

class _HomeWalletWidgetState extends State<HomeWalletWidget> {
  final _converter = Converter();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              'Total Balance',
              style: textTheme.bodyMedium
                  ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                widget.model.changeShowBalance();
                // setState(() {
                //   show = !show;
                // });
              },
              child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  widget.model.showBalance
                      ? 'assets/images/hide.svg'
                      : 'assets/images/Show.svg',
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _converter.getCurrency("${widget.totalAmount?.currency}"),
              style: textTheme.displayLarge?.copyWith(
                color: AppColor.kSecondaryColor,
                fontSize: 44,
              ),
            ),
            Text(
              widget.model.showBalance
                  ? "${widget.totalAmount?.value}"
                  : '******',
              style: textTheme.displayLarge?.copyWith(
                color: AppColor.kSecondaryColor,
                fontSize: 44,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: AppColor.kSecondaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "${widget.totalAmount?.currency}",
            style: textTheme.bodyMedium
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
