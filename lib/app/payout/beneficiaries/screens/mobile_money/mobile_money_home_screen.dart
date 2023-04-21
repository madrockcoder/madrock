import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/widgets/custom_textfield_with_leading.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/mobile_money/mobilemoney_add_new_recipient.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/mobile_recipient_vm.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/add_new_recipient.dart';
import 'package:geniuspay/app/payout/geniuspay_to_geniuspay/enter_amount_page.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:shimmer/shimmer.dart';

class MobileMoneyRecipientHomeScreen extends StatefulWidget {
  const MobileMoneyRecipientHomeScreen({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MobileMoneyRecipientHomeScreen()),
    );
  }

  @override
  State<MobileMoneyRecipientHomeScreen> createState() =>
      _MobileMoneyRecipientHomeScreenState();
}

class _MobileMoneyRecipientHomeScreenState
    extends State<MobileMoneyRecipientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mobile Money Recipient'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: const [
          HelpIconButton(),
        ],
      ),
      body: BaseView<MobileRecipientVM>(
          onModelReady: (p0) => p0.getMobileRecipients(context),
          builder: (context, model, snapshot) {
            if (model.baseModelState == BaseModelState.loading) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const MobileRecipientWidget(
                    mobileRecipients: [],
                  ));
            } else if (model.baseModelState == BaseModelState.loading) {
              return ErrorScreen(
                  showHelp: false,
                  onRefresh: () {
                    setState(() {
                      model.getMobileRecipients(context);
                    });
                  },
                  exception: model.errorType);
            } else {
              return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      model.getMobileRecipients(context);
                    });
                  },
                  child: MobileRecipientWidget(
                      mobileRecipients: model.mobileRecipients));
            }
          }),
    );
  }
}

class MobileRecipientWidget extends StatefulWidget {
  final List<MobileRecipient> mobileRecipients;

  const MobileRecipientWidget({Key? key, required this.mobileRecipients})
      : super(key: key);

  @override
  State<MobileRecipientWidget> createState() => _MobileRecipientWidgetState();
}

class _MobileRecipientWidgetState extends State<MobileRecipientWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      children: [
        CustomTextFieldWithLeading(
            leading: SvgPicture.asset('assets/icons/search-normal.svg',
                width: 16, height: 16),
            hintText: "Search",
            controller: _searchController),
        const SizedBox(
          height: 24,
        ),
        InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MobileMoneyAddNewRecipientScreenMain()),
              );
              MobileRecipientVM mobileRecipientVM = sl<MobileRecipientVM>();
              await mobileRecipientVM.getMobileRecipients(context);
              if (mounted) {
                setState(() {});
              }
            },
            child: const AddNewRecipient(
              title: 'Add new recipient',
            )),
        const SizedBox(
          height: 16,
        ),
        for (MobileRecipient recipient in widget.mobileRecipients) ...[
          customListTile(recipient, () async {
            final result = await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const WalletSelectorList(
                    disable: true,
                  );
                });
            if (result != null) {
              EnterTransferAmountPage.show(context, result, recipient);
            }
          }),
          const SizedBox(
            height: 16,
          )
        ],
      ],
    );
  }

  Widget customListTile(
      MobileRecipient mobileRecipient, GestureTapCallback onTap) {
    String country = mobileRecipient.country!;
    final SelectCountryViewModel _selectCountryViewModel =
        sl<SelectCountryViewModel>();
    Country countryModel = _selectCountryViewModel.countries
        .where((element) => element.iso2 == country)
        .first;
    final Converter _walletHelper = Converter();
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: AppColor.kAccentColor2,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColor.kSecondaryColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${mobileRecipient.firstName} ${mobileRecipient.lastName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const Gap(4),
                  Text(
                    (countryModel.phoneCode) +
                        " " +
                        formatMobileNumber(mobileRecipient.mobileNumber, 4)
                            .replaceAll(countryModel.phoneCode, ""),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.kSecondaryColor),
                  ),
                  // Text(
                  //   mobileRecipient.accountNumber ?? beneficiary.iBan ?? '',
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: 12,
                  //       color: AppColor.kSecondaryColor),
                  // ),
                  // const Gap(4),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: AppColor.kSecondaryColor.withOpacity(0.5),
                  //       borderRadius: const BorderRadius.all(Radius.circular(16))),
                  //   child: Padding(
                  //     padding:
                  //     const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  //     child: Text(
                  //       Essentials.capitalize(beneficiary.beneficiaryType.name),
                  //       style: const TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 10),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              const Spacer(),
              SizedBox(
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 8,
                        backgroundImage: AssetImage(
                            'icons/flags/png/${_walletHelper.getLocale(mobileRecipient.country!.toLowerCase())}.png',
                            package: 'country_icons')),
                    const Gap(4),
                    Text(
                      mobileRecipient.country!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatMobileNumber(String number, int lastPlaces) {
    return number.substring(0, number.length - lastPlaces) +
        "-" +
        "X" * lastPlaces;
  }
}
