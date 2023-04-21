import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

// variable for swicth
bool makePaymentSwicth = false;

//
class ShareWithContact extends StatefulWidget {
  const ShareWithContact({Key? key}) : super(key: key);

  @override
  State<ShareWithContact> createState() => _ShareWithContactState();
}

class _ShareWithContactState extends State<ShareWithContact> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            shareWithContact(context);
          },
          child: const Text("Share with contact"),
          color: Colors.blueAccent,
        ),
      ),
    ));
  }
}

//To open this just call this function and provide context inside onTap/onPressed function
shareWithContact(context) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            height: height / 1.1,
            decoration: const BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/share_with_contact/arrowback.svg',
                      width: 16.0,
                      height: 16.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  margin: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Share with a contact',
                    style: textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'You will be able to share the same account with a chosen person.',
                    style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  height: height / 6,
                  width: width,
                  child: Card(
                    shadowColor: const Color(0xffF1F1F2),
                    elevation: 0,
                    color: const Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.topRight,
                          height: height / 4.5,
                          width: width / 6,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff008AA7),
                              ),
                              child: SvgPicture.asset(
                                'assets/share_with_contact/clarity_help-info-solid.svg',
                                fit: BoxFit.scaleDown,
                                height: 16,
                                width: 16,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            height: height / 4.5,
                            padding: const EdgeInsets.only(left: 10, right: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 25, bottom: 8),
                                  child: Text(
                                    "Keep in mind...",
                                    style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                                  ),
                                ),
                                Text(
                                  'Due to security measures, authorised members will have usage permissions after 12 hours.',
                                  textAlign: TextAlign.start,
                                  style: textTheme.titleSmall!.copyWith(color: AppColor.kOnPrimaryTextColor3),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  height: height / 8,
                  width: width,
                  child: Card(
                      shadowColor: const Color(0xffF1F1F2),
                      elevation: 0,
                      color: const Color(0xffFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 25, right: 20),
                          leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff008AA7),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 26,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Choose a contact to share with',
                            style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                          ),
                          trailing: SvgPicture.asset(
                            'assets/faq/Arrow - Down.svg',
                            width: 14.0,
                            height: 14.0,
                          ),
                        ),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  margin: const EdgeInsets.only(top: 25),
                  child: Text(
                    'What will they be able to do?',
                    style: textTheme.headlineMedium?.copyWith(color: AppColor.kOnPrimaryTextColor),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  height: height / 4,
                  width: width,
                  child: Card(
                      shadowColor: const Color(0xffF1F1F2),
                      elevation: 0,
                      color: const Color(0xffFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 25,
                                right: 20,
                                top: 10,
                              ),
                              leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff008AA7),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/share_with_contact/report.svg',
                                    fit: BoxFit.scaleDown,
                                    height: 16,
                                    width: 16,
                                  )),
                              title: Text(
                                'View account statements',
                                style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                              ),
                              subtitle: Text(
                                'They will be able to view account statements',
                                style: textTheme.titleSmall!.copyWith(color: AppColor.kOnPrimaryTextColor3),
                              ),
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.only(left: 25, right: 5, bottom: 20),
                              leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff008AA7),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/share_with_contact/cash.svg',
                                    fit: BoxFit.scaleDown,
                                    height: 16,
                                    width: 16,
                                  )),
                              title: Text(
                                'Make payments',
                                style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                              ),
                              subtitle: Text(
                                'They will be able to create new and edit existing payments',
                                style: textTheme.titleSmall!.copyWith(color: AppColor.kOnPrimaryTextColor3),
                              ),
                              trailing: CupertinoSwitch(
                                value: makePaymentSwicth,
                                onChanged: (value) {
                                  setState(() {
                                    makePaymentSwicth = value;
                                  });
                                },
                                activeColor: const Color(0xff008AA7),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            )),
      );
    },
  );
}
