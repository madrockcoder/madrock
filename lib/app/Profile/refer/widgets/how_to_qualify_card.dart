import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/refer/widgets/leading_icon_listtile.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/terms_and_policies_page.dart';

import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class HowToQualifyCard extends StatelessWidget {
  const HowToQualifyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.close_sharp,
                      color: AppColor.kScaffoldBackgroundColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(kQualifyHeader,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 16)),
                  ),
                  const Spacer(),
                ],
              ),
              const Gap(24),
              LeadingIconListTile(
                  Image.asset(
                    kValid,
                  ),
                  kQualifyCondition1),
              const SizedBox(
                height: 16,
              ),
              LeadingIconListTile(
                  Image.asset(
                    kValid,
                  ),
                  kQualifyCondition2),
              const SizedBox(
                height: 16,
              ),
              LeadingIconListTile(
                  Image.asset(
                    kInvalid,
                  ),
                  kQualifyCondition3),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                  onTap: () => TermsAndPoliciesPage.show(context,
                      policy: Policy.referalTerms),
                  child: Text(
                    kReferralTermsHeader,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColor.kSecondaryColor),
                  )),
              const SizedBox(
                height: 55,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
