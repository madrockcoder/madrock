import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/geniogreen/screens/offset_success.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class OffsetChoosePlan extends StatefulWidget {
  const OffsetChoosePlan({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const OffsetChoosePlan()),
    );
  }

  @override
  State<OffsetChoosePlan> createState() => _OffsetChoosePlanState();
}

class _OffsetChoosePlanState extends State<OffsetChoosePlan> {
  int? _radioValue;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Choose a plan'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const Gap(32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.greenbg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.forest,
                color: AppColor.kWhiteColor,
                size: 35,
              ),
            ),
            const Gap(24),
            Text(
              'Choose how much of your carbon emissions you would like to offset every month',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(color: AppColor.greenbg),
            ),
            const Gap(32),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.greenbg,
                child: Image.asset('assets/images/geniogreen_offset_1.png'),
              ),
              title: const Text('Offset half my emissions'),
              subtitle: Text(
                'Will reduce your carbon score to 5.83',
                style: textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 12),
              ),
              trailing: Radio<int>(
                value: 1,
                groupValue: _radioValue,
                activeColor: AppColor.greenbg,
                overlayColor: MaterialStateProperty.all(AppColor.greenbg),
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
            const Gap(16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.greenbg,
                child: Image.asset('assets/images/geniogreen_offset_2.png'),
              ),
              title: const Text('Offset all my emissions'),
              subtitle: Text(
                'Will reduce your carbon score to 0',
                style: textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 12),
              ),
              trailing: Radio<int>(
                value: 2,
                groupValue: _radioValue,
                activeColor: AppColor.greenbg,
                overlayColor: MaterialStateProperty.all(AppColor.greenbg),
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
            const Gap(16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.greenbg,
                child: Image.asset('assets/images/geniogreen_offset_3.png'),
              ),
              title: const Text('Offset double my emissions'),
              subtitle: Text(
                'Will reduce your carbon score to -1166',
                style: textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 12),
              ),
              trailing: Radio<int>(
                value: 3,
                groupValue: _radioValue,
                activeColor: AppColor.greenbg,
                overlayColor: MaterialStateProperty.all(AppColor.greenbg),
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              child: Text(
                'OFFSET',
                style:
                    textTheme.bodyLarge?.copyWith(color: AppColor.kWhiteColor),
              ),
              color: AppColor.greenbg,
              onPressed: () {
                OffsetSuccessScreen.show(context);
              },
            ),
            const Gap(54)
          ])),
    );
  }
}
