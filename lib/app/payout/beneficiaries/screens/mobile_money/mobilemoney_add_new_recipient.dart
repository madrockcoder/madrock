import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/mobile_recipient_vm.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/dropdown_options.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/mobile_network_list.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_loader.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/mobile_network.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';

class MobileMoneyAddNewRecipientScreenMain extends StatefulWidget {
  const MobileMoneyAddNewRecipientScreenMain({Key? key}) : super(key: key);

  @override
  State<MobileMoneyAddNewRecipientScreenMain> createState() =>
      _MobileMoneyAddNewRecipientScreenMainState();
}

class _MobileMoneyAddNewRecipientScreenMainState
    extends State<MobileMoneyAddNewRecipientScreenMain>
    with TickerProviderStateMixin {
  late CustomLoaderController customLoaderController;

  @override
  void initState() {
    customLoaderController = CustomLoaderController()
      ..initialize(this, const Duration(milliseconds: 1000))
      ..start();
    super.initState();
  }

  @override
  void dispose() {
    customLoaderController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MobileRecipientVM>(
      onModelReady: (p0) => p0.getMMTCountries(),
      builder: (context, model, snapshot) {
        if (model.baseModelState == BaseModelState.loading) {
          return Scaffold(
            body: Center(
                child: CustomLoader(
                    size: 104, controller: customLoaderController)),
          );
        } else {
          return MobileMoneyAddNewRecipientScreen(
            mmtCountries: model.mmtCountries,
          );
        }
      },
    );
  }
}

class MobileMoneyAddNewRecipientScreen extends StatefulWidget {
  const MobileMoneyAddNewRecipientScreen({Key? key, this.mmtCountries})
      : super(key: key);
  final List<Country>? mmtCountries;

  @override
  State<MobileMoneyAddNewRecipientScreen> createState() =>
      _MobileMoneyAddNewRecipientScreenState();
}

