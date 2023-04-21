import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/select_document.dart';
import 'package:geniuspay/app/auth/pages/sign_up/mobile_number/mobile_number_page.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/currency_selection_bottomsheet.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/information_tile.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class PersonalProfilePage extends StatefulWidget {
  final User user;
  const PersonalProfilePage({Key? key, required this.user}) : super(key: key);
  static Future<void> show(BuildContext context, User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PersonalProfilePage(user: user),
      ),
    );
  }

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  void getCountryName() async {
    final SelectCountryViewModel _selectCountryViewModel =
        sl<SelectCountryViewModel>();
    if (_selectCountryViewModel.countries.isEmpty) {
      await _selectCountryViewModel.getCountries(context);
    }
    if (widget.user.userProfile.countryIso2!.isNotEmpty) {
      final residence = await _selectCountryViewModel.getCountryFromIso(
          context, widget.user.userProfile.countryIso2!);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          residenceCountry = residence.name;
        });
      });
    }
  }

  @override
  void initState() {
    residenceCountry = widget.user.userProfile.countryIso2!;
    user = widget.user;
    getCountryName();
    super.initState();
  }

  String fullAddress() {
    String address = '';
    final userAddress = widget.user.userProfile.addresses;
    if (userAddress == null) {
      return '';
    }
    if (userAddress.addressLine1.isNotEmpty) {
      address += "${userAddress.addressLine1}, ";
    }
    if (userAddress.addressLine2.isNotEmpty) {
      address += "${userAddress.addressLine2}, ";
    }
    if (userAddress.city.isNotEmpty) {
      address += "${userAddress.city}, ";
    }
    if (userAddress.state.isNotEmpty) {
      address += "${userAddress.state}, ";
    }
    if (userAddress.zipCode.isNotEmpty) {
      address += "${userAddress.zipCode}, ";
    }
    address += residenceCountry;
    return address;
  }

  Future<void> uploadDocument(String base64) async {
    final AuthenticationService _authenticationService =
        sl<AuthenticationService>();
    final result = await _authenticationService.uploadAddressProof(
        _authenticationService.user!.id, 'bank_statement', base64);
    result.fold(
        (l) => PopupDialogs(context).errorMessage('Unable to upload document'),
        (r) {
      HomeWidget.show(context,
          resetUser: true, showSuccessDialog: 'Successfully uploaded document');
    });
  }

  late String residenceCountry;
  late User user;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile Information'),
          actions: const [HelpIconButton()]),
      body: ListView(
        padding: const EdgeInsets.all(23.0),
        children: [
          // const ProfileHeaderWidget(),
          // const Gap(30),
          // if (user.userProfile.verificationStatus ==
          //     VerificationStatus.verified) ...[
          //   ElevatedCardBackground(
          //       child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Quick add documents',
          //         style:
          //             textTheme.bodyText1?.copyWith(color: AppColor.kGreyColor),
          //       ),
          //       const Gap(16),
          //       InkWell(
          //           onTap: () {
          //             showCustomScrollableSheet(
          //                 context: context,
          //                 child: Padding(
          //                     padding: const EdgeInsets.all(24),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisSize: MainAxisSize.min,
          //                       children: [
          //                         Text(
          //                           'Select method',
          //                           style: textTheme.headline3?.copyWith(
          //                               color: AppColor.kSecondaryColor),
          //                         ),
          //                         const Gap(32),
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             InkWell(
          //                                 borderRadius:
          //                                     BorderRadius.circular(12),
          //                                 onTap: () async {
          //                                   final result = await ImagePicker()
          //                                       .pickImage(
          //                                           source: ImageSource.camera);
          //                                   if (result != null) {
          //                                     Navigator.pop(context);
          //                                     final bytes =
          //                                         await result.readAsBytes();
          //                                     String img64 =
          //                                         base64Encode(bytes);
          //                                     uploadDocument(img64);
          //                                   }
          //                                 },
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   width: 120,
          //                                   height: 120,
          //                                   padding: const EdgeInsets.all(10),
          //                                   decoration: BoxDecoration(
          //                                       color: AppColor.kAccentColor2,
          //                                       borderRadius:
          //                                           BorderRadius.circular(12)),
          //                                   child: Column(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       children: const [
          //                                         Icon(
          //                                           CupertinoIcons.photo_camera,
          //                                           size: 32,
          //                                         ),
          //                                         Gap(8),
          //                                         Text('Camera')
          //                                       ]),
          //                                 )),
          //                             const Gap(16),
          //                             InkWell(
          //                                 borderRadius:
          //                                     BorderRadius.circular(12),
          //                                 onTap: () async {
          //                                   final result = await ImagePicker()
          //                                       .pickImage(
          //                                           source:
          //                                               ImageSource.gallery);
          //                                   if (result != null) {
          //                                     Navigator.pop(context);
          //                                     final bytes =
          //                                         await result.readAsBytes();
          //                                     String img64 =
          //                                         base64Encode(bytes);
          //                                     uploadDocument(img64);
          //                                   }
          //                                 },
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   width: 120,
          //                                   height: 120,
          //                                   padding: const EdgeInsets.all(10),
          //                                   decoration: BoxDecoration(
          //                                       color: AppColor.kAccentColor2,
          //                                       borderRadius:
          //                                           BorderRadius.circular(12)),
          //                                   child: Column(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       children: const [
          //                                         Icon(
          //                                           CupertinoIcons.photo_fill,
          //                                           size: 32,
          //                                         ),
          //                                         Gap(8),
          //                                         Text('Gallery')
          //                                       ]),
          //                                 ))
          //                           ],
          //                         ),
          //                         const Gap(32),
          //                       ],
          //                     )));
          //           },
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: 8),
          //             decoration: BoxDecoration(
          //                 color: AppColor.kAccentColor2,
          //                 borderRadius: BorderRadius.circular(16),
          //                 border: Border.all(color: AppColor.kSecondaryColor)),
          //             child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   const Icon(
          //                     Ionicons.scan,
          //                     color: AppColor.kSecondaryColor,
          //                   ),
          //                   const Gap(8),
          //                   Text(
          //                     'Add document by scan',
          //                     style: textTheme.subtitle1
          //                         ?.copyWith(color: AppColor.kSecondaryColor),
          //                   ),
          //                 ]),
          //           )),
          //       const Gap(12),
          //       Text(
          //         "You can quickly fill out your data by scanning your ID or passport that are required for verification.",
          //         style: textTheme.subtitle2
          //             ?.copyWith(fontSize: 10, color: AppColor.kGreyColor),
          //       )
          //     ],
          //   )),
          //   const Gap(16),
          // ],
          ElevatedCardBackground(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basic Information',
                style:
                    textTheme.bodyText1?.copyWith(color: AppColor.kGreyColor),
              ),
              const Gap(8),
              InformationTile(
                leadingTitle: 'Customer ID',
                trailingText: user.userProfile.customerNumber,
              ),
              InformationTile(
                leadingTitle: 'Joined date',
                trailingText: Converter().getDateFromString(user.dateJoined),
              ),
              InformationTile(
                leadingTitle: 'Country of residence',
                trailingText: residenceCountry,
              ),
              // if ("${user.firstName} ${user.lastName}".trim().isNotEmpty)
              //   InformationTile(
              //     leadingTitle: 'Legal names',
              //     trailingText: "${user.firstName} ${user.lastName}",
              //   ),
              if (user.userProfile.birthDate!.isNotEmpty)
                InformationTile(
                  leadingTitle: 'Date of birth',
                  trailingText: user.userProfile.birthDate,
                ),
              if (fullAddress().isNotEmpty)
                InformationTile(
                  leadingTitle: 'Address',
                  trailingText: fullAddress(),
                ),
            ],
          )),
          const Gap(16),
          ElevatedCardBackground(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  'Contact Information',
                  style:
                      textTheme.bodyText1?.copyWith(color: AppColor.kGreyColor),
                ),
                const Gap(8),
                InformationTile(
                  leadingTitle: 'Phone number',
                  trailingText: "${user.userProfile.mobileNumber?.number}",
                  trailingWidget: user.userProfile.mobileNumber == null
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(60),
                              radius: 60,
                              onTap: () async {
                                final SelectCountryViewModel
                                    _selectCountryViewModel =
                                    sl<SelectCountryViewModel>();
                                if (_selectCountryViewModel.countries.isEmpty) {
                                  await _selectCountryViewModel
                                      .getCountries(context);
                                }
                                final country = await _selectCountryViewModel
                                    .getCountryFromIso(context,
                                        widget.user.userProfile.countryIso2!);
                                MobileNumberVerification.show(
                                    context, country, true);
                              },
                              child: const Icon(
                                Icons.add_circle_outline,
                                size: 18,
                                color: AppColor.kSecondaryColor,
                              )))
                      : null,
                ),
                InformationTile(
                  leadingTitle: 'Email',
                  trailingText: user.email,
                ),
              ])),
          const Gap(16),
          ElevatedCardBackground(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  'My Documents',
                  style:
                      textTheme.bodyText1?.copyWith(color: AppColor.kGreyColor),
                ),
                const Gap(8),
                InformationTile(
                    leadingTitle: 'Identity documents',
                    subtitle: "Verified",
                    onTap: () {
                      SelectDocumentPage.show(context,
                          isResubmittingDocuments: true);
                    },
                    leadingAsset: "assets/icons/passport-2.svg",
                    trailingWidget: SvgPicture.asset('assets/icons/arrow.svg')),
                const InformationTile(
                    leadingTitle: 'Questionnaire',
                    subtitle: "Completed",
                    trailingText: "",
                    leadingAsset: "assets/icons/audit.svg"),
              ])),
          const Gap(16),
          ElevatedCardBackground(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Gap(8),
                InformationTile(
                  leadingTitle: 'Language',
                  trailingWidget: GestureDetector(
                    onTap: () {
                      // PopupDialogs(context).comingSoonSnack();
                      // showModalBottomSheet(
                      //     isScrollControlled: true,
                      //     isDismissible: false,
                      //     context: context,
                      //     builder: (context) {
                      //       return SizedBox(
                      //           height: MediaQuery.of(context).size.height * .90,
                      //           child: const ChooseLanguagePage());
                      //     });
                    },
                    child: Text(
                      user.userProfile.language!.toUpperCase(),
                      textAlign: TextAlign.right,
                      style: textTheme.bodyText2
                          ?.copyWith(fontSize: 12, color: AppColor.kGreyColor),
                    ),
                  ),
                ),
                InformationTile(
                  leadingTitle: 'Default currency',
                  trailingWidget: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: false,
                            context: context,
                            builder: (cntxt) {
                              return CurrencySelectionBottomSheet(
                                onAllCurrencySelected: (currency) async {
                                  Navigator.pop(cntxt);
                                  final AuthenticationService _auth =
                                      sl<AuthenticationService>();
                                  await _auth.updateUserCurrency(
                                      currency.code, _auth.user!.id);
                                  await _auth.getUser();
                                  user = _auth.user!;
                                  setState(() {});
                                  PopupDialogs(context).successMessage(
                                      "Currency changed to ${currency.code}");
                                },
                              );
                            });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            user.userProfile.defaultCurrency!,
                            textAlign: TextAlign.right,
                            style: textTheme.bodyText2?.copyWith(
                                fontSize: 12, color: AppColor.kGreyColor),
                          ),
                          const Gap(4),
                          const Icon(
                            Icons.edit,
                            color: AppColor.kSecondaryColor,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
          const Gap(24),
        ],
      ),
    );
  }
}
