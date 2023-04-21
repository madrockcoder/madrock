import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class LinkedCardsScreen extends StatelessWidget {
  LinkedCardsScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LinkedCardsScreen(),
      ),
    );
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linked Cards'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text(
            'Please, select the card you would like to link to your wallet'),
        const Gap(20),
        CustomTextField(
          controller: _searchController,
          height: 50,
          radius: 9,
          prefixIcon: SizedBox(
              width: 50,
              child: SvgPicture.asset(
                'assets/images/search.svg',
                color: AppColor.kGreyColor,
              )),
          fillColor: AppColor.kAccentColor2,
          keyboardType: TextInputType.emailAddress,
          label: 'Search',
          hint: 'Search',
        ),
        const Gap(20),
        _ListTile(
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          title: 'Link New Card',
        ),
        _ListTile(
          icon: SvgPicture.asset('assets/images/linked_cards.svg'),
          title: '4255**** 1234',
          subtitle: Text(
            'Active',
            style:
                textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ),
        _ListTile(
          icon: SvgPicture.asset('assets/images/linked_cards.svg'),
          title: '4255**** 1234',
          subtitle: Text(
            'Active',
            style:
                textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ),
      ]),
    );
  }
}

class _ListTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? subtitle;
  VoidCallback? onPressed;
  _ListTile({Key? key, required this.icon, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: onPressed,
      leading: CircleAvatar(
          radius: 25, backgroundColor: AppColor.kAccentColor2, child: icon),
      minVerticalPadding: 20,
      subtitle: subtitle,
      title: Text(
        title,
        style: textTheme.bodyMedium,
      ),
    );
  }
}
