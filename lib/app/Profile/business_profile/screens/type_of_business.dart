import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

import '../../../shared_widgets/custom_text_field.dart';

class TypeOfBusiness extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            TypeOfBusiness(businessProfileModel: businessProfileModel),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;

  const TypeOfBusiness({Key? key, required this.businessProfileModel}) : super(key: key);

  @override
  State<TypeOfBusiness> createState() => _TypeOfBusinessState();
}

class _TypeOfBusinessState extends State<TypeOfBusiness> {
  BusinessProfileModel get businessProfile => widget.businessProfileModel;

  late TextEditingController _categoryController;
  late TextEditingController _websiteController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _categoryController =
        TextEditingController(text: businessProfile.category!.name);
    _websiteController = TextEditingController(text: businessProfile.website);
    _descriptionController =
        TextEditingController(text: businessProfile.natureOfBusiness);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            title: const Text('Type of business')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Opacity(
              opacity: 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColor.kSecondaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.edit_outlined,
                            color: Colors.white, size: 14),
                        const Gap(4),
                        Text(
                          'Edit',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: _categoryController,
                    style: textTheme.bodyMedium,
                    height: 50,
                    radius: 9,
                    fillColor: AppColor.kAccentColor2.withOpacity(0.5),
                    keyboardType: TextInputType.emailAddress,
                    label: 'Category',
                    hint: 'Category',
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: _websiteController,
                    style: textTheme.bodyMedium,
                    height: 50,
                    radius: 9,
                    fillColor: AppColor.kAccentColor2.withOpacity(0.5),
                    keyboardType: TextInputType.emailAddress,
                    label: 'Website',
                    hint: 'Website',
                  ),
                  const Gap(16),
                  CustomTextField(
                      controller: _descriptionController,
                      style: textTheme.bodyMedium,
                      radius: 9,
                      maxLines: 6,
                      fillColor: AppColor.kAccentColor2.withOpacity(0.5),
                      keyboardType: TextInputType.emailAddress,
                      label: 'Description',
                      hint: 'Description'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
