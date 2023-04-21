import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/bank_recipient_vm.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/add_new_recipient.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/widgets/beneficiary_widget.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/add_new_receiver_bottomsheet.dart';

import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/widgets/custom_textfield_with_leading.dart';
import 'package:geniuspay/app/shared_widgets/custom_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:shimmer/shimmer.dart';

class BankRecipientHome extends StatefulWidget {
  final bool isEuropean;
  final String title;
  final Function(BankBeneficiary?) onselected;

  const BankRecipientHome(
      {Key? key,
      required this.onselected,
      required this.isEuropean,
      required this.title})
      : super(key: key);

  static Future<void> show(
      BuildContext context,
      Function(BankBeneficiary?) onselected,
      bool isEuropean,
      String title) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => BankRecipientHome(
                onselected: onselected,
                isEuropean: isEuropean,
                title: title,
              )),
    );
  }

  @override
  State<BankRecipientHome> createState() => _BankRecipientHomeState();
}

class _BankRecipientHomeState extends State<BankRecipientHome> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool get hasFocus => focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init;
    return Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: CustomIconButton(
              iconData: Icons.close,
              onTap: () {
                Navigator.pop(context);
              }),
          actions: const [
            HelpIconButton(),
          ],
        ),
        body: BaseView<BankRecipientVM>(
            onModelReady: (p0) => p0.getBankBeneficiaries(),
            builder: (context, model, snapshot) {
              if (model.baseModelState == BaseModelState.loading) {
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              enabled: true,
                              child: CustomTextFieldWithLeading(
                                  leading: SvgPicture.asset(
                                      'assets/icons/search-normal.svg',
                                      width: 16,
                                      height: 16),
                                  hintText: "Search",
                                  controller: controller)),
                          const SizedBox(
                            height: 24,
                          ),
                          Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              enabled: true,
                              child: InkWell(
                                  onTap: () {},
                                  child: const AddNewRecipient(
                                    title: 'Add new bank account',
                                  ))),
                          Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              enabled: true,
                              child: CustomSectionHeading(
                                  heading: "All",
                                  headingTextStyle: const TextStyle(
                                      color: AppColor.kSecondaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  child: Column(
                                    children: List.generate(
                                        2,
                                        (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: BeneficiaryWidget(
                                                beneficiary: BankBeneficiary(
                                                    user: 'user',
                                                    currency: 'USD',
                                                    bankCountryIso2: 'us',
                                                    idenitifierType:
                                                        BankIdentifierType.aba,
                                                    identifierValue:
                                                        'identifierValue',
                                                    beneficiaryFirstName:
                                                        'Dorothy',
                                                    beneficiaryLastName:
                                                        'Smith',
                                                    beneficiaryType:
                                                        BankRecipientType
                                                            .individual,
                                                    beneficiaryCountry: 'US'),
                                                onTap: () {},
                                              ),
                                            )),
                                  ),
                                  headingAndChildGap: 8)),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        model.getBankBeneficiaries();
                      });
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: controller,
                                    decoration: TextFieldDecoration(
                                      focusNode: focusNode,
                                      context: context,
                                      hintText: 'Search',
                                      clearSize: 8,
                                      prefix: const Icon(
                                        CupertinoIcons.search,
                                        color: AppColor.kSecondaryColor,
                                        size: 18,
                                      ),
                                      onClearTap: () {
                                        controller.clear();
                                        model.searchBeneficiary('');
                                      },
                                      controller: controller,
                                    ).inputDecoration(),
                                    focusNode: focusNode,
                                    keyboardType: TextInputType.name,
                                    onChanged: (val) {
                                      model.searchBeneficiary(val);
                                    },
                                    onSaved: (val) {
                                      model.searchBeneficiary(val ?? '');
                                    },
                                  )),
                              const SizedBox(
                                height: 24,
                              ),
                              InkWell(
                                  onTap: () {
                                    onClickingAddNewRecipient();
                                  },
                                  child: const AddNewRecipient(
                                    title: 'Add new bank account',
                                  )),
                              if (model.lastUsedBankBeneficiary != null)
                                CustomSectionHeading(
                                    heading: "Recently Used",
                                    headingTextStyle: const TextStyle(
                                        color: AppColor.kSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    child: BeneficiaryWidget(
                                        beneficiary:
                                            model.lastUsedBankBeneficiary!,
                                        onTap: () {
                                          Navigator.pop(
                                            context,
                                          );
                                          widget.onselected(
                                              model.lastUsedBankBeneficiary);
                                        },
                                        isSelected: true),
                                    headingAndChildGap: 8),
                              if (model.bankBeneficiaries.isNotEmpty)
                                CustomSectionHeading(
                                    heading: "All",
                                    headingTextStyle: const TextStyle(
                                        color: AppColor.kSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    child: Column(
                                      children: List.generate(
                                          model.bankBeneficiaries.length,
                                          (index) {
                                        if (!widget.isEuropean ||
                                            model.sepaCurrencies.contains(model
                                                .bankBeneficiaries[index]
                                                .currency)) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: BeneficiaryWidget(
                                              beneficiary: model
                                                  .bankBeneficiaries[index],
                                              onTap: () {
                                                Navigator.pop(
                                                  context,
                                                );
                                                widget.onselected(model
                                                    .bankBeneficiaries[index]);
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                    ),
                                    headingAndChildGap: 8),
                            ],
                          ),
                        ),
                      ),
                    ));
              }
            }));
  }

  onClickingAddNewRecipient() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .8),
              child: AddNewReceiverBottomSheet(
                  onselected: (beneficiary) {
                    Navigator.pop(
                      context,
                    );
                    Navigator.pop(context);
                    widget.onselected(beneficiary);
                  },
                  isEuropean: widget.isEuropean));
        });
  }
}
