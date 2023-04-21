import 'package:flutter/material.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/borderless_recipient_vm.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/text_field_decoration.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class BeneficiaryAddNewRecipientScreen extends StatefulWidget {
  const BeneficiaryAddNewRecipientScreen({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => const BeneficiaryAddNewRecipientScreen()),
    );
  }

  @override
  State<BeneficiaryAddNewRecipientScreen> createState() =>
      _BeneficiaryAddNewRecipientScreenState();
}

class _BeneficiaryAddNewRecipientScreenState
    extends State<BeneficiaryAddNewRecipientScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Borderless Recipient"),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: const [
            HelpIconButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                  key: _formKey,
                  child: Expanded(
                    child: Column(
                      children: [
                        Text(
                            'You can add a recipient providing email or phone number or both.',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _emailController,
                          // style: textTheme.bodyText2,
                          decoration: TextFieldDecoration(
                            focusNode: _emailFocusNode,
                            hintText: 'Email',
                            onClearTap: () {
                              setState(() {
                                _emailController.clear();
                              });
                              // _emailFocusNode.requestFocus();
                            },
                            controller: _emailController,
                          ).inputDecoration(),
                          style: textTheme.bodyMedium,
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
                      ],
                    ),
                  )),
              CustomElevatedButtonAsync(
                disabledColor: AppColor.kAccentColor2,
                color: AppColor.kGoldColor2,
                width: null,
                child:
                    Text('ADD', style: Theme.of(context).textTheme.bodyLarge),
                onPressed: (_formKey.currentState?.validate() ?? false)
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          await BorderLessRecipientVM().addEmailRecipient(
                              context, _emailController.text);
                        }
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
