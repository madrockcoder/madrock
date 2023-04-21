import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/select_country_page.dart';
import 'package:geniuspay/app/auth/view_models/login_view_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String assetPath = "assets/login";
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  bool get isKeyboardOpened => MediaQuery.of(context).viewInsets.bottom > 0;
  bool isInvalidEmail = false;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView<LoginEmailViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        backgroundColor: AppColor.kAccentColor2,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: [
              !(isKeyboardOpened)
                  ? Container(
                      margin: const EdgeInsets.only(top: 100),
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "$assetPath/unlock.png",
                        width: 200,
                        height: 200,
                      ),
                    )
                  : const SizedBox(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(48),
                          topRight: Radius.circular(48))),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 73,
                            ),
                            const Text(
                              "Welcome back!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  color: AppColor.kSecondaryColor),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "Let's pick up where you left off",
                            ),
                            const SizedBox(
                              height: 29,
                            ),
                            SizedBox(
                              height: 56,
                              child: TextFormField(
                                  cursorWidth: 1,
                                  focusNode: focusNode,
                                  controller: controller,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    if (value.length < 2) {
                                      setState(() {});
                                    }

                                    if (value.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                      if (!isInvalidEmail) {
                                        setState(() {
                                          isInvalidEmail = true;
                                        });
                                      }
                                    } else {
                                      if (isInvalidEmail) {
                                        setState(() {
                                          isInvalidEmail = false;
                                        });
                                      }
                                    }
                                  },
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: ""),
                                  decoration: InputDecoration(
                                    // hintText: 'Email',
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF2C2C2E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: ""),
                                    filled: true,
                                    suffixIcon: controller.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () {
                                              controller.clear();
                                              isInvalidEmail = false;
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.cancel,
                                              color: AppColor.kSecondaryColor,
                                              size: 18,
                                            ),
                                          )
                                        : const SizedBox(),
                                    fillColor: controller.text.isNotEmpty
                                        ? AppColor.kAccentColor2
                                        : Colors.white,
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: AppColor.kSecondaryColor,
                                          width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: AppColor.kSecondaryColor),
                                    ),
                                  )),
                            ),
                            isInvalidEmail
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.info_outline,
                                          color: AppColor.kRedColor,
                                          size: 11.43,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Enter a valid email address',
                                          style: TextStyle(
                                              color: AppColor.kRedColor,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            !isKeyboardOpened
                                ? InkWell(
                                    onTap: () {
                                      SelectCountryResidence.show(context);
                                    },
                                    child: SizedBox(
                                      height: 204,
                                      child: Row(
                                        children: const [
                                          Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColor.kSecondaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ))
                                : const SizedBox(
                                    height: 134,
                                  ),
                          ],
                        ),
                      ),
                      !isKeyboardOpened
                          ? Positioned(
                              right: 0,
                              bottom: 0,
                              child: Opacity(
                                opacity:
                                    isInvalidEmail || controller.text.isEmpty
                                        ? 0.5
                                        : 1,
                                child: SizedBox(
                                  height: 187,
                                  width: 112,
                                  child: Stack(
                                    children: [
                                      SvgPicture.asset(
                                          "$assetPath/next_wave_rect.svg"),
                                      InkWell(
                                          onTap: isInvalidEmail ||
                                                  controller.text.isEmpty
                                              ? null
                                              : () async {
                                                  setState(() {
                                                    _loading = true;
                                                  });
                                                  try {
                                                    await model.emailExists(
                                                        controller.text);
                                                    if (model.isEmailExist) {
                                                      await model.login(
                                                          context: context,
                                                          email: controller.text
                                                              .trim());
                                                    } else {
                                                      PopupDialogs(context)
                                                          .errorMessage(
                                                              'That geniuspay account does\'t exist. Enter a different account or get a new one.');
                                                    }
                                                  } catch (e) {}
                                                  setState(() {
                                                    _loading = false;
                                                  });
                                                },
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: _loading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .arrow_forward_outlined,
                                                    color: Colors.white,
                                                  ),
                                          ))
                                    ],
                                  ),
                                ),
                              ))
                          : const SizedBox(),
                      Positioned(
                        top: -40,
                        child: SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400
                                              .withOpacity(0.8),
                                          spreadRadius: 0.5,
                                          blurRadius: 4,
                                          offset: const Offset(0, 3))
                                    ]),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        "$assetPath/geniuspay_logo.svg"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
