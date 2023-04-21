import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_directors.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_owners.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/edit_details_v2.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/business_profile_model.dart';

class BusinessStructure extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            BusinessStructure(businessProfileModel: businessProfileModel),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;

  const BusinessStructure({Key? key, required this.businessProfileModel})
      : super(key: key);

  @override
  State<BusinessStructure> createState() => _BusinessStructureState();
}

class _BusinessStructureState extends State<BusinessStructure> {
  BusinessProfileModel get businessProfile => widget.businessProfileModel;

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
            title: const Text('Business Structure')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(12),
                EditDetailsV2Widget(
                  heading: "Business Directors",
                  hidSvg: true,
                  subHeading:
                      "People who own or control at least 25% of the business",
                  onEditClicked: () async {
                    await BusinessDirectors.show(
                        context, widget.businessProfileModel,
                        isUpdate: true);
                    setState(() {});
                  },
                  sections: getDirectors(),
                ),
                const Gap(18),
                EditDetailsV2Widget(
                  heading: "Business Owners",
                  hidSvg: true,
                  subHeading:
                      "People who own or control at least 25% of the business",
                  onEditClicked: () async {
                    await BusinessOwners.show(
                        context, widget.businessProfileModel,
                        isUpdate: true);
                    setState(() {});
                  },
                  sections: getOwners(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, Map<String, String>> getOwners() {
    Map<String, Map<String, String>> result = {};
    int counter = 1;
    businessProfile.beneficialOwners?.forEach((element) {
      result["Business owner $counter"] = {
        "Name": '${element.firstName} ${element.lastName}',
        "% shares": '${element.percentage}%',
        "Date of birth": element.dob.isNotEmpty ? element.dob : '-'
      };
      counter++;
    });
    return result;
  }

  Map<String, Map<String, String>> getDirectors() {
    Map<String, Map<String, String>> result = {};
    int counter = 1;
    businessProfile.directors?.forEach((element) {
      result["Business director $counter"] = {
        "Name": '${element.firstName} ${element.lastName}',
        "Date of birth": (element.dob?.isNotEmpty ?? false) ? element.dob! : '-'
      };
      counter++;
    });
    return result;
  }
}
