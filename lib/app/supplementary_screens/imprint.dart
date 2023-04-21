import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class Imprint extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const Imprint(),
      ),
    );
  }

  const Imprint({Key? key}) : super(key: key);

  @override
  State<Imprint> createState() => _ImprintState();
}

class _ImprintState extends State<Imprint> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('Imprint'),
        actions: const [HelpIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // legal notice
              CustomSectionHeading(
                  heading: 'Legal Notice',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 12,
                  child: Column(
                    children: [
                      customListTile(
                          title: 'geniuspay Inc. (Canada)',
                          countryCode: 'ca',
                          incorporationNumber: '1397518-5',
                          registeredAddress:
                              '9 RUE DES COLIBRIS SAINT-CLET, QC, CNADA J0P1S0'),
                      const Gap(8),
                      customListTile(
                          title: 'geniuspay Inc. (U.S.)',
                          countryCode: 'us',
                          registeredAddress:
                              '651 N BROAD ST SUITE 201, MIDDLETOWN, DE 19709'),
                      const Gap(8),
                      customListTile(
                          title: 'geniuspay Ltd. (U.K.)',
                          countryCode: 'gb',
                          incorporationNumber: '12976922',
                          registeredAddress:
                              'Kemp House, 160 City Road, London, United Kingdom, EC1V 2NX'),
                      const Gap(8),
                      customListTile(
                          title: 'geniuspay OÜ. (Estonia)',
                          countryCode: 'ee',
                          incorporationNumber: '16294084',
                          registeredAddress:
                              'Harjumaa, Tallinn linn, Sakala tn 7-2, 10141, Estonia'),
                      const Gap(8),
                      customListTile(
                          title: 'geniuspay Sp. z o.o. (Poland)',
                          countryCode: 'pl',
                          incorporationNumber: '0000966701',
                          registeredAddress:
                              'UL. RYCHTALSKA 11/71, 50-304 WROCŁAW, POLAND'),
                    ],
                  ),
                  headingAndChildGap: 16),

              // regulation
              CustomSectionHeading(
                  heading: 'Regulation',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    'geniuspay Inc. (License No. M22313641) is regulated by the Financial Transactions and Reports Analysis Centre of Canada (FINTRAC) as a Money Service Business.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // copyright
              CustomSectionHeading(
                  heading: 'Copyright',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    'All information available on the geniuspay Inc. (dba geniuspay) website is under the copyright of geniuspay without prejudice to the copyright of third parties. In no event may you acquire title to any software or material by downloading, or otherwise copying, from the geniuspay. geniuspay  reserves its rights concerning copyright and trademark ownership of all information on the geniuspay website and will enforce such rights to the full extent of applicable law.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // no reliance
              CustomSectionHeading(
                  heading: 'No Reliance / No Representation or Warranty',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    'The information made available on the geniuspay website has been prepared by geniuspay, which has taken all reasonable care to ensure that it is fair, accurate, and complete. However, geniuspay  makes no representation or warranty, express or implied, as to the accuracy, completeness, or fitness for any purpose or use of the said information.\n\ngeniuspay cannot guarantee that the information found on the geniuspay website has not been distorted as a result of technical or other malfunctions (disconnection, interference by third parties, viruses, etc.). Nothing contained on the geniuspay website shall be construed as specific investment, legal, tax, or other advice. The information or opinions contained on the website are provided for personal and informational purposes only and are subject to change without notice.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // limitations
              CustomSectionHeading(
                  heading: 'Limitations on Liability',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    'To the extent permitted by law, geniuspay, the company or its members, partners, directors, officers, and employees will not be liable, including in the case of negligence, for any loss or damages of any kind, including but not limited to any direct, indirect or consequential damages, arising out of or related to the access of, use of, browsing in, or downloading from the geniuspay website or any other site linked with the geniuspay website.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // linked websites
              CustomSectionHeading(
                  heading: 'Linked Websites',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    'The geniuspay website may contain links to other websites controlled or offered by third parties. geniuspay has not been reviewed, and hereby makes no representation or warranty for any information or material available at any of these linked websites. By linking a third-party website to the geniuspay website, geniuspay does not endorse or recommend any products or services offered on such third-party websites.',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                  headingAndChildGap: 8),

              // governing laws
              CustomSectionHeading(
                  heading: 'Governing Law',
                  headingTextStyle: textTheme.headlineMedium
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Text(
                    'Use of the geniuspay website shall be made subject to the laws of Canada, which shall exclusively govern the interpretation, application, and effect of all the above conditions of use. The courts of Canada shall have exclusive jurisdiction over all claims or disputes arising concerning, out of, or in connection with the geniuspay website and its use.',
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
                            text: 'Registered Address: ',
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
