import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class BusinessDetails extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            BusinessDetails(businessProfileModel: businessProfileModel),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;

  const BusinessDetails({Key? key, required this.businessProfileModel})
      : super(key: key);

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  String country = '';

  BusinessProfileModel get businessProfile => widget.businessProfileModel;

  @override
  void initState() {
    final SelectCountryViewModel _selectCountryViewModel =
        sl<SelectCountryViewModel>();
    _selectCountryViewModel
        .getCountryFromIso(context, businessProfile.registeredAddress!.country!)
        .then((value) => setState(() => country = value.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: const BackButton(),
            actions: const [HelpIconButton()],
            title: const Text('Business Profile')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              customListTile({'Country': country}, () {}),
              const Gap(16),
              customListTile(
                  {'Legal Name': businessProfile.businessName!}, () {}),
              const Gap(16),
              customListTile({
                'Company Registration Number':
                    businessProfile.registrationNumber!
              }, () {}),
              const Gap(16),
              customListTile({
                'Company Registration Number':
                    businessProfile.registrationNumber!
              }, () {}),
              const Gap(16),
              customListTile({
                'Legal Entity Number': businessProfile.legalEntityIdentifier!
              }, () {}),
              const Gap(16),
              customListTile(
                  {'Date of Incorporation': businessProfile.registeredDate!},
                  () {}),
              const Gap(16),
              customListTile({
                'Business Type': businessProfile.legalEntityIdentifier ?? '-'
              }, () {}),
              const Gap(16),
              customListTile({'Country of registration': country}, () {}),
              const Gap(16),
              customListTile({
                'Registered Address': businessProfile.getRegisteredAddress()
              }, () {}),
              const Gap(16),
              customListTile(
                  {'Service Address': businessProfile.getServiceAddress()},
                  () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile(Map<String, String> field, void Function()? onTap) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.keys.elementAt(0),
            style: textTheme.titleSmall
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
          ),
          Flexible(
            child: Text(field.values.elementAt(0),
                style: textTheme.bodyMedium
                    ?.copyWith(color: AppColor.kPinDesColor, fontSize: 12),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
