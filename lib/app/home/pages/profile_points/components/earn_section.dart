import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/app/home/pages/profile_points/models/earn.dart';
import 'package:geniuspay/util/color_scheme.dart';

class EarnSection extends StatefulWidget {
  final List<Earn> earnList;

  const EarnSection({Key? key, required this.earnList}) : super(key: key);

  @override
  State<EarnSection> createState() => _EarnSectionState();
}

class _EarnSectionState extends State<EarnSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          widget.earnList.length,
          (index) => InkWell(
              onTap: () {
                widget.earnList[index].onPressed();
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: index == widget.earnList.length - 1 ? 0 : 16),
                child: earnOptionWidget(widget.earnList[index].asset,
                    widget.earnList[index].heading),
              ))),
    );
  }

  Widget earnOptionWidget(asset, text) {
    return Container(
      width: double.maxFinite,
      height: 40,
      decoration: BoxDecoration(
          color: AppColor.kAccentColor2,
          border: Border.all(color: AppColor.kSecondaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          const SizedBox(
            width: 39,
          ),
          SvgPicture.asset(asset, width: 16),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
