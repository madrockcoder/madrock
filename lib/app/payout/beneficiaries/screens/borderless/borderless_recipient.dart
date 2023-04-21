import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/borderless/borderless_add_new_recipient_screen.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/borderless_recipient_vm.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/add_new_recipient.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/listtile_with_email.dart';
import 'package:geniuspay/app/payout/geniuspay_to_geniuspay/enter_amount_page.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/email_recipient.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:shimmer/shimmer.dart';

class BorderlessRecipientHomeScreen extends StatefulWidget {
  final Wallet? wallet;

  const BorderlessRecipientHomeScreen({Key? key, required this.wallet})
      : super(key: key);

  static Future<void> show(BuildContext context, {Wallet? wallet}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => BorderlessRecipientHomeScreen(
                wallet: wallet,
              )),
    );
  }

  @override
  State<BorderlessRecipientHomeScreen> createState() =>
      _BorderlessRecipientHomeScreenState();
}

class _BorderlessRecipientHomeScreenState
    extends State<BorderlessRecipientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Borderless Recipient"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: const [
          HelpIconButton(),
        ],
      ),
      body: BaseView<BorderLessRecipientVM>(
          onModelReady: (p0) => p0.getEmailRecipients(),
          builder: (context, model, snapshot) {
            if (model.baseModelState == BaseModelState.loading) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: BorderlessRecipientWidget(
                      emailRecipients: const [], wallet: widget.wallet));
            } else if (model.baseModelState == BaseModelState.loading) {
              return ErrorScreen(
                  showHelp: false,
                  onRefresh: () {
                    setState(() {
                      model.getEmailRecipients();
                    });
                  },
                  exception: model.errorType);
            } else {
              return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      model.getEmailRecipients();
                    });
                  },
                  child: BorderlessRecipientWidget(
                      emailRecipients: model.emailRecipients,
                      wallet: widget.wallet));
            }
          }),
    );
  }
}

class BorderlessRecipientWidget extends StatefulWidget {
  final List<EmailRecipient> emailRecipients;
  final Wallet? wallet;

  const BorderlessRecipientWidget(
      {Key? key, required this.emailRecipients, this.wallet})
      : super(key: key);

  @override
  State<BorderlessRecipientWidget> createState() =>
      _BorderlessRecipientWidgetState();
}

class _BorderlessRecipientWidgetState extends State<BorderlessRecipientWidget> {
  final TextEditingController _searchController = TextEditingController();
  final _searchNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: TextFieldDecoration(
                      focusNode: _searchNode,
                      context: context,
                      hintText: 'Search',
                      clearSize: 8,
                      prefix: const Icon(
                        CupertinoIcons.search,
                        color: AppColor.kSecondaryColor,
                        size: 18,
                      ),
                      onClearTap: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      controller: _searchController,
                    ).inputDecoration(),
                    focusNode: _searchNode,
                    keyboardType: TextInputType.name,
                    onChanged: (val) {
                      setState(() {});
                    },
                    onSaved: (val) {
                      setState(() {});
                    },
                  )),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                  onTap: () {
                    BeneficiaryAddNewRecipientScreen.show(
                      context,
                    );
                  },
                  child: const AddNewRecipient(
                    title: 'Add new Recipient',
                  )),
              const SizedBox(
                height: 25,
              ),
              for (EmailRecipient recipient in widget.emailRecipients) ...[
                if (_searchController.text.isEmpty ||
                    "${recipient.firstName} ${recipient.lastName}"
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                  ListTileWithEmail(
                      recipientName:
                          "${recipient.firstName} ${recipient.lastName}",
                      email: recipient.email,
                      onTap: () async {
                        if (widget.wallet != null) {
                          EnterTransferAmountPage.show(
                              context, widget.wallet!, recipient);
                        } else {
                          final result = await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return const WalletSelectorList(
                                  disable: true,
                                );
                              });
                          if (result != null) {
                            EnterTransferAmountPage.show(
                                context, result, recipient);
                          }
                        }
                      }),
                const SizedBox(
                  height: 17,
                )
              ],
            ],
          ),
        ));
  }
}
