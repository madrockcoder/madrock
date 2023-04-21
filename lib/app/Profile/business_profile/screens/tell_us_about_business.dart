import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_directors.dart';
import 'package:geniuspay/app/Profile/business_profile/view_models/business_profile_vm.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/custom_text_field.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/dropdown_options.dart';
import 'package:geniuspay/app/shared_widgets/custom_loader.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class TellUsAboutBusinessMain extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TellUsAboutBusinessMain(
            businessProfileModel: businessProfileModel, isUpdate: isUpdate),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;

  const TellUsAboutBusinessMain(
      {Key? key, required this.businessProfileModel, required this.isUpdate})
      : super(key: key);

  @override
  State<TellUsAboutBusinessMain> createState() =>
      _TellUsAboutBusinessMainState();
}

class _TellUsAboutBusinessMainState extends State<TellUsAboutBusinessMain> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BusinessProfileVM>(
      onModelReady: (p0) => p0.getCompanyTypesAndBusinessCategories(
          widget.businessProfileModel.registeredCountry!),
      builder: (context, model, snapshot) {
        if (model.baseModelState == BaseModelState.loading) {
          return const CustomLoaderScreen();
        } else {
          return TellUsAboutBusiness(
            businessProfileModel: widget.businessProfileModel,
            businessProfileVM: model,
            isUpdate: widget.isUpdate,
          );
        }
      },
    );
  }
}

class TellUsAboutBusiness extends StatefulWidget {
  final BusinessProfileModel businessProfileModel;
  final BusinessProfileVM businessProfileVM;
  final bool isUpdate;

  const TellUsAboutBusiness(
      {Key? key,
      required this.businessProfileModel,
      required this.businessProfileVM,
      required this.isUpdate})
      : super(key: key);

  @override
  State<TellUsAboutBusiness> createState() => _TellUsAboutBusinessState();
}

class _TellUsAboutBusinessState extends State<TellUsAboutBusiness> {
  final TextEditingController companyTypeController = TextEditingController();
  final FocusNode companyTypeFocusNode = FocusNode();
  late List<IdName> companyTypeItems;
  int companyTypeIndex = 0;

  late TextEditingController sourceFundsController;
  final FocusNode sourceFundsFocusNode = FocusNode();

  final TextEditingController businessCategoryController =
      TextEditingController();
  final FocusNode businessCategoryFocusNode = FocusNode();
  late List<IdName> businessCategoryItems;
  int businessCategoryIndex = 0;

  final TextEditingController businessSubCategoryController =
      TextEditingController();
  final FocusNode businessSubCategoryFocusNode = FocusNode();
  late List<IdName> businessSubCategoryItems;
  int businessSubCategoryIndex = 0;

  late TextEditingController vatController;
  final FocusNode vatFocusNode = FocusNode();

  late TextEditingController businessDoController;
  final FocusNode businessDoFocusNode = FocusNode();

  late TextEditingController websiteController;
  final FocusNode websiteFocusNode = FocusNode();

  late TextEditingController employeesController;
  final FocusNode employeesFocusNode = FocusNode();
  late List<IdName> employeesItems;
  int employeesIndex = 0;

  bool get areAllImportantFieldsFilled =>
      companyTypeController.text.trim().isNotEmpty &&
      businessCategoryController.text.trim().isNotEmpty &&
      businessSubCategoryController.text.trim().isNotEmpty &&
      businessDoController.text.trim().isNotEmpty &&
      websiteController.text.trim().isNotEmpty &&
      sourceFundsController.text.trim().isNotEmpty &&
      employeesController.text.trim().isNotEmpty &&
      hasValidUrl(websiteController.text) &&
      businessDoController.text.length > 75;

