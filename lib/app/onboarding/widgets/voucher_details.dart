
import 'package:flutter/material.dart';
import 'package:geniuspay/app/onboarding/widgets/head_content_text.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';

import '../../../util/widgets_util.dart';
import '../../shared_widgets/continue_button.dart';

class VoucherDetails extends StatelessWidget {

  static const double space = 25;

  const VoucherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsUtil.appBar(
        context,
        title: 'Verify Voucher',
      ),
      body: Padding(
        padding:commonPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
           children: [
             //const SizedBox(height: 10,),
             HeadContentText(context, head: "Voucher Code", content: "NA23OA230D0DS9FF2"),
             const SizedBox(height: space,),
             HeadContentText(context, head: "Currency", content: "USD"),
             const SizedBox(height: space,),

             HeadContentText(context, head: "Voucher Amount", content: "\$20.50"),
             const SizedBox(height: space,),

             HeadContentText(context, head: "Expiry Date", content: "2022-01-27"),
             const SizedBox(height:space,),

             HeadContentText(context, head: "Status", content: "Active", contentTextColor: AppColor.kSuccessColor2, ),

             const Spacer(),

             ContinueButton(
               context: context,
               isLoading: false,
               text: 'Sign up with Voucher',
               onPressed: (){
                 // call the endpoint and chcek voucher
               },
             ),
             const Spacer()




           ],
        ),
      ),
    );
  }

}

