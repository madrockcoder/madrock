import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class UltimateBeneficialOwners extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const UltimateBeneficialOwners(),
      ),
    );
  }

  const UltimateBeneficialOwners({Key? key}) : super(key: key);

  @override
  State<UltimateBeneficialOwners> createState() =>
      _UltimateBeneficialOwnersState();
}

class _UltimateBeneficialOwnersState extends State<UltimateBeneficialOwners> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: const Text('Ultimate Beneficial Owners'),
        actions: const [HelpIconButton()],
      ),
      backgroundColor: AppColor.kAccentColor2,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Ultimate Beneficial Owners
              CustomSectionHeading(
                  heading: 'Ultimate Beneficial Owners',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 12,
                  child: Text(
                    'All businesses operating as a registered company are required to provide details of all Ultimate beneficial owners (UBOs). This article will give more information about UBOs.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // What is a UBO?
              CustomSectionHeading(
                  heading: 'What is a UBO?',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 32,
                  child: Text(
                    '''UBOs are individuals or organisations who, directly or indirectly, own or control 25% (or more) of the shares in the business.

Control of the business may be exercised through:

A direct shareholding
Intermediate holding companies
Individuals who have decision-making capacity with regard to the business

These are individuals who exert significant control over the company, have the power to manage the customer’s account, assets or transactions without requiring specific authority to do so, or who would be in a position to override internal procedures and control mechanisms. Examples of these individuals include power of attorneys, silent partners and guardians.

What constitutes control will depend on:

•  The nature of the company
•  The distribution of shareholdings
•  The nature and extent of any business or family connections between the beneficial owners
•  If a trust directly or indirectly owns (through any contract, arrangement, understanding, relationship or otherwise) 25% or more of equity interests of a legal entity customer, the beneficial owner is the trustee.
''',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // What if no one owns 25% or more of the business?
              CustomSectionHeading(
                  heading: 'What if no one owns 25% or more of the business?',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    '''Please provide the names and dates of birth of anyone who exercises control over the management of the company (e.g. CEO, COO, CFO.)

If there are no individuals to enter, you are not required to enter any details. Simply click the box confirming that all details provided are accurate.''',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              const Gap(16)
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile(
      {required String title,
      String? incorporationNumber,
      String? registeredAddress,
      required String countryCode,
      GestureTapCallback? onTap}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {},
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kSecondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCircularImage('icons/flags/png/$countryCode.png',
                    package: 'country_icons', radius: 16, fit: BoxFit.fill),
                const Gap(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                            fontSize: 14, color: AppColor.kSecondaryColor),
                      ),
                      if (incorporationNumber != null) ...[
                        const Gap(16),
                        RichText(
                          text: TextSpan(
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                              color: AppColor.kSecondaryColor,
                            ),
                            text: 'Incorporation Number: ',
                            children: [
                              TextSpan(
                                  text: incorporationNumber,
                                  style: textTheme.bodyMedium
                                      ?.copyWith(color: AppColor.kPinDesColor))
                            ],
                          ),
                        ),
                      ],
                      if (registeredAddress != null) ...[
                        Gap(incorporationNumber != null ? 8 : 16),
                        RichText(
                          text: TextSpan(
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                              color: AppColor.kSecondaryColor,
                            ),
                            text: 'Incorporation Number: ',
                            children: [
                              TextSpan(
                                  text: registeredAddress,
                                  style: textTheme.bodyMedium
                                      ?.copyWith(color: AppColor.kPinDesColor))
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
