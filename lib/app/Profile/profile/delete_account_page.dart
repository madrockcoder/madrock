import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/profile/delete_account_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DeleteAccountPage(),
      ),
    );
  }

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage>
    with EnumConverter {
  ReasonForClosure? reason;

  final _pinFocus = FocusNode();
  final _pinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool showDropDown = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Delete Account'),
            actions: const [HelpIconButton()],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(24),
            child: CustomElevatedButtonAsync(
                color: Colors.white,
                child: Text(
                  'DELETE ACCOUNT',
                  style:
                      textTheme.bodyLarge?.copyWith(color: AppColor.kRedColor),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (await DeleteAccountVM()
                        .verifyPassCode(context, _pinController.text)) {
                      await DeleteAccountVM().closeAccount(
                          context, getReasonForClosureRequestText(reason));
                    } else {
                      PopupDialogs(context).errorMessage('Incorrect Passcode');
                    }
                  }
                }),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                Text(
                  'Deleting your account is an irreversible action. This means that you will loose all the data on this account. '
                  'If you choose to continue, please type “Delete My Account” in the text box below.',
                  style: textTheme.bodyMedium,
                ),
                const Gap(32),
                InkWell(
                    onTap: () {
                      setState(() {
                        showDropDown = !showDropDown;
                      });
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.kSecondaryColor)),
                      child: Row(children: [
                        if (reason == null)
                          const Text('Select reason')
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select reason',
                                style:
                                    textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                              Text(getReasonForClosureText(reason),
                                  style: textTheme.bodyMedium)
                            ],
                          ),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: 1,
                          child:
                              SvgPicture.asset('assets/images/Arrow-Down2.svg'),
                        )
                      ]),
                    )),
                const Gap(16),
                TextFormField(
                  controller: _pinController,
                  decoration: TextFieldDecoration(
                    focusNode: _pinFocus,
                    removeClear: true,
                    context: context,
                    hintText: 'Enter PIN',
                    onClearTap: () {
                      setState(() {
                        _pinController.clear();
                      });
                      _pinFocus.requestFocus();
                    },
                    controller: _pinController,
                  ).inputDecoration(),
                  focusNode: _pinFocus,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {});
                  },
                  style: textTheme.bodyMedium,
                  maxLength: 6,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "PIN can't be empty";
                    } else if (val.length > 6 || val.length < 6) {
                      return 'PIN has 6 characters';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                if (showDropDown) ...[
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 25,
                                color: Colors.grey.withOpacity(.2),
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: ReasonForClosure.values.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.grey[400],
                                );
                              },
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        reason = ReasonForClosure.values[index];
                                        showDropDown = false;
                                      });
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(
                                          getReasonForClosureText(
                                              ReasonForClosure.values[index]),
                                          style: textTheme.bodyMedium,
                                        )));
                              }))),
                  const Gap(100),
                ]
              ])),
        ));
  }
}
