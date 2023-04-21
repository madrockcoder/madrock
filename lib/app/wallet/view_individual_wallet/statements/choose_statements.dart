import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ChooseStatements extends StatelessWidget {
  const ChooseStatements({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ChooseStatements(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statements'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          StatementsTile(
            svgAsset: 'assets/images/docss.svg',
            title: 'Monthly statements',
            subtitle: 'Summary of financial activity from a single account',
            onPressed: () => PopupDialogs(context).comingSoonSnack(),
          ),
          StatementsTile(
            svgAsset: 'assets/images/transaction_statements.svg',
            title: 'Transaction statements',
            subtitle: 'Filtrer and export selected transactions only',
            onPressed: () => PopupDialogs(context).comingSoonSnack(),
          ),
          StatementsTile(
            svgAsset: 'assets/images/stats.svg',
            title: 'Statements of balances',
            subtitle: 'Confirmation of funds held with geniuspay Business',
            onPressed: () => PopupDialogs(context).comingSoonSnack(),
          ),
          StatementsTile(
            svgAsset: 'assets/images/account_confirmation.svg',
            title: 'Account confirmation',
            subtitle: 'Summary of your account details',
            onPressed: () => PopupDialogs(context).comingSoonSnack(),
          ),
          StatementsTile(
            svgAsset: 'assets/images/audit_confirmation.svg',
            title: 'Audit confirmation',
            subtitle: 'geniuspay reference letter to auditors',
            onPressed: () => PopupDialogs(context).comingSoonSnack(),
          ),
        ],
      ),
    );
  }
}

class StatementsTile extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;
  const StatementsTile(
      {Key? key,
      required this.svgAsset,
      required this.title,
      required this.subtitle,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Theme(
        data: ThemeData(
            splashColor: AppColor.kAccentColor2,
            highlightColor: AppColor.kAccentColor2),
        child: ListTile(
          onTap: onPressed,
          selectedTileColor: AppColor.kAccentColor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(16),
          subtitle: Text(
            subtitle,
            style: textTheme.bodyMedium,
          ),
          leading: CircleAvatar(
            backgroundColor: AppColor.kAccentColor2,
            child: SvgPicture.asset(
              svgAsset,
              color: Colors.black,
            ),
            radius: 30,
          ),
          title: Text(title, style: textTheme.headlineSmall),
        ));
  }
}
