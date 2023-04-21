import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/poof_identity_confirm.dart';

import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/kyc.dart';
import 'package:geniuspay/util/color_scheme.dart';

class SelectDocumentPage extends StatefulWidget {
  final bool isResubmittingDocuments;

  const SelectDocumentPage({Key? key, this.isResubmittingDocuments = false})
      : super(key: key);

  static Future<void> show(BuildContext context,
      {bool isResubmittingDocuments = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SelectDocumentPage(
            isResubmittingDocuments: isResubmittingDocuments),
      ),
    );
  }

  @override
  State<SelectDocumentPage> createState() => _SelectDocumentPageState();
}

class _SelectDocumentPageState extends State<SelectDocumentPage> {
  bool get isResubmittingDocuments => widget.isResubmittingDocuments;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(
        onModelReady: (p0) => p0.init(context),
        builder: (context, model, snapshot) {
          return Scaffold(
            appBar: AppBar(actions: const [HelpIconButton()]),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isResubmittingDocuments
                          ? 'Resubmit your document'
                          : 'Which ID do you have?',
                      style: textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.kSecondaryColor,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      isResubmittingDocuments
                          ? 'If your identification document has changed or expired, you can submit a new document.'
                          : 'Please select your ID document type and the Country of issuance.\nProof of residence is required if you\'re living in a different country.',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const Gap(24),
                    PickerContainer(
                      hint: 'Document country',
                      borderColor: AppColor.kSecondaryColor,
                      country: model.country,
                      onPressed: () async {
                        // model.clearCountriesList();
                        _showCountryPicker(
                            selectedCountry: model.country,
                            onTap: (country) {
                              model.setCountry = country;
                            });
                      },
                    ),
                    const Gap(24),
                    SelectDocumentWidget(
                      textTheme: textTheme,
                      text: 'National Identity card',
                      icon: 'assets/icons/nationID.png',
                      isActive: model.option == DocumentType.idCard,
                      onTap: () {
                        model.setOption = DocumentType.idCard;
                      },
                    ),
                    const Gap(24),
                    SelectDocumentWidget(
                      textTheme: textTheme,
                      text: 'Passport',
                      icon: 'assets/icons/passport.png',
                      isActive: model.option == DocumentType.passport,
                      onTap: () {
                        model.setOption = DocumentType.passport;
                      },
                    ),
                    const Gap(24),
                    SelectDocumentWidget(
                      textTheme: textTheme,
                      text: 'Residence permit card',
                      icon: 'assets/icons/recisdence_permit.png',
                      isActive: model.option == DocumentType.residentPermit,
                      onTap: () {
                        model.setOption = DocumentType.residentPermit;
                      },
                    ),
                    const Spacer(),
                    if (isResubmittingDocuments)
                      CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        disabledColor: AppColor.kAccentColor3,
                        child: Text(
                          "SCAN THE DOCUMENT",
                          style: textTheme.bodyLarge,
                        ),
                        onPressed: model.country == null || model.option == null
                            ? null
                            : () async {
                                await model.initiateKyc(context, false);
                              },
                      ),
                    if (!isResubmittingDocuments)
                      ContinueButton(
                        context: context,
                        color: AppColor.kGoldColor2,
                        disabledColor: AppColor.kAccentColor3,
                        textStyle: textTheme.bodyMedium?.copyWith(
                          fontSize:
                              model.country == null || model.option == null
                                  ? 13
                                  : 14,
                          color: model.country == null || model.option == null
                              ? AppColor.kOnPrimaryTextColor3
                              : Colors.black,
                          fontWeight:
                              model.country == null && model.option == null
                                  ? FontWeight.w400
                                  : FontWeight.w600,
                        ),
                        onPressed: model.country == null || model.option == null
                            ? null
                            : () {
                                ProofIdentityConfirm.show(context);
                              },
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _showCountryPicker(
      {required Country? selectedCountry,
      required Function(Country country) onTap}) async {
    await showCustomScrollableSheet(
        context: context,
        child: CountryListWidget(
          selectedCountry: selectedCountry,
          onTap: onTap,
        ));
  }
}

class SelectDocumentWidget extends StatelessWidget {
  const SelectDocumentWidget(
      {Key? key,
      required this.textTheme,
      required this.icon,
      required this.isActive,
      required this.text,
      required this.onTap,
      this.iconWidget,
      this.subText})
      : super(key: key);

  final TextTheme textTheme;
  final bool isActive;
  final String icon;
  final String text;
  final VoidCallback onTap;
  final String? subText;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColor.kAccentColor2,
            child: Center(
              child: SizedBox(
                height: 28,
                width: 28,
                child: Image.asset(icon),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColor.kOnPrimaryTextColor2,
                  ),
                ),
                if (subText != null)
                  Text(
                    subText!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColor.kSecondaryColor,
                    ),
                  )
              ],
            ),
          ),
          iconWidget ??
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kSecondaryColor),
                  shape: BoxShape.circle,
                  color:
                      isActive ? AppColor.kSecondaryColor : Colors.transparent,
                ),
                child: isActive
                    ? const Icon(
                        Icons.done,
                        size: 10,
                        color: Colors.white,
                      )
                    : const SizedBox(),
              )
        ],
      ),
    );
  }
}
