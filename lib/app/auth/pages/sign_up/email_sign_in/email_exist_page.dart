import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/login_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_radiobutton.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class EmailAlreadyExistPage extends StatefulWidget {
  const EmailAlreadyExistPage({Key? key, required this.email})
      : super(key: key);

  final String email;

  static Future<void> show(BuildContext context, String email) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => EmailAlreadyExistPage(
                email: email,
              )),
    );
  }

  @override
  State<EmailAlreadyExistPage> createState() => _EmailAlreadyExistPageState();
}

class _EmailAlreadyExistPageState extends State<EmailAlreadyExistPage> {
  int? groupValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetsUtil.onBoardingAppBar(context, title: ''),
      // appBar: WidgetsUtil.onBoardingAppBar(context, title: 'Email address'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This email is already registered with existing acount. What would you like to do? ',
              style: textTheme.bodyMedium
                  ?.copyWith(fontSize: 14, color: Colors.black),
            ),
            const Gap(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRadioButton(
                  tileValue: 1,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                ),
                const Gap(10),
                Flexible(
                  child: Text('I have an account and would like to log in',
                      style: textTheme.bodyMedium),
                )
              ],
            ),
            const Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRadioButton(
                  tileValue: 2,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                ),
                const Gap(10),
                Flexible(
                  child: Text(
                      'I’d like to open an account with a different email ID',
                      style: textTheme.bodyMedium),
                )
              ],
            ),
            const Spacer(),
            CustomElevatedButtonAsync(
              color: AppColor.kGoldColor2,
              child: Text(
                "CONTINUE",
                style: textTheme.bodyLarge,
              ),
              onPressed: groupValue != null
                  ? () async {
                      if (groupValue == 1) {
                        await LoginEmailViewModel()
                            .login(context: context, email: widget.email);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  : null,
            ),
            const Gap(24),
          ],
        ),
      )),
    );
  }
}