  @override
  void initState() {
    companyTypeItems = widget.businessProfileVM.companyTypes
        .map((e) => IdName(e.name, e.id))
        .toList();
    List<String> doIKnowThisIds = [];
    var _businessCategoryItems =
        widget.businessProfileVM.businessCategories.map((e) {
      if (doIKnowThisIds.contains(e.categoryId)) {
        return null;
      } else {
        doIKnowThisIds.add(e.categoryId);
        return IdName(e.categoryName, e.categoryId);
      }
    }).toList();
    businessCategoryItems = List<IdName>.from(
        _businessCategoryItems.where((element) => element != null).toList());
    businessSubCategoryItems = widget.businessProfileVM.businessCategories
        .map((e) => IdName(e.subCategoryName, e.subCategoryId))
        .toList();
    employeesItems = [
      IdName('1-10', '1-10'),
      IdName('11-20', '11-20'),
      IdName('21-50', '21-50'),
      IdName('50-200', '50-200'),
      IdName('200+', '200+'),
    ];
    if (widget.businessProfileModel.legalEntityType != null) {
      int _index = companyTypeItems.indexWhere((element) =>
          widget.businessProfileModel.legalEntityType!.id == element.id);
      companyTypeController.text = companyTypeItems[_index].name;
      companyTypeIndex = _index;
    }
    if (widget.businessProfileModel.category != null) {
      int _index = businessCategoryItems.indexWhere(
          (element) => widget.businessProfileModel.category!.id == element.id);
      businessCategoryController.text = businessCategoryItems[_index].name;
      businessCategoryIndex = _index;
    }
    if (widget.businessProfileModel.subCategory != null) {
      int _index = businessSubCategoryItems.indexWhere((element) =>
          widget.businessProfileModel.subCategory!.id == element.id);
      businessSubCategoryController.text =
          businessSubCategoryItems[_index].name;
      businessSubCategoryIndex = _index;
    }
    sourceFundsController = TextEditingController(
        text: widget.businessProfileModel.businessAssessment?.sourceOfFunds);
    vatController =
        TextEditingController(text: widget.businessProfileModel.taxNumber);
    businessDoController = TextEditingController(
        text: widget.businessProfileModel.natureOfBusiness);
    websiteController =
        TextEditingController(text: widget.businessProfileModel.website);
    employeesController = TextEditingController(
        text: widget.businessProfileModel.businessAssessment?.totalEmployees);
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
            title: const Text('')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSectionHeading(
                    heading: "Tell us about your business",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.displayMedium?.copyWith(
                        fontSize: 20, color: AppColor.kSecondaryColor),
                    child: Text(
                      "We require information about your business so we can meet our regulation requirements and enable you to start accepting payments. These checks won’t affect your credit score.",
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kPinDesColor),
                    ),
                  ),
                  const Gap(24),
                  CustomTextField(
                      controller: companyTypeController,
                      setState: setState,
                      focusNode: companyTypeFocusNode,
                      suffix: const Icon(Icons.keyboard_arrow_down,
                          color: AppColor.kSecondaryColor, size: 20),
                      readOnly: true,
                      helperText:
                          'A business entity is an entity that is formed and administered as per corporate law in order to engage in business activities.',
                      helperMaxLines: 3,
                      onTap: () {
                        _showDialog(
                            'Company type', companyTypeIndex, companyTypeItems,
                            (_index) {
                          companyTypeController.text =
                              companyTypeItems[_index].name;
                          companyTypeIndex = _index;
                          setState(() {});
                        }, context);
                      },
                      hintText: 'Company type'),
                  CustomTextField(
                      controller: businessCategoryController,
                      setState: setState,
                      focusNode: businessCategoryFocusNode,
                      readOnly: true,
                      suffix: const Icon(Icons.keyboard_arrow_down,
                          color: AppColor.kSecondaryColor, size: 20),
                      onTap: () async {
                        await _showDialog(
                            'Business category',
                            businessCategoryIndex,
                            businessCategoryItems, (_index) {
                          businessCategoryController.text =
                              businessCategoryItems[_index].name;
                          businessCategoryIndex = _index;
                          setState(() {});
                        }, context);
                        businessSubCategoryIndex = 0;
                        businessSubCategoryController.clear();
                        businessSubCategoryItems = widget
                            .businessProfileVM.businessCategories
                            .where((element) =>
                                element.categoryId ==
                                businessCategoryItems[businessCategoryIndex].id)
                            .map((e) =>
                                IdName(e.subCategoryName, e.subCategoryId))
                            .toList();
                      },
                      hintText: 'Business category',
                      helperText:
                          'The area of operations a business is incorporated under. This is the business classification indicated in incorporation documents.',
                      helperMaxLines: 3),
                  if (businessCategoryController.text.isNotEmpty)
                    CustomTextField(
                        controller: businessSubCategoryController,
                        setState: setState,
                        focusNode: businessSubCategoryFocusNode,
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        helperText:
                            'The area of operations a business is incorporated under. This is the business classification indicated in incorporation documents.',
                        helperMaxLines: 3,
                        onTap: () {
                          _showDialog(
                              'Business subcategory',
                              businessSubCategoryIndex,
                              businessSubCategoryItems, (_index) {
                            businessSubCategoryController.text =
                                businessSubCategoryItems[_index].name;
                            businessSubCategoryIndex = _index;
                            setState(() {});
                          }, context);
                        },
                        hintText: 'Business subcategory'),
                  CustomTextField(
                      controller: vatController,
                      setState: setState,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      maxLength: 20,
                      focusNode: vatFocusNode,
                      hintText: 'VAT registration number (Optional)',
                      helperText:
                          'Leave this blank if you are not VAT registered'),
                  CustomSectionHeading(
                    heading: 'Source of funds',
                    headingTextStyle: textTheme.bodyLarge
                        ?.copyWith(color: AppColor.kSecondaryColor),
                    headingAndChildGap: 8,
                    child: CustomTextField(
                        controller: sourceFundsController,
                        setState: setState,
                        focusNode: sourceFundsFocusNode,
                        textInputAction: null,
                        validator: (val) {
                          if (sourceFundsController.text.isNotEmpty ||
                              FocusScope.of(context).focusedChild ==
                                  sourceFundsFocusNode) {
                            if (val == null || val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.length < 25) {
                              return 'Minimum 25 characters required';
                            }
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        alignHintTextOnTop: true,
                        hintText:
                            'Tell us more about the source of your business funds'),
                  ),
                  CustomSectionHeading(
                      heading: 'What does your business do?',
                      headingTextStyle: textTheme.bodyLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                      child: CustomTextField(
                          controller: businessDoController,
                          setState: setState,
                          focusNode: businessDoFocusNode,
                          textInputAction: null,
                          alignHintTextOnTop: true,
                          hintText:
                              'Tell us in your own words more about your business. This will help us understand you needs better and also to meet regulatory requirements. Nature of Business refers to the type or general category of business or commerce you are describing.',
                          helperMaxLines: 7,
                          validator: (val) {
                            if (businessDoController.text.isNotEmpty ||
                                FocusScope.of(context).focusedChild ==
                                    businessDoFocusNode) {
                              if (val == null || val.isEmpty) {
                                return 'Field cannot be empty';
                              } else if (val.length < 75) {
                                return 'Minimum 75 characters required';
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline),
                      headingAndChildGap: 8),
                  CustomSectionHeading(
                      heading: 'Website',
                      headingTextStyle: textTheme.bodyLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                      child: CustomTextField(
                          controller: websiteController,
                          prefix: !websiteController.text.startsWith('https')
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('https://'),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 55,
                                      color: AppColor.kSecondaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                )
                              : null,
                          setState: setState,
                          helperText:
                              'The website of registered business or social media page used for business. This must be a valid URL.',
                          helperMaxLines: 3,
                          validator: (val) {
                            if (websiteController.text.isNotEmpty ||
                                FocusScope.of(context).focusedChild ==
                                    websiteFocusNode) {
                              if (val == null || val.isEmpty) {
                                return 'Field cannot be empty';
                              } else if (!hasValidUrl(websiteController.text)) {
                                return 'Invalid Url passed';
                              }
                            }
                            return null;
                          },
                          focusNode: websiteFocusNode,
                          keyboardType: TextInputType.url,
                          hintText: 'Website URL'),
                      headingAndChildGap: 8),
                  CustomSectionHeading(
                      heading:
                          'What is the total number of employees for the business? ',
                      headingTextStyle: textTheme.bodyLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                      child: CustomTextField(
                          controller: employeesController,
                          setState: setState,
                          focusNode: employeesFocusNode,
                          helperText:
                              'This field contains the total number of employee for the business.',
                          helperMaxLines: 3,
                          suffix: const Icon(Icons.keyboard_arrow_down,
                              color: AppColor.kSecondaryColor, size: 20),
                          onTap: () {
                            _showDialog(
                                'Company size', employeesIndex, employeesItems,
                                (_index) {
                              employeesController.text =
                                  employeesItems[_index].name;
                              employeesIndex = _index;
                              setState(() {});
                            }, context);
                          },
                          readOnly: true,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          hintText: 'Total employees'),
                      headingAndChildGap: 8),
                  const Gap(36),
                  CustomYellowElevatedButton(
                    onTap: () {
                      String _website = websiteController.text;
                      if(!_website.startsWith('http')){
                        if(!_website.startsWith('www')){
                          _website = 'https://www.' + _website;
                        }else{
                          _website = 'https://' + _website;
                        }
                      }
                      print(_website);
                      widget.businessProfileModel.legalEntityType =
                          companyTypeItems[companyTypeIndex];
                      widget.businessProfileModel.category =
                          businessCategoryItems[businessCategoryIndex];
                      widget.businessProfileModel.subCategory =
                          businessSubCategoryItems[businessSubCategoryIndex];
                      widget.businessProfileModel.taxNumber =
                          vatController.text;
                      widget.businessProfileModel.natureOfBusiness =
                          businessDoController.text;
                      widget.businessProfileModel.website =
                          _website;
                      widget.businessProfileModel.businessAssessment ??=
                          BusinessAssessment();
                      widget.businessProfileModel.businessAssessment!
                          .sourceOfFunds = sourceFundsController.text;
                      widget.businessProfileModel.businessAssessment!
                          .totalEmployees = employeesController.text;
                      if (!widget.isUpdate) {
                        BusinessDirectors.show(
                            context, widget.businessProfileModel);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    disable: !areAllImportantFieldsFilled,
                    text: "CONTINUE",
                  ),
                  const Gap(24)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showDialog(String heading, int selectedIndex, List<IdName> items,
      ValueSetter<int> onChanged, BuildContext context) async {
    int? value = await showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (context) {
          return DropDownOptions(
            initialChecked: selectedIndex,
            heading: heading,
            items: items.map((e) => e.name).toList(),
          );
        });
    if (value != null) {
      onChanged(value);
    }
  }

  bool hasValidUrl(String value) {
    String pattern =
        r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-@]+))*$";
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
