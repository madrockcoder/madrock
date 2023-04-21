import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/pages/profile_points/components/circular_icon.dart';
import 'package:geniuspay/app/home/pages/profile_points/models/ways_to_redeem.dart';

class WaysToRedeemGridView extends StatefulWidget {
  final List<List<WaysToRedeem>> waysToRedeemList;
  const WaysToRedeemGridView({Key? key, required this.waysToRedeemList})
      : super(key: key);

  @override
  State<WaysToRedeemGridView> createState() => _WaysToRedeemGridViewState();
}

class _WaysToRedeemGridViewState extends State<WaysToRedeemGridView> {
  late List<List<WaysToRedeem>> waysToRedeemList;
  @override
  void initState() {
    waysToRedeemList = widget.waysToRedeemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
              children: List.generate(
                  waysToRedeemList.length,
                  (columnIndex) => Padding(
                        padding: EdgeInsets.only(
                            bottom: columnIndex == waysToRedeemList.length - 1
                                ? 0
                                : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              waysToRedeemList[columnIndex].length,
                              (rowIndex) => InkWell(
                                  onTap: () {
                                    waysToRedeemList[columnIndex][rowIndex]
                                        .onPressed();
                                  },
                                  child: CircularIcon(
                                      asset: waysToRedeemList[columnIndex]
                                              [rowIndex]
                                          .asset,
                                      assetWidth: waysToRedeemList[columnIndex]
                                              [rowIndex]
                                          .assetWidth,
                                      heading: waysToRedeemList[columnIndex]
                                              [rowIndex]
                                          .text))),
                        ),
                      )))),
    );
  }
}
