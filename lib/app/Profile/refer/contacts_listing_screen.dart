import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/refer/widgets/custom_appbar.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';

import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ContactsListingScreen extends StatefulWidget {
  const ContactsListingScreen({Key? key}) : super(key: key);

  @override
  State<ContactsListingScreen> createState() => _ContactsListingScreenState();
}

class _ContactsListingScreenState extends State<ContactsListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
              'Your contacts',
              Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    kShare,
                    height: 20,
                    width: 20,
                  ))),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(children: [
            CustomTextField(
              radius: 9,
              validationColor: AppColor.kSecondaryColor,
              controller: _searchController,
              fillColor: Colors.transparent,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColor.kSecondaryColor,
              ),
              hasBorder: false,
              onChanged: (val) {},
              hint: ' Search',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => CheckboxListTile(
                  title: const Text('Tongkun Lee'),
                  subtitle: Text(
                    'abc@gmail.com',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                  secondary: CircleAvatar(
                    backgroundColor: AppColor.kAccentColor3,
                    child: Image.asset(
                      kFriend,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  autofocus: false,
                  checkColor: Colors.white,
                  activeColor: AppColor.kSecondaryColor,
                  selected: _value,
                  value: _value,
                  onChanged: (bool? value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
