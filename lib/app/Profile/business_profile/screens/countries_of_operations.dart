import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/payments.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/custom_text_field.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_checkbox.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CountriesOfOperations extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CountriesOfOperations(
            businessProfileModel: businessProfileModel, isUpdate: isUpdate),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;

  const CountriesOfOperations(
      {Key? key, required this.businessProfileModel, required this.isUpdate})
      : super(key: key);

  @override
  State<CountriesOfOperations> createState() => _CountriesOfOperationsState();
}

class _CountriesOfOperationsState extends State<CountriesOfOperations> {
  final TextEditingController countriesOfOperationController =
      TextEditingController();
  final FocusNode countriesOfOperationFocusNode = FocusNode();
  List<Country> countriesOfOperation = [];

  final TextEditingController outgoingPaymentsController =
      TextEditingController();
  final FocusNode outgoingPaymentsFocusNode = FocusNode();
  List<Country> outgoingPayments = [];

  final TextEditingController incomingPaymentsController =
      TextEditingController();
  final FocusNode incomingPaymentsFocusNode = FocusNode();
  List<Country> incomingPayments = [];

  bool get areAllImportantFieldsFilled =>
      countriesOfOperationController.text.trim().isNotEmpty &&
      outgoingPaymentsController.text.trim().isNotEmpty &&
      incomingPaymentsController.text.trim().isNotEmpty;