class _MobileMoneyAddNewRecipientScreenState
    extends State<MobileMoneyAddNewRecipientScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _countryController = TextEditingController();
  final FocusNode _countryFocusNode = FocusNode();

  final TextEditingController _mobileNetworkController =
      TextEditingController();
  final FocusNode _mobileNetworkFocusNode = FocusNode();

  final TextEditingController _mobileNumberController = TextEditingController();
  final FocusNode _mobileNumberFocusNode = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();

  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _lastNameFocusNode = FocusNode();

  final TextEditingController _relationshipController = TextEditingController();
  final FocusNode _relationshipFocusNode = FocusNode();
  int? _relationshipIndex;
  List<String> relationshipItems = [
    "FAMILY_FRIEND",
    "OWN_ACCOUNT",
    "MERCHANT",
    "NO_RELATIONSHIP",
  ];

  final TextEditingController _purposeOfTransferController =
      TextEditingController();
  final FocusNode _purposeOfTransferFocusNode = FocusNode();
  int? purposeOfTransferIndex;
  List<String> purposeOfTransferItems = [
    "FAMILY_FRIEND_SUPPORT",
    "PROPERTY_PAYMENT",
    "PAYMENT_SERVICE",
    "STUDENT_SUPPORT",
    "SELF"
  ];

  Country? selectedCountry;
  MobileNetwork? selectedNetwork;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add new recipient'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: const [
            HelpIconButton(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomElevatedButtonAsync(
            disabledColor: AppColor.kAccentColor2,
            color: AppColor.kGoldColor2,
            height: 40,
            child: Text('ADD', style: Theme.of(context).textTheme.bodyLarge),
            onPressed: (_formKey.currentState?.validate() ?? false)
                ? () async {
                    final AuthenticationService _auth =
                        sl<AuthenticationService>();
                    final MobileRecipientVM _mobileRecipientVM =
                        sl<MobileRecipientVM>();

                    MobileRecipient mobileRecipient = MobileRecipient(
                        payeeId: '',
                        payerId: _auth.user!.id,
                        mobileNetwork: selectedNetwork!.id,
                        country: selectedCountry!.iso2,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        sendingReason:
                            purposeOfTransferItems[purposeOfTransferIndex ?? 0],
                        relationshipWithReciever:
                            relationshipItems[_relationshipIndex ?? 0],
                        mobileNumber: selectedCountry!.phoneCode +
                            _mobileNumberController.text);
                    await _mobileRecipientVM.addMobileRecipient(
                        context, mobileRecipient);
                  }
                : null,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: Column(
                    children: [
                      CustomTextField(
                        setState: setState,
                        focusNode: _countryFocusNode,
                        hintText: 'Country',
                        controller: _countryController,
                        readOnly: true,
                        onTap: () {
                          _showCountryPicker(
                              selectedCountry: selectedCountry,
                              onTap: (c) {
                                setState(() {
                                  selectedCountry = c;
                                  _countryController.text =
                                      selectedCountry!.name;
                                });
                              });
                        },
                        prefix: selectedCountry != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Gap(20),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundImage: AssetImage(
                                      'icons/flags/png/${selectedCountry?.iso2.toLowerCase()}.png',
                                      package: 'country_icons',
                                    ),
                                  ),
                                  const Gap(4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColor.kSecondaryColor,
                                    size: 16,
                                  ),
                                  const Gap(8),
                                ],
                              )
                            : null,
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Country can't be empty";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: _mobileNetworkController,
                        hintText: 'Mobile Network',
                        focusNode: _mobileNetworkFocusNode,
                        setState: setState,
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Mobile network can't be empty";
                          }
                          return null;
                        },
                        suffix: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColor.kSecondaryColor,
                          size: 16,
                        ),
                        readOnly: true,
                        onTap: () {
                          _showMobileNetworkPicker(
                              selectedNetwork: selectedNetwork,
                              onTap: (network) {
                                setState(() {
                                  selectedNetwork = network;
                                  _mobileNetworkController.text =
                                      selectedNetwork!.networkName;
                                });
                              });
                        },
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        setState: setState,
                        controller: _mobileNumberController,
                        hintText: 'Mobile Number',
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Mobile number can't be empty";
                          }
                          return null;
                        },
                        focusNode: _mobileNumberFocusNode,
                        prefix: selectedCountry != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Gap(20),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundImage: AssetImage(
                                      'icons/flags/png/${selectedCountry?.iso2.toLowerCase()}.png',
                                      package: 'country_icons',
                                    ),
                                  ),
                                  const Gap(4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColor.kSecondaryColor,
                                    size: 16,
                                  ),
                                  const Gap(8),
                                ],
                              )
                            : null,
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: _firstNameController,
                        hintText: 'First Name',
                        focusNode: _firstNameFocusNode,
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "First name can't be empty";
                          }
                          return null;
                        },
                        setState: setState,
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: _lastNameController,
                        hintText: 'Last Name',
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Last name can't be empty";
                          }
                          return null;
                        },
                        focusNode: _lastNameFocusNode,
                        setState: setState,
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: _relationshipController,
                        hintText: 'Relationship',
                        focusNode: _relationshipFocusNode,
                        setState: setState,
                        suffix: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColor.kSecondaryColor,
                          size: 16,
                        ),
                        readOnly: true,
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Relationship can't be empty";
                          }
                          return null;
                        },
                        onTap: () {
                          _showDropDownOptions("Relationship",
                              _relationshipIndex, relationshipItems, (value) {
                            setState(() {
                              _relationshipIndex = value;
                              _relationshipController.text =
                                  Essentials.capitalize(relationshipItems[value]
                                      .split('_')
                                      .join(' ')
                                      .toLowerCase());
                            });
                          });
                        },
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: _purposeOfTransferController,
                        hintText: 'Purpose of transfer',
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Purpose can't be empty";
                          }
                          return null;
                        },
                        focusNode: _purposeOfTransferFocusNode,
                        setState: setState,
                        suffix: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColor.kSecondaryColor,
                          size: 16,
                        ),
                        readOnly: true,
                        onTap: () {
                          _showDropDownOptions(
                              "Purpose of transfer",
                              purposeOfTransferIndex,
                              purposeOfTransferItems, (value) {
                            setState(() {
                              purposeOfTransferIndex = value;
                              _purposeOfTransferController.text =
                                  Essentials.capitalize(
                                      purposeOfTransferItems[value]
                                          .split('_')
                                          .join(' ')
                                          .toLowerCase());
                            });
                          });
                        },
                        keyboardType: TextInputType.text,
                      ),
                      const Gap(32),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> _showDropDownOptions(String heading, int? initialChecked,
      List<String> items, ValueSetter<int> onChanged) async {
    final index = await showCustomScrollableSheet(
        context: context,
        child: DropDownOptions(
          heading: heading,
          initialChecked: initialChecked,
          items: items
              .map((e) =>
                  Essentials.capitalize(e.split('_').join(' ').toLowerCase()))
              .toList(),
        ));
    if (index != null) {
      onChanged(index as int);
    }
  }

  Future<void> _showMobileNetworkPicker(
      {required MobileNetwork? selectedNetwork,
      required Function(MobileNetwork network) onTap}) async {
    await showCustomScrollableSheet(
        context: context,
        child: MobileNetworkListWidget(
          selectedMobileNetwork: selectedNetwork,
          onTap: onTap,
        ));
  }

  Future<void> _showCountryPicker(
      {required Country? selectedCountry,
      required Function(Country country) onTap}) async {
    await showCustomScrollableSheet(
      context: context,
      child: CountryListWidget(
        selectedCountry: selectedCountry,
        allowedCountries: widget.mmtCountries?.map((e) => e.iso2).toList(),
        onTap: onTap,
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.hintText,
      this.helperText,
      this.keyboardType,
      this.validator,
      this.bottomSpacing = 12,
      this.onTap,
      this.readOnly,
      this.maxLines,
      this.textInputAction = TextInputAction.next,
      this.suffix,
      required this.setState,
      this.prefix})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final double bottomSpacing;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final Widget? prefix;
  final Function(Function()) setState;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController get controller => widget.controller;

  FocusNode get focusNode => widget.focusNode;

  String get hintText => widget.hintText;

  String? get helperText => widget.helperText;

  TextInputType? get keyboardType => widget.keyboardType;

  String? Function(String?)? get validator => widget.validator;

  Widget? get suffix => widget.suffix;

  Widget? get prefix => widget.prefix;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpacing),
      child: TextFormField(
        controller: controller,
        textInputAction: widget.textInputAction,
        onTap: widget.onTap,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines,
        decoration: TextFieldDecoration(
          focusNode: focusNode,
          hintText: hintText,
          suffix: suffix,
          prefix: prefix,
          context: context,
          helperMaxLines: 2,
          helperTextStyle: textTheme.bodyMedium
              ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
          helperText: helperText,
          controller: controller,
        ).inputDecoration(),
        focusNode: focusNode,
        onChanged: (val) {
          if (val.length <= 1) {
            widget.setState(() {});
          }
        },
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
