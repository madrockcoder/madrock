import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/live_support_chat_widget.dart';
import 'package:geniuspay/app/faq/model/app_faq_model.dart';
import 'package:geniuspay/app/faq/screens/app_faq_screen.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/util/color_scheme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const HelpScreen(),
      ),
    );
  }

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/cancel.svg'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We're available around the clock!",
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              SizedBox(
                  height: 40,
                  child: TextFormField(
                    enableInteractiveSelection: false,
                    controller: _searchController,
                    showCursor: false,
                    decoration: TextFieldDecoration(
                      focusNode: _searchFocus,
                      context: context,
                      hintText: 'Search',
                      clearSize: 8,
                      prefix: const Icon(
                        CupertinoIcons.search,
                        color: AppColor.kSecondaryColor,
                        size: 18,
                      ),
                      onClearTap: () {},
                      controller: _searchController,
                    ).inputDecoration(),
                    focusNode: _searchFocus,
                    keyboardType: TextInputType.none,
                    onTap: () {
                      AppFAQ.show(
                          context: context, type: FAQType.all, autofocus: true);
                    },
                  )),
              const Gap(20),
              Text(
                'Chat with us',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(8),
              const LiveSupportChatWidget(),
              const Gap(20),
              Text(
                'Topics',
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColor.kOnPrimaryTextColor2,
                ),
              ),
              HelpListWidget(
                  onTap: () {
                    AppFAQ.show(context: context, type: FAQType.account);
                  },
                  icon: 'assets/images/account.svg',
                  title: 'My account'),
              // const HelpListWidget(
              //     icon: 'assets/images/cards.svg', title: 'Cards'),
              HelpListWidget(
                icon: 'assets/images/security.svg',
                title: 'Security',
                onTap: () {
                  AppFAQ.show(context: context, type: FAQType.security);
                },
              ),
              HelpListWidget(
                icon: 'assets/images/payments.svg',
                title: 'Payments',
                onTap: () {
                  AppFAQ.show(context: context, type: FAQType.payments);
                },
              ),
              HelpListWidget(
                icon: 'assets/images/payments.svg',
                title: 'Deposits / Withdrawals',
                onTap: () {
                  AppFAQ.show(context: context, type: FAQType.payinout);
                },
              ),
              HelpListWidget(
                icon: 'assets/images/app.svg',
                title: 'App',
                onTap: () {
                  AppFAQ.show(context: context, type: FAQType.app);
                },
              ),
              HelpListWidget(
                  icon: 'assets/images/others.svg', 
                  title: 'Other',
                  onTap: () {
                  AppFAQ.show(context: context, type: FAQType.other);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpListWidget extends StatelessWidget {
  const HelpListWidget(
      {Key? key, required this.icon, this.onTap, required this.title})
      : super(key: key);

  final VoidCallback? onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColor.kAccentColor2,
        child: Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
      title: Text(
        title,
        style: textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          color: AppColor.kOnPrimaryTextColor2,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColor.kOnPrimaryTextColor2,
        size: 20,
      ),
    );
  }
}
