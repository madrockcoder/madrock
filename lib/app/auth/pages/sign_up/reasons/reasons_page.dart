import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/reasons/reasons_container.dart';
import 'package:geniuspay/app/auth/pages/sign_up/reasons/reasons_data.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/http_exception.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/models/reason.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReasonsPage extends StatefulWidget {
  const ReasonsPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ReasonsPage()),
    );
  }

  @override
  _ReasonsPageState createState() => _ReasonsPageState();
}

class _ReasonsPageState extends State<ReasonsPage> {
  late final List<Reason> _data;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _data = ReasonsData().data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Main reason for using',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                ),
                Text(
                  'geniuspay',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: AppColor.kSurfaceColorVariant),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'We need to know this for regulatory reasons. And also we\'re curious! You can select more than one reason.',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColor.kPinDesColor,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 40.0),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.3,
              ),
              itemCount: _data.length,
              itemBuilder: (_, i) {
                return SizedBox(
                  child: ReasonsContainer(
                    context: context,
                    iconImage: _data[i].iconImage,
                    text: _data[i].title,
                    isSelected:
                        context.watch<AuthProvider>().isSelected(_data[i]),
                    onPressed: () {
                      context.read<AuthProvider>().addReason(_data[i]);
                      setState(() {});
                    },
                  ),
                );
              },
            ),
            // const SizedBox(height: 44.0),
            ContinueButton(
              context: context,
              isLoading: _isLoading,
              onPressed: () => _send(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _send() async {
    try {
      setState(() => _isLoading = true);
      await context.read<AuthProvider>().reasonForUsingApp();
      setState(() => _isLoading = false);
      // PINCodePage.show(context);
      // FingerPrintPage.show(context);
      // UsPersonPage.show(context);
      // TabsRouter.show(context);
    } on CustomHttpException {
      setState(() => _isLoading = false);
      PopupDialogs(context).errorMessage(
          'An error occurred while trying to store your reasons. Please try again later.');
      // await _showFailureDialog(e);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      PopupDialogs(context).errorMessage(
          'An error occurred while trying to store your reasons. Please try again later.');

      // await _showFailureDialog(CustomHttpException(
      //     title: 'An Error Occurred', message: e.toString()));
    }
  }
}
