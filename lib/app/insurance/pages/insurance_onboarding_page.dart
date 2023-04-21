import 'package:flutter/material.dart';

import '../../../models/insurance_onboarding.dart';
import '../../../util/color_scheme.dart';
import '../../../util/constants.dart';
import '../../../util/widgets_util.dart';
import '../../shared_widgets/size_config.dart';
import '../widgets/insurance_walkthrough.dart';

class InsuranceOnboardingPage extends StatefulWidget {
  const InsuranceOnboardingPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const InsuranceOnboardingPage()),
    );
  }

  @override
  State<InsuranceOnboardingPage> createState() => _InsuranceOnboardingPageState();
}

class _InsuranceOnboardingPageState extends State<InsuranceOnboardingPage> {
  String title = '';
  int currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  animateToPage(index) {
    if (index == 2) {
      //todo handle implementation in case page would be routed
    } else {
      _pageController?.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: AppColor.kAccentColor2,
        body: SafeArea(
          child: Column(
            children: [
              WidgetsUtil.onBoardingAppBar(context, title: title),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                      if (index > 0) {
                        title = 'Choose your insurance';
                      } else {
                        title = '';
                      }
                    });
                  },
                  children: listOfInsuranceOnboarding.map((data) => InsuranceWalkThrough(data: data)).toList(),
                ),
              ),

              ///indicator and terms & conditions
              Container(
                margin: const EdgeInsets.only(bottom: sixteenDp),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicatorCount(currentIndex: currentIndex, items: listOfInsuranceOnboarding),
                      ),
                      const SizedBox(height: tenDp),
                      RichText(
                        textWidthBasis: TextWidthBasis.parent,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            WidgetsUtil.textSpan(
                                value: "Terms & Conditions apply, click ",
                                textStyle: textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500)),
                            WidgetsUtil.textSpan(
                                value: ' here',
                                textStyle: textTheme.labelMedium!.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: AppColor.kGenioGreenColor,
                                    fontWeight: FontWeight.bold)),
                            WidgetsUtil.textSpan(
                                value: ' for more', textStyle: textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget rowItem({required Widget a, required Widget b}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [a, b],
    );
  }

  //todo Move to shared widget if to be used in other pages
  List<Widget> indicatorCount({required int currentIndex, required List items}) {
    List<Widget> indicators = [];
    for (int i = 0; i < items.length; i++) {
      if (currentIndex == i) {
        indicators.add(indicator(true));
      } else {
        indicators.add(indicator(false));
      }
    }

    return indicators;
  }

  //todo Move and modify to shared widget if to be used in other pages
  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? twelveDp : eightDp,
      width: isActive ? twelveDp : eightDp,
      margin: const EdgeInsets.only(right: sixDp),
      decoration: BoxDecoration(
          color: isActive ? AppColor.kGenioGreenColor : AppColor.kGenioGreenColor.withOpacity(0.3), shape: BoxShape.circle),
    );
  }
}
