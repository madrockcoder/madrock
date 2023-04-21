import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';

class NotInYourCountryPage extends StatefulWidget {
  final Country country;
  const NotInYourCountryPage({Key? key, required this.country})
      : super(key: key);
  static Future<void> show(
    BuildContext context,
    Country country,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => NotInYourCountryPage(
                country: country,
              )),
    );
  }

  @override
  State<NotInYourCountryPage> createState() => _NotInYourCountryPageState();
}

class _NotInYourCountryPageState extends State<NotInYourCountryPage> {
  final _emailFocus = FocusNode();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We're not in your Country yet,\nbut we'll be launching soon!",
                    style: textTheme.headlineMedium
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                  const Gap(8),
                  Text(
                      "Please enter your email to be informed when we launch in your Country.",
                      style: textTheme.bodyMedium),
                  const Gap(24),
                  TextFormField(
                    controller: _emailController,
                    decoration: TextFieldDecoration(
                      focusNode: _emailFocus,
                      context: context,
                      hintText: 'Email',
                      onClearTap: () {
                        setState(() {
                          _emailController.clear();
                        });
                        _emailFocus.requestFocus();
                      },
                      controller: _emailController,
                    ).inputDecoration(),
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() {});
                    },
                    validator: (val) {
                      if (val == null) {
                        return "Email can't be empty";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return "Please enter a valid Email address";
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  Text(
                    'You can withdraw your consent to receive such marketing comunications at any time by sending an email to',
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall,
                  ),
                  Center(
                      child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'support@geniuspay.com',
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  )),
                  const Gap(26),
                  CustomElevatedButtonAsync(
                    color: AppColor.kGoldColor2,
                    disabledColor: AppColor.kAccentColor2,
                    child: Text(
                      'CONTINUE',
                      style: textTheme.bodyLarge,
                    ),
                    onPressed: _emailController.text.isEmpty
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await SelectCountryViewModel().addWaitlistUser(
                                  context,
                                  _emailController.text,
                                  widget.country);
                            }
                          },
                  )
                ],
              ))),
    );
  }
}