  final _formKey = GlobalKey<FormState>();

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomYellowElevatedButton(
            onTap: () {
              widget.businessProfileModel.businessAssessment ??=
                  BusinessAssessment();
              widget.businessProfileModel.businessAssessment!
                      .countriesOfOperation =
                  countriesOfOperation.map((e) => e.iso2).toList();
              widget.businessProfileModel.businessAssessment!
                      .countriesOfOutgoingPayments =
                  outgoingPayments.map((e) => e.iso2).toList();
              widget.businessProfileModel.businessAssessment!
                      .countriesOfIncomingPayments =
                  incomingPayments.map((e) => e.iso2).toList();
              if (!widget.isUpdate) {
                Payments.show(context, widget.businessProfileModel);
              } else {
                Navigator.pop(context);
              }
            },
            disable: !areAllImportantFieldsFilled,
            text: "CONTINUE",
          ),
        ),
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: const BackButton(),
            actions: const [HelpIconButton()],
            title: const Text('Countries of operation')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSectionHeading(
                    heading: "Which countries your company is operating in?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall?.copyWith(
                        fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: countriesOfOperationController,
                        focusNode: countriesOfOperationFocusNode,
                        setState: setState,
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showCountryPickerDialog(context, (value) {
                            countriesOfOperation = value;
                            countriesOfOperationController.text =
                                countriesOfOperation
                                    .map((e) => e.name)
                                    .join(', ');
                            setState(() {});
                          }, countriesOfOperation);
                        },
                        helperText:
                            'Specific countries of operations / Target markets',
                        hintText: 'Countries of operation'),
                  ),
                  CustomSectionHeading(
                    heading:
                        "Which countries your company is going to send money to?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall?.copyWith(
                        fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: outgoingPaymentsController,
                        focusNode: outgoingPaymentsFocusNode,
                        setState: setState,
                        readOnly: true,
                        validator: (val) {
                          if (outgoingPayments.isEmpty ||
                              outgoingPayments.length >= 3) {
                            return null;
                          } else {
                            return 'At least 3 countries must be selected';
                          }
                        },
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showCountryPickerDialog(context, (value) {
                            outgoingPayments = value;
                            outgoingPaymentsController.text =
                                outgoingPayments.map((e) => e.name).join(', ');
                            setState(() {});
                          }, outgoingPayments);
                        },
                        helperText:
                            'Please, provide information about main counterparts for outgoing payments. (At least 3).',
                        hintText: 'Outgoing payments'),
                  ),
                  CustomSectionHeading(
                    heading:
                        "Which countries your company is going to receive money from?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall?.copyWith(
                        fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: incomingPaymentsController,
                        setState: setState,
                        focusNode: incomingPaymentsFocusNode,
                        validator: (val) {
                          if (incomingPayments.isEmpty ||
                              incomingPayments.length >= 3) {
                            return null;
                          } else {
                            return 'At least 3 countries must be selected';
                          }
                        },
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showCountryPickerDialog(context, (value) {
                            incomingPayments = value;
                            incomingPaymentsController.text =
                                incomingPayments.map((e) => e.name).join(', ');
                            setState(() {});
                          }, incomingPayments);
                        },
                        helperText:
                            'Please, provide information about main counterparts for outgoing payments. (At least 3). This is an array of 2-letter ISO Alpha-2 country code to allow the client to capture the expected countries to send/receive international payments from. This field is required when internationalPaymentsSupported field is true, for example, [“FR”, “DE”].',
                        helperMaxLines: 10,
                        hintText: 'Incoming payments'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showCountryPickerDialog(
      BuildContext context,
      ValueSetter<List<Country>> onChanged,
      List<Country> initalCountries) async {
    final textTheme = Theme.of(context).textTheme;
    final _searchFocus = FocusNode();
    final _searchController = TextEditingController();
    List<int> countriesIndices =
        initalCountries.map((e) => e.hashCode).toList();
    List<Country>? countries = await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BaseView<SelectCountryViewModel>(
            onModelReady: (p0) => p0.getCountries(context),
            builder: (context, model, _) {
              List<Country> countries = _searchController.text.isNotEmpty
                  ? model.foundCountries
                  : model.countries;
              return StatefulBuilder(
                builder: (context, setState) => Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .80,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(33),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                              'Which countries your company is operating in?',
                              style: textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  color: AppColor.kSecondaryColor)),
                        ),
                        const Gap(16),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: TextFieldDecoration(
                                    focusNode: _searchFocus,
                                    context: context,
                                    hintText: 'Search',
                                    clearSize: 8,
                                    prefix: const Icon(
                                      CupertinoIcons.search,
                                      color: AppColor.kSecondaryColor,
                                      size: 16,
                                    ),
                                    onClearTap: () {
                                      _searchController.clear();
                                      setState(() {
                                        model.getCountries(context);
                                      });
                                    },
                                    controller: _searchController,
                                  ).inputDecoration(),
                                  focusNode: _searchFocus,
                                  keyboardType: TextInputType.name,
                                  onTap: () {
                                    setState(() {});
                                  },
                                  onChanged: (searchTerm) {
                                    setState(() {});
                                    if (_searchController.text.isNotEmpty) {
                                      setState(() {
                                        model.searchCountry(
                                            keyword: searchTerm,
                                            context: context);
                                      });
                                    } else {
                                      setState(() {
                                        model.getCountries(context);
                                      });
                                    }
                                  },
                                ))),
                        const Gap(8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(
                                countriesIndices.length,
                                (index) => Padding(
                                      padding: EdgeInsets.only(
                                          right: 8.0,
                                          left: index == 0 ? 24.0 : 0),
                                      child: Chip(
                                          backgroundColor:
                                              AppColor.kSecondaryColor,
                                          deleteIcon: const Icon(Icons.close,
                                              color: Colors.white, size: 12),
                                          onDeleted: () {
                                            countriesIndices.removeAt(index);
                                            setState(() {});
                                          },
                                          labelStyle: textTheme.bodyMedium
                                              ?.copyWith(color: Colors.white),
                                          label: Text(model.countries
                                              .where((element) =>
                                                  element.hashCode ==
                                                  countriesIndices[index])
                                              .first
                                              .name)),
                                    )),
                          ),
                        ),
                        if (countriesIndices.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () {
                                    countriesIndices.clear();
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Center(
                                      child: Text(
                                        'CLEAR',
                                        style: textTheme.titleMedium?.copyWith(
                                            fontSize: 14,
                                            color: AppColor.kSecondaryColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Gap(8),
                        ],
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: ListView.separated(
                                  itemCount: countries.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const Gap(12);
                                  },
                                  itemBuilder: (context, index) {
                                    final country = countries[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (countriesIndices
                                            .contains(country.hashCode)) {
                                          countriesIndices
                                              .remove(country.hashCode);
                                        } else {
                                          countriesIndices.insert(
                                              0, country.hashCode);
                                        }
                                        setState(() {});
                                      },
                                      child: Row(
                                        children: [
                                          CustomCircularImage(
                                            'icons/flags/png/${country.iso2.toLowerCase()}.png',
                                            package: 'country_icons',
                                            fit: BoxFit.fill,
                                            radius: 26,
                                          ),
                                          const Gap(12),
                                          GestureDetector(
                                              child: Text(country.name),
                                              onTap: () {
                                                if (countriesIndices.contains(
                                                    country.hashCode)) {
                                                  countriesIndices
                                                      .remove(country.hashCode);
                                                } else {
                                                  countriesIndices.insert(
                                                      0, country.hashCode);
                                                }
                                                setState(() {});
                                              }),
                                          const Spacer(),
                                          CustomCheckbox(
                                            tileValue: country.hashCode,
                                            values: countriesIndices,
                                            onChanged: () {
                                              if (countriesIndices
                                                  .contains(country.hashCode)) {
                                                countriesIndices
                                                    .remove(country.hashCode);
                                              } else {
                                                countriesIndices.insert(
                                                    0, country.hashCode);
                                              }
                                              setState(() {});
                                            },
                                            checkboxShape:
                                                CustomCheckboxShape.rectangle,
                                          )
                                        ],
                                      ),
                                    );
                                  })),
                        ),
                        Gap(MediaQuery.of(context).viewInsets.bottom),
                        Container(
                          height: 60,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: CustomYellowElevatedButton(
                                    text: 'CANCEL',
                                    transparentBackground: true,
                                    onTap: () => Navigator.pop(context),
                                  )),
                              const Gap(16),
                              SizedBox(
                                  width: 100,
                                  child: CustomYellowElevatedButton(
                                    text: 'DONE',
                                    disable: countriesIndices.isEmpty,
                                    onTap: () => Navigator.pop(
                                        context,
                                        model.countries
                                            .where((element) => countriesIndices
                                                .contains(element.hashCode))
                                            .toList()),
                                  ))
                            ],
                          ),
                        )
                      ]),
                ),
              );
            },
          );
        });
    if (countries != null) {
      onChanged(countries);
    }
  }
}
