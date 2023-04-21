import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:geniuspay/app/jar/widgets/set_goal_duration.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import '../../../util/color_scheme.dart';
import '../../shared_widgets/size_config.dart';
import '../widgets/custom_border.dart';
import '../widgets/jar_app_bar.dart';

class SetGoalScreen extends StatefulWidget {
  const SetGoalScreen({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;
  static Future<void> show(
      BuildContext context, Map<String, dynamic> data) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => SetGoalScreen(
                data: data,
              )),
    );
  }

  @override
  State<SetGoalScreen> createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  final TextEditingController? amountController = TextEditingController();
  final TextEditingController? deadlineController = TextEditingController();

  bool amount = false;
  bool deadline = false;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        deadlineController!.text =
            DateFormat('dd.MM.yyyy').format(selectedDate);
        if (deadlineController!.text.isNotEmpty) {
          deadline = true;
        } else {
          deadline = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: const JarAppBar(
          text: 'Set a goal', backgroundColor: AppColor.kWhiteColor),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How much do you want to save?',
                style: textTheme.bodyMedium?.copyWith(fontSize: 16)),
            const Gap(12),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.phone,
              onChanged: (val) {
                setState(() {
                  if (val.isNotEmpty) {
                    amount = true;
                  } else {
                    amount = false;
                  }
                });
              },
              onTap: () {
                setState(() {
                  if (amountController!.text.isEmpty) {
                    amountController!.text = "\$";
                  }
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, top: 5),
                alignLabelWithHint: false,
                labelText: 'Enter amount',
                filled: true,
                labelStyle: textTheme.titleSmall,
                fillColor: amount ? AppColor.kAccentColor2 : Colors.transparent,
                disabledBorder: CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColor.kSecondaryColor)),
                focusedBorder: CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColor.kSecondaryColor)),
                border: const CustomOutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: AppColor.kSecondaryColor,
                    width: 1,
                  ),
                ),
                enabledBorder: const CustomOutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: AppColor.kSecondaryColor,
                    width: 1,
                  ),
                ),
              ),
            ),
            const Gap(8),
            CustomTextField(
              controller: deadlineController,
              contentPadding: const EdgeInsets.only(right: 10, left: 10),
              removePadding: true,
              hint: 'Set deadline',
              fillColor: deadline ? AppColor.kAccentColor2 : Colors.transparent,
              hasBorder: true,
              // onTap: () {
              //   _selectDate(context);
              // },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              enabled: true,
              onChanged: (val) {
                setState(() {
                  if (val.isNotEmpty) {
                    deadline = true;
                  } else {
                    deadline = false;
                  }
                });
              },
              prefixIconConstraints: const BoxConstraints(
                  maxWidth: 50, maxHeight: 16, minHeight: 16, minWidth: 20),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SvgPicture.asset('assets/icons/calender.svg', height: 16, width: 16, fit: BoxFit.cover),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColor.kSecondaryColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColor.kSecondaryColor)),
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {
                if (amount == true && deadline == true) {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      context: context,
                      builder: (context) {
                        return SetGoalDurationSheet(
                          image: widget.data?['image'],
                          name: widget.data?['name'],
                          amount: amountController?.text,
                          endDate: deadlineController?.text,
                        );
                      });
                }
              },
              radius: 8,
              child: Text('CONTINUE',
                  style: amount == false || deadline == false
                      ? textTheme.bodyMedium
                      : textTheme.bodyLarge),
              color: amount == false || deadline == false
                  ? AppColor.kAccentColor2
                  : AppColor.kGoldColor2,
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
