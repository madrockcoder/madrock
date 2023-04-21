import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/group_payment/pages/create_new_group.dart';
import 'package:geniuspay/app/group_payment/pages/group_screen_content.dart';
import 'package:geniuspay/app/shared_widgets/add_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

int _currentIndex = 0;

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        centerTitle: true,
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
        title: Text('Groups', style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor)),
        actions: const [AddIconButton()],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    _currentIndex = index;
                    setState(() {});
                  },
                  enableInfiniteScroll: false,
                  height: height / 1.5,
                  viewportFraction: 1,
                  enlargeCenterPage: true),
              items: const [GroupScreenContent1(), GroupScreenContent2(), GroupScreenContent3(), GroupScreenContext4()],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: height / 7,
        padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width / 2.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _currentIndex == 0 ? AppColor.kSecondaryColor : AppColor.kAccentColor2),
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _currentIndex == 1 ? AppColor.kSecondaryColor : AppColor.kAccentColor2),
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _currentIndex == 2 ? AppColor.kSecondaryColor : AppColor.kAccentColor2),
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _currentIndex == 3 ? AppColor.kSecondaryColor : AppColor.kAccentColor2),
                  )
                ],
              ),
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => const CreateNewGroup())));
              },
              radius: 8,
              color: AppColor.kGoldColor2,
              // : AppColor.kGoldColor2,
              child: Text('CREATE A GROUP', style: textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
