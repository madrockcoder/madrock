import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/color_scheme.dart';
import '../../util/constants.dart';
import '../../util/widgets_util.dart';
import '../shared_widgets/continue_button.dart';
import '../shared_widgets/custom_text_field.dart';

class VerifyVoucher extends StatefulWidget {
  const VerifyVoucher({Key? key}) : super(key: key);

  @override
  State<VerifyVoucher> createState() => _VerifyVoucherState();
}

class _VerifyVoucherState extends State<VerifyVoucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetsUtil.appBar(
          context,
          title: 'Verify Voucher',
        ),
        body: Padding(
          padding: commonPadding,
          child: Column(
            children: [
              Text(
                'Kindly enter the voucher number in the input field below to proceed with this transaction.',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.kPinDesColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextField(
                controller: TextEditingController(),
                hint: 'Voucher Number',
                onSaved: (e) => {},
                onChanged: (_) {
                  //setDisableButton();
                },
              ),
              const SizedBox(height: 32.0),
              ContinueButton(
                context: context,
                isLoading: false,
                text: 'Verify  Voucher',
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
