import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/share_with_contact/arrowback.svg',
              fit: BoxFit.scaleDown,
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          title: Center(
            child: Text(
              'Transfer',
              style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
            ),
          ),
          actions: [
            HelpIconButton(
              onTap: () {},
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 10, right: 25, left: 25),
            child: Column(children: [
              Container(
                height: height / 2.9,
                width: width,
                color: Colors.amber,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: height / 2.9,
                width: width,
                color: Colors.red,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
