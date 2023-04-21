// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            assignACategory(context);
          },
          child: const Text("Create category"),
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

//To open this just call this function and provide context inside onTap/onPressed function
Future<String?> assignACategory(BuildContext context) {
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
              top: 30,
            ),
            height: height / 1.2,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColor.kSecondaryColor,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  margin: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Assign a category',
                    style: textTheme.displaySmall
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'We\'ll show you insights based on this',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    height: height / 1.8,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/bills.png'),
                                ),
                                Text(
                                  'Bills',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/eating-out.png'),
                                ),
                                Text(
                                  'Eating out',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/movie.png'),
                                ),
                                Text(
                                  'Movies',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/family.png'),
                                ),
                                Text(
                                  'Family',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/drinks.png'),
                                ),
                                Text(
                                  'Drinks',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/gifts.png'),
                                ),
                                Text(
                                  'Gifts',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/groceries.png'),
                                ),
                                Text(
                                  'Groceries',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/rent.png'),
                                ),
                                Text(
                                  'Rent',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/personal-care.png'),
                                ),
                                Text(
                                  'Personal care',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    margin: EdgeInsets.only(bottom: 5, top: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppColor.kAccentColor2),
                                    child: Center(
                                        child: Text(
                                      '🏘️',
                                      style: TextStyle(fontSize: 25),
                                    ))),
                                Text(
                                  'Home',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/transportation.png'),
                                ),
                                Text(
                                  'Transportation',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/healthcare.png'),
                                ),
                                Text(
                                  'Healthcare',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/education.png'),
                                ),
                                Text(
                                  'Education',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    margin: EdgeInsets.only(bottom: 5, top: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppColor.kAccentColor2),
                                    child: Center(
                                        child: Text(
                                      '🛍️',
                                      style: TextStyle(fontSize: 25),
                                    ))),
                                Text(
                                  'Shopping',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/general.png'),
                                ),
                                Text(
                                  'General',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(bottom: 5, top: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColor.kAccentColor2),
                                  child: Image.asset(
                                      'assets/create_categories/travel.png'),
                                ),
                                Text(
                                  'Travel',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kOnPrimaryTextColor),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            )),
      );
    },
  );
}
