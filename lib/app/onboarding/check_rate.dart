
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../util/color_scheme.dart';
import '../../util/constants.dart';
import '../../util/widgets_util.dart';
import '../shared_widgets/grouper_container.dart';
import 'widgets/transaction_container.dart';

class CheckRate extends StatefulWidget {
  const CheckRate({Key? key}) : super(key: key);

  @override
  State<CheckRate> createState() => _CheckRateState();
}

class _CheckRateState extends State<CheckRate> {



  late TextEditingController field1,field2 ;
  final numFormat = NumberFormat('###.00');

  @override
  void initState() {
    super.initState();
    field1 = TextEditingController();
    field2 = TextEditingController();



  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: WidgetsUtil.appBar(
        context,
        title: 'Check Rates',
      ),
      body: Padding(
        padding: commonPadding,
        child: Column(
          children: [

            GrouperContainer(
                color: AppColor.kDarkGreenColor,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Column(
                  children:  [
                    const Text("You send"),

                   // DropDownTextField(
                   //  controller: field1,
                   // )

                     TextFormField(
                  controller: field1,
                  keyboardType: TextInputType.number,
                  onChanged: (val){

                  },
                  decoration:InputDecoration(
                      hintText: "Amount",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.kSubtitleTextColor
                      )
                    )

                  ),

                )

                  ],
                ), context: context),


           const Text('Exchange rate: \$1 = £20 '),

            TransactionContainer(context,image: 'assets/images/banktransfer.svg', category: "Bank Transfer", amount: "\$10.0"),
            TransactionContainer(context,image: 'assets/images/moneyvoucher.svg', category: "Money Voucher", amount: "\$1.70"),
            TransactionContainer(context,image: 'assets/images/mobilemoney.svg', category: "Mobile Money", amount: "\$0.50"),


          ],
        ),
      ),
    );
  }
}
