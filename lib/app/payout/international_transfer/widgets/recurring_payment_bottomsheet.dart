import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/recurring.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_toggle.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:intl/intl.dart';

class RecurringPaymentBottomSheet extends StatefulWidget {
  final Recurring recurring;
  final String amountWithCurrency;
  const RecurringPaymentBottomSheet(
      {Key? key, required this.recurring, required this.amountWithCurrency})
      : super(key: key);

  @override
  State<RecurringPaymentBottomSheet> createState() =>
      _RecurringPaymentBottomSheetState();
}

class _RecurringPaymentBottomSheetState
    extends State<RecurringPaymentBottomSheet> {
  int? selectedListTile;
  late List<FixedExtentScrollController> fixedExtentScrollControllers;
  List<List<String>> listItems = [
    ["Doesn't repeat", "Daily", "Weekly", "Monthly"],
    ["Doesn't repeat", "Daily", "Weekly", "Monthly"],
    ["Doesn't end", "Fri, 29 Jul", "Fri, 29 Jul"],
  ];

  @override
  void initState() {
    fixedExtentScrollControllers = [
      FixedExtentScrollController(initialItem: 1),
      FixedExtentScrollController(initialItem: 1),
      FixedExtentScrollController(initialItem: 1),
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        recurring = widget.recurring;
      });
    });

    super.initState();
  }

  Future _selectDate(bool isFirstPayment) async {
    DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.kSecondaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateFormat('yyy-MM-dd').parse(
          isFirstPayment ? recurring.firstPayment : recurring.lastPayment),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      if (isFirstPayment) {
        setState(() {
          recurring.firstPayment = DateFormat('yyy-MM-dd').format(picked);
        });
      } else {
        setState(() {
          recurring.lastPayment = DateFormat('yyy-MM-dd').format(picked);
        });
      }
    }
  }

  Recurring recurring = Recurring(
      isRecurring: false, firstPayment: '', frequency: '', lastPayment: '');
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
      child: CustomSectionHeading(
          heading: "Recurring payment",
          headingTextStyle: const TextStyle(
              color: AppColor.kSecondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          child: Column(
            children: [
              Row(
                children: [
                  CustomCircularIcon(SvgPicture.asset(
                      'assets/icons/calendar_add.svg',
                      width: 24,
                      height: 24)),
                  const Gap(12),
                  const Text("Schedule payment"),
                  const Spacer(),
                  CustomToggle(
                    value: recurring.isRecurring,
                    onToggle: (val) {
                      setState(() {
                        recurring.isRecurring = val;
                      });
                    },
                  )
                ],
              ),
              const Gap(16),
              divider(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "First payment",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColor.kOnPrimaryTextColor2),
                      ),
                      InkWell(
                          onTap: () {
                            _selectDate(true);
                          },
                          child: Text(
                            recurring.firstPayment,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColor.kSecondaryColor),
                          )),
                    ],
                  )),
              divider(),
              customExpandableWidget(
                  title: "Frequency", selected: recurring.frequency, index: 1),
              divider(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Last payment",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColor.kOnPrimaryTextColor2),
                      ),
                      InkWell(
                          onTap: () {
                            _selectDate(false);
                          },
                          child: Text(
                            recurring.lastPayment,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColor.kSecondaryColor),
                          )),
                    ],
                  )),
              const Gap(40 - 16),
              if (recurring.firstPayment ==
                  DateFormat('yyy-MM-dd').format(DateTime.now()))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/calendar-check.svg',
                        width: 18, height: 18),
                    const Gap(12),
                    const Text(
                      "This payment will be made today",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: AppColor.kOnPrimaryTextColor3),
                    )
                  ],
                ),
              const Gap(13),
              CustomElevatedButton(
                color: AppColor.kGoldColor2,
                child: Text(
                  'CONFIRM',
                  style: textTheme.bodyLarge,
                ),
                onPressed: recurring.isRecurring
                    ? () {
                        Essentials.showBottomSheet(
                            RecurringSuccessfulBottomSheet(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context, recurring);
                                },
                                date: recurring.firstPayment,
                                amountWithCurrency: widget.amountWithCurrency),
                            context,
                            showFullScreen: true);
                      }
                    : null,
              )
            ],
          ),
          headingAndChildGap: 24),
    );
  }

  Widget customExpandableWidget(
      {required String title, required String selected, required int index}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if (index == selectedListTile) {
            selectedListTile = null;
          } else {
            selectedListTile = index;
          }
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColor.kOnPrimaryTextColor2),
                  ),
                  Text(
                    selected,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColor.kSecondaryColor),
                  ),
                ],
              ),
              selectedListTile == index
                  ? Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 16),
                      child: SizedBox(
                        height: 116,
                        width: 160,
                        child: CupertinoPicker.builder(
                          itemExtent: 32,
                          scrollController: fixedExtentScrollControllers[index],
                          onSelectedItemChanged: (v) {
                            setState(() {
                              recurring.frequency = listItems[index][v];
                            });
                          },
                          childCount: listItems[index].length,
                          useMagnifier: false,
                          diameterRatio: 1,
                          magnification: 1,
                          selectionOverlay: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        AppColor.kAccentColor2.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: AppColor.kSecondaryColor, width: 2),
                                bottom: BorderSide(
                                    color: AppColor.kSecondaryColor, width: 2),
                              ),
                            ),
                          ),
                          itemBuilder: (context, i) {
                            return Center(
                              child: Text(
                                listItems[index][i],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Divider(
      height: 1,
      thickness: 0.1,
      color: AppColor.kSecondaryColor.withOpacity(0.5),
    );
  }
}

class RecurringSuccessfulBottomSheet extends StatefulWidget {
  final Function() onPressed;
  final String amountWithCurrency;
  final String date;
  const RecurringSuccessfulBottomSheet(
      {Key? key,
      required this.onPressed,
      required this.amountWithCurrency,
      required this.date})
      : super(key: key);

  @override
  State<RecurringSuccessfulBottomSheet> createState() =>
      _RecurringSuccessfulBottomSheetState();
}

class _RecurringSuccessfulBottomSheetState
    extends State<RecurringSuccessfulBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 37),
                child: InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
              const Gap(85.26),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Recurring payment set up",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColor.kSecondaryColor),
                    ),
                    const Gap(40),
                    CircleBorderIcon(
                      gradientStart: const Color(0xff008AA7).withOpacity(.2),
                      gradientEnd: Colors.white,
                      gapColor: Colors.white,
                      bgColor: Colors.white,
                      spaceBetweenRingAndWidget: 12,
                      size: 200,
                      child: Container(
                        width: 145,
                        height: 145,
                        child: Center(
                            child: SvgPicture.asset(
                                'assets/icons/calendar-check.svg',
                                width: 75,
                                height: 68.75,
                                color: AppColor.kSecondaryColor)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: Colors.grey.shade400.withOpacity(0.5),
                                spreadRadius: 0.3,
                              ),
                            ],
                            color: AppColor.kAccentColor2),
                      ),
                    ),
                    const Gap(44),
                    Text(
                      "We’ll make the next daily payment of ${widget.amountWithCurrency}\non the ${widget.date}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: CustomYellowElevatedButton(
                text: "BACK TO MY ACCOUNT",
                onTap: () {
                  widget.onPressed();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
