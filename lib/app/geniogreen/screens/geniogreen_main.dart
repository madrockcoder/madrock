import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/geniogreen/screens/about_screen.dart';
import 'package:geniuspay/app/geniogreen/screens/calculate_screen.dart';
import 'package:geniuspay/app/geniogreen/screens/offset_screen.dart';
import 'package:geniuspay/app/geniogreen/screens/projects_screen.dart';
import 'package:geniuspay/app/geniogreen/widgets/trackwidget.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/app/shared_widgets/draggable_home_sheet.dart';
import 'package:geniuspay/app/shared_widgets/menu_item.dart' as menu_item;
import 'package:geniuspay/util/color_scheme.dart';

class GenioGreenPage extends StatelessWidget {
  const GenioGreenPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GenioGreenPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.kSuccessColor3,
      appBar: AppBar(
        backgroundColor: AppColor.kSuccessColor3,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Track & Offset',
          style: textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(children: [
        Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CurvedBackground(
                bgColor: AppColor.greenbg,
                gradientColors: const [AppColor.greenBorder, AppColor.greenbg],
                child: Column(children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      TrackWidget(
                          bgColor: AppColor.darkGreen,
                          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Row(
                              children: [
                                Text(
                                  'CO2',
                                  style: textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  ' Emission',
                                  style: textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  '0 kg ',
                                  style: textTheme.displaySmall
                                      ?.copyWith(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
                                ),
                                const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/projects.svg',
                                  width: 16,
                                ),
                                const Gap(15),
                                Text(
                                  '0',
                                  style: textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ])),
                      const SizedBox(
                        width: 16,
                      ),
                      TrackWidget(
                        bgColor: AppColor.kWhiteColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '0',
                                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(' trees planted', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w100))
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.kWhiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.forest,
                                color: AppColor.greenbg,
                                size: 15,
                              ),
                            ),
                            const Spacer(),
                            const ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                minHeight: 5,
                                value: .2,
                                backgroundColor: AppColor.kAccentColor2,
                                color: AppColor.greenbg,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  '200 points',
                                  style: textTheme.titleSmall
                                      ?.copyWith(color: AppColor.greenbg, fontSize: 8, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  ' left to next tree',
                                  style: textTheme.titleSmall?.copyWith(
                                    fontSize: 8,
                                    color: AppColor.greenbg,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Divider(
                    color: AppColor.darkGreen,
                    thickness: .5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu_item.MenuItem(
                        icon: 'assets/icons/cloud.svg',
                        text: 'Calculate',
                        buttonColor: AppColor.darkGreen,
                        onTab: () {
                          CalculateScreen.show(context);
                        },
                      ),
                      menu_item.MenuItem(
                        icon: 'assets/icons/offset.svg',
                        text: 'Offset',
                        buttonColor: AppColor.darkGreen,
                        onTab: () {
                          OffsetScreen.show(context);
                        },
                      ),
                      menu_item.MenuItem(
                        icon: 'assets/icons/projects.svg',
                        text: 'Projects',
                        buttonColor: AppColor.darkGreen,
                        onTab: () {
                          ProjectsScreen.show(context);
                        },
                      ),
                      menu_item.MenuItem(
                        icon: 'assets/icons/about.svg',
                        text: 'About',
                        buttonColor: AppColor.darkGreen,
                        onTab: () {
                          AboutScreen.show(context);
                        },
                      ),
                    ],
                  ),
                ]),
              )),
          const SizedBox(
            height: 16,
          ),
        ]),
        DraggableHomeSheet(
          child: Column(children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 52, vertical: height / 6),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/offset.svg',
                      color: AppColor.greenbg,
                      width: 22,
                    ),
                    const Gap(8),
                    const Expanded(child: Text("You can offset your CO2 and get trees planted in you name."))
                  ],
                ))
          ]),
        )
      ]),
    );
  }
}
