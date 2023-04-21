import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

TextEditingController phoneNumberToAddInGroup = TextEditingController();

class AddGroupMember extends StatefulWidget {
  const AddGroupMember({Key? key}) : super(key: key);

  @override
  State<AddGroupMember> createState() => _AddGroupMemberState();
}

class _AddGroupMemberState extends State<AddGroupMember> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              height: 42,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: const Color(0xff008AA7), width: 1.5),
              ),
              padding: const EdgeInsets.only(left: 18, right: 0),
              child: TextField(
                controller: phoneNumberToAddInGroup,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: SvgPicture.asset(
                    'assets/faq/search.svg',
                    width: 14.0,
                    height: 14.0,
                  ),
                  suffixIcon: IconButton(
                      splashRadius: 10,
                      icon: const Icon(
                        Icons.cancel,
                        size: 18,
                        color: Color(0xff008AA7),
                      ),
                      onPressed: () {
                        phoneNumberToAddInGroup.clear();
                        setState(() {});
                      }),
                  hintText: 'Type in their phone number',
                  hintStyle: textTheme.titleMedium
                      ?.copyWith(color: AppColor.kTextFieldTextColor),
                ),
                // style: style,
                onChanged: (value) {},
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: CustomElevatedButton(
                onPressed: () {},
                radius: 8,
                color: AppColor.kSecondaryColor,
                child: Text('Add phone contacts',
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              width: width / 1.3,
              child: Text(
                'Load your address book contacts to search through a list of your friends. You can do this in your phone settigns',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
