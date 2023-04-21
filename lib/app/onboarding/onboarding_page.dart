import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/login/login_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/select_country_page.dart';
import 'package:lottie/lottie.dart';

import '../../models/onboarding_model.dart';
import '../../util/color_scheme.dart';
import '../../util/constants.dart';
import '../../util/widgets_util.dart';
import 'widgets/onboard_item.dart';
import 'widgets/onboard_outlined_button.dart';
import 'widgets/onboard_progress_indicator.dart';
import 'widgets/onboarding_data.dart';
import 'widgets/sign_in_page_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

const padding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0);

class _OnboardingPageState extends State<OnboardingPage> {
  var _currIndex = 0;
  late final List<Onboard> data;
  final _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    data = OnboardingData().data;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color bgColor() {
    if (_currIndex == 0) {
      return AppColor.kSurfaceColorVariant;
    } else if (_currIndex == 1) {
      return AppColor.kOnboard2Color;
    } else {
      return AppColor.kOnboard3Color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetsUtil.onboardingBackground(
        child: Padding(
          padding: commonPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: data.length,
                  itemBuilder: (_, i) => i == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 10,
                              child: EarthWidget(
                                  diameter:
                                      MediaQuery.of(context).size.width - 50),
                            ),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: padding,
                                child: RichText(
                                  text: TextSpan(
                                    text: data[i].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(
                                            color:
                                                AppColor.kOnPrimaryTextColor2,
                                            fontSize: 25.0),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      : OnboardItem(
                          currIndex: _currIndex,
                          data: data[i],
                          padding: padding,
                          lastIndex: data.length - 1,
                        ),
                  onPageChanged: (i) => setState(() => _currIndex = i),
                ),
              ),
              const Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < data.length; i++) ...[
                    OnboardProgressIndicator(isCurrentPage: _currIndex == i),
                    const SizedBox(width: 5.0),
                  ],
                ],
              ),
              const Gap(50),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OnboardOutlinedButton(
                          context: context,
                          text: 'Login',
                          color: Colors.white,
                          textColor: Colors.black,
                          // isLoading: context.read<AuthProvider>().isLoading,
                          onTap: () {
                            LoginPage.show(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: SignInPageButton(
                          context: context,
                          color: AppColor.kGoldColor2,
                          textColor: Colors.black,
                          onPressed: () {
                            SelectCountryResidence.show(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EarthWidget extends StatelessWidget {
  final double diameter;
  final double topSpacing;

  const EarthWidget({Key? key, required this.diameter, this.topSpacing = 70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topSpacing),
      child: Container(
        width: diameter,
        height: diameter,
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(500)),
            child: Lottie.asset(
              "assets/images/onboard1.json",
              repeat: true,
            )),
        decoration: const BoxDecoration(
            color: Colors.red,
            gradient: RadialGradient(
              colors: [Colors.grey, Colors.black],
              center: Alignment(-0.4, -0.4),
            ),
            shape: BoxShape.circle),
      ),
    );
  }
}
