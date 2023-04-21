import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/jar/widgets/assets.gen.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DetailGoals extends StatefulWidget {
  const DetailGoals({Key? key}) : super(key: key);

  @override
  State<DetailGoals> createState() => _DetailGoalsState();
}

class _DetailGoalsState extends State<DetailGoals> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColor.kAccentColor2,
        appBar: AppBar(
          backgroundColor: AppColor.kAccentColor2,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/share_with_contact/arrowback.svg',
              fit: BoxFit.scaleDown,
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Jar',
            style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
          ),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            children: [
              Center(
                child: Text(
                  'You have 50 days left',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColor.kOnPrimaryTextColor3, fontWeight: FontWeight.normal, fontSize: 16),
                ),
              ),
              Stack(children: [
                SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 140,
                    endAngle: 40,
                    showLabels: false,
                    showTicks: false,
                    radiusFactor: 0.7,
                    axisLineStyle: const AxisLineStyle(cornerStyle: CornerStyle.bothCurve, color: Color(0xff9DD6E4), thickness: 28),
                    pointers: <GaugePointer>[
                      const RangePointer(
                        value: 50,
                        cornerStyle: CornerStyle.bothCurve,
                        width: 28,
                        sizeUnit: GaugeSizeUnit.logicalPixel,
                        color: AppColor.kSecondaryColor,
                      ),
                      MarkerPointer(
                        value: 100,
                        enableDragging: false,
                        onValueChanged: (value) {},
                        color: Colors.transparent,
                      )
                    ],
                  )
                ]),
                Positioned(
                  left: 140,
                  top: 90,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        // color: Colors.amber,
                        height: 80,
                        width: 60,
                        child: Stack(children: [
                          Positioned.fill(
                            child: Assets.backgrounds.arcStyle
                                .image(height: 80, width: 80, color: AppColor.kSecondaryColor, fit: BoxFit.contain),
                          ),
                          Center(
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color: AppColor.kAccentColor2,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff0A6375).withOpacity(0.2),
                                        offset: const Offset(0, 4),
                                        blurRadius: 14,
                                        spreadRadius: 0)
                                  ],
                                  shape: BoxShape.circle),
                              child: SvgPicture.asset('assets/icons/camera.svg', height: 25, width: 25, fit: BoxFit.scaleDown),
                            ),
                          ),
                        ]),
                      ),
                      Text(
                        'Travel',
                        style: textTheme.bodyLarge?.copyWith(color: AppColor.kSecondaryColor),
                      ),
                      Text(
                        '\$3,300',
                        style: textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            'saved of \$7,000',
                            style: textTheme.titleMedium?.copyWith(color: Colors.grey, fontWeight: FontWeight.normal),
                          ))
                    ],
                  ),
                ),
              ]),
              Flexible(
                child: DraggableScrollableSheet(
                  initialChildSize: 1,
                  maxChildSize: 1,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.22),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: SingleChildScrollView(
                            controller: scrollController,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: width,
                                  color: AppColor.kAccentColor2,
                                  child: ListTile(
                                    leading: Image.asset(
                                      'assets/jar/hint.png',
                                      scale: 1.5,
                                    ),
                                    minLeadingWidth: 15,
                                    title: Text(
                                      'You need to save \$40 per day in order to achieve this goal',
                                      style: textTheme.titleMedium?.copyWith(color: AppColor.kSecondaryColor),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Transactions',
                                    style: textTheme.bodyLarge?.copyWith(),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  leading: Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: const Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 12,
                                    ),
                                  ),
                                  minLeadingWidth: 15,
                                  title: Text(
                                    '24 June 2021',
                                    style: textTheme.titleSmall?.copyWith(fontSize: 16),
                                  ),
                                  trailing: Text(
                                    '\$ 50.00',
                                    style: textTheme.titleSmall?.copyWith(fontSize: 14),
                                  ),
                                ),
                              ]),
                            )));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
