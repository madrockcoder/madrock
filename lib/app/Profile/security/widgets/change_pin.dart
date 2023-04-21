import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ChangePinPage(),
      ),
    );
  }

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final _currentPinController = TextEditingController();
  final _currentPinFocus = FocusNode();
  final _newPinController = TextEditingController();
  final _newPinFocus = FocusNode();
  final _confirmPinController = TextEditingController();
  final _confirmPinFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool validatePIN(String _pin) {
    final found =
        commonlyUsedPins.firstWhere((e) => _pin == e, orElse: () => 'null');
    return found == 'null';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Change PIN'),
            actions: const [HelpIconButton()],
          ),
          body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                const Text(
                    'Create a 6-digit PIN used to validate your transactions'),
                const Gap(16),
                TextFormField(
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  onChanged: (val) {
                    setState(() {});
                  },
                  onSaved: (val) {
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if ((val == null || val.isEmpty)) {
                      return 'This field can not be empty';
                    } else if (val.length < 6) {
                      return 'PIN length must be 6';
                    }
                    return null;
                  },
                  controller: _currentPinController,
                  focusNode: _currentPinFocus,
                  obscureText: true,
                  decoration: TextFieldDecoration(
                    focusNode: _currentPinFocus,
                    context: context,
                    hintText: 'Enter current PIN',
                    onClearTap: () {
                      setState(() {
                        _currentPinController.clear();
                      });
                      // _currentPinFocus.requestFocus();
                    },
                    controller: _currentPinController,
                  ).inputDecoration(),
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
                const Gap(16),
                TextFormField(
                  onChanged: (val) {
                    setState(() {});
                  },
                  onSaved: (val) {
                    setState(() {});
                  },
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if ((val == null || val.isEmpty)) {
                      return 'This field can not be empty';
                    } else if ((val.length != 6)) {
                      return 'PIN length must be 6';
                    } else if (!validatePIN(val)) {
                      return 'PIN can easily be guessed';
                    }
                    return null;
                  },
                  controller: _newPinController,
                  focusNode: _newPinFocus,
                  maxLength: 6,
                  decoration: TextFieldDecoration(
                    focusNode: _newPinFocus,
                    context: context,
                    hintText: 'Enter new PIN',
                    onClearTap: () {
                      setState(() {
                        _newPinController.clear();
                      });
                      _newPinFocus.requestFocus();
                    },
                    controller: _newPinController,
                  ).inputDecoration(),
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                const Gap(16),
                TextFormField(
                  onChanged: (val) {
                    setState(() {});
                  },
                  obscureText: true,
                  onSaved: (val) {
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field can not be empty';
                    } else if (val.length < 6 || val.length > 6) {
                      return 'Pin length must be 6';
                    } else if (val != _newPinController.text) {
                      return 'Confirm PIN and new PIN must be the same';
                    }
                    return null;
                  },
                  controller: _confirmPinController,
                  focusNode: _confirmPinFocus,
                  maxLength: 6,
                  decoration: TextFieldDecoration(
                    focusNode: _confirmPinFocus,
                    context: context,
                    hintText: 'Confirm new PIN',
                    onClearTap: () {
                      setState(() {
                        _confirmPinController.clear();
                      });
                      _confirmPinFocus.requestFocus();
                    },
                    controller: _confirmPinController,
                  ).inputDecoration(),
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                const Spacer(),
                CustomElevatedButtonAsync(
                  color: AppColor.kGoldColor2,
                  child: const Text('CHANGE PIN'),
                  onPressed: (_confirmPinController.text.isNotEmpty &&
                          _currentPinController.text.isNotEmpty &&
                          _newPinController.text.isNotEmpty)
                      ? () async {
                          if (_formKey.currentState?.validate() == true) {
                            final AuthenticationService _authenticationService =
                                sl<AuthenticationService>();
                            final result =
                                await _authenticationService.updatePassCode(
                                    _authenticationService.user!.id,
                                    _currentPinController.text,
                                    _newPinController.text);
                            result.fold(
                                (l) => PopupDialogs(context).errorMessage(
                                    'Unable to change PIN at this time'),
                                (r) => HomeWidget.show(context,
                                    resetUser: true,
                                    showSuccessDialog:
                                        'Successfully changed PIN'));
                          }
                        }
                      : null,
                )
              ])),
        ));
  }
}
