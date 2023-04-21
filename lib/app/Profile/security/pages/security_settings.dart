import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/security/widgets/change_pin.dart';
import 'package:geniuspay/app/Profile/security/widgets/switch_tile.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SecuritySettingsPage(),
      ),
    );
  }

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool bioMetricEnabled = true;
  final LocalBase _localBase = sl<LocalBase>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> get doUserHaveBiometricInDevice async =>
      await _localAuthentication.isDeviceSupported();

  @override
  void initState() {
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //      bioMetricEnabled = _localBase.getFaceID();
    //   });
    // });
    bioMetricEnabled = _localBase.getFaceID();
    checkBiometric();
    super.initState();
  }

  checkBiometric() async {
    isSupported = await _localAuthentication.isDeviceSupported();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  bool isSupported = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Security Settings'),
        actions: const [HelpIconButton()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomElevatedButtonAsync(
          color: AppColor.kGoldColor2,
          child: const Text('SAVE'),
          onPressed: _localBase.getFaceID() == bioMetricEnabled
              ? null
              : () async {
                  _localBase.setFaceID(bioMetricEnabled);
                  await SharedPreferences.getInstance();
                  PopupDialogs(context).successMessage(
                      'Successfully ${bioMetricEnabled ? 'enabled' : 'disabled'} ${Platform.isIOS ? 'Face ID' : 'Fingerprint'}');
                  setState(() {});
                },
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            ListTile(
                onTap: () {
                  ChangePinPage.show(context);
                },
                title: const Text('Change PIN'),
                trailing: const Icon(
                  Icons.arrow_right_rounded,
                  size: 38,
                  color: AppColor.kSecondaryColor,
                )),
            if (Platform.isIOS)
              SwitchTile(
                  onChanged: (val) {
                    if (isSupported) {
                      setState(() {
                        bioMetricEnabled = val;
                      });
                    } else {
                      PopupDialogs(context).informationMessage(
                          "This device doesn't support biometrics");
                    }
                  },
                  title: 'Face ID',
                  subtitle:
                      'Face ID is a face recognition feature that allows secure log in.',
                  value: bioMetricEnabled)
            else
              FutureBuilder(
                future: doUserHaveBiometricInDevice,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData && (snapshot.data ?? false)) {
                    return SwitchTile(
                        onChanged: (val) {
                          setState(() {
                            bioMetricEnabled = val;
                          });
                        },
                        title: 'Fingerprint',
                        subtitle:
                            'Securely access geniuspay with biometric authentication',
                        value: bioMetricEnabled);
                  } else {
                    return const SizedBox();
                  }
                },
              )
          ]),
    );
  }
}
