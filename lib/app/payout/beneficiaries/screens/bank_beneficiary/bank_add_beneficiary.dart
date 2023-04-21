import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/currency_exchange/widgets/exchange_flag_button.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/bank_recipient_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_tab_indicator.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';

class BankAddBeneficiaryPage extends StatefulWidget {
  final BankRecipientVM viewModel;
  final bool isSomeoneElse;
  final Function(BankBeneficiary?) onselected;
  final bool isEuropean;
  const BankAddBeneficiaryPage(
      {Key? key,
      required this.viewModel,
      required this.onselected,
      required this.isEuropean,
      this.isSomeoneElse = false})
      : super(key: key);
  static Future<void> show(BuildContext context, BankRecipientVM viewModel,
      Function(BankBeneficiary?) onselected, bool isEuropean,
      {bool isSomeoneElse = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => BankAddBeneficiaryPage(
                viewModel: viewModel,
                onselected: onselected,
                isEuropean: isEuropean,
                isSomeoneElse: isSomeoneElse,
              )),
    );
  }

  @override
  State<BankAddBeneficiaryPage> createState() => _BankAddBeneficiaryPageState();
}

class _BankAddBeneficiaryPageState extends State<BankAddBeneficiaryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    getCountry();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.index =
        widget.viewModel.bankBeneficiary.ownedByUser || widget.isSomeoneElse
            ? 0
            : 1;
    if (widget.viewModel.bankBeneficiary.ownedByUser) {
      final AuthenticationService _auth = sl<AuthenticationService>();
      firstNameController.text = _auth.user?.firstName ?? "";
      lastNameController.text = _auth.user?.lastName ?? "";
    }
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final firstNameController = TextEditingController();
  final firstNameFocus = FocusNode();

  final lastNameController = TextEditingController();
  final lastNameFocus = FocusNode();

  final nickNameController = TextEditingController();
  final nickNameFocus = FocusNode();

  final companyNameController = TextEditingController();
  final companyNameFocus = FocusNode();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final Converter _walletHelper = Converter();
  Country? selectedCountry;

  getCountry() async {
    final SelectCountryViewModel _selectCountryViewModel =
        sl<SelectCountryViewModel>();
    final AuthenticationService _authenticationService =
        sl<AuthenticationService>();
    if (_authenticationService.user!.userProfile.countryIso2!.isNotEmpty) {
      final result = await _selectCountryViewModel.getCountryFromIso(
          context, _authenticationService.user!.userProfile.countryIso2!);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!widget.isEuropean ||
            widget.viewModel.sepaCurrencies.contains(result.currencyISO)) {
          setState(() {
            selectedCountry = result;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new recipient"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: const [
          HelpIconButton(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButtonAsync(
              color: AppColor.kGoldColor2,
              child: Text(
                'CONTINUE',
                style: textTheme.bodyText1,
              ),
              onPressed: (_tabController.index == 0
                          ? ((_formKey1.currentState?.validate() ?? false) &&
                              firstNameController.text.isNotEmpty &&
                              lastNameController.text.isNotEmpty)
                          : (_formKey2.currentState?.validate() ?? false) &&
                              companyNameController.text.isNotEmpty) &&
                      selectedCountry != null
                  ? () async {
                      if (_tabController.index == 0) {
                        widget.viewModel.setIndividual(firstNameController.text,
                            lastNameController.text, nickNameController.text);
                      } else {
                        widget.viewModel.setCompany(companyNameController.text,
                            nickNameController.text);
                      }
                      await widget.viewModel.fetchBankBeneficiaryRequirements(
                          context,
                          selectedCountry!,
                          _tabController.index == 0
                              ? BankRecipientType.individual
                              : BankRecipientType.company,
                          widget.viewModel,
                          widget.onselected);
                    }
                  : null)),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Container(
                height: 38,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    border:
                        Border.all(color: AppColor.kSecondaryColor, width: 2)),
                child: TabBar(
                  labelColor: Colors.white,
                  controller: _tabController,
                  unselectedLabelColor: AppColor.kSecondaryColor,
                  indicator: WalletTabIndicator(),
                  tabs: const [
                    Tab(
                      text: "Individual",
                    ),
                    Tab(
                      text: "Company",
                    ),
                  ],
                )),
            const Gap(24),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                Form(
                    key: _formKey1,
                    child: ListView(
                      children: [
                        Text(
                          'Beneficiary Details',
                          style: textTheme.subtitle1?.copyWith(fontSize: 14),
                        ),
                        const Gap(8),
                        PickerContainer(
                          hint: 'Currency',
                          country: selectedCountry,
                          onPressed: () async {
                            showCurrenciesDropDown();
                          },
                        ),
                        const Gap(8),
                        TextFormField(
                          controller: firstNameController,
                          readOnly:
                              widget.viewModel.bankBeneficiary.ownedByUser,
                          decoration: TextFieldDecoration(
                            focusNode: firstNameFocus,
                            hintText: 'First Name',
                            context: context,
                            removeClear: !widget.isSomeoneElse,
                            onClearTap: () {
                              setState(() {
                                firstNameController.clear();
                              });
                              firstNameFocus.requestFocus();
                            },
                            controller: firstNameController,
                          ).inputDecoration(),
                          focusNode: firstNameFocus,
                          onChanged: (val) {
                            setState(() {});
                          },
                          maxLength: 20,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (val != null &&
                                val.isNotEmpty &&
                                val.length < 2) {
                              return "Minimum 2 characters required";
                            }
                            return null;
                          },
                        ),
                        const Gap(8),
                        TextFormField(
                          controller: lastNameController,
                          maxLength: 20,
                          readOnly:
                              widget.viewModel.bankBeneficiary.ownedByUser,
                          decoration: TextFieldDecoration(
                            focusNode: lastNameFocus,
                            hintText: 'Last Name',
                            context: context,
                            removeClear: !widget.isSomeoneElse,
                            onClearTap: () {
                              setState(() {
                                lastNameController.clear();
                              });
                              lastNameFocus.requestFocus();
                            },
                            controller: lastNameController,
                          ).inputDecoration(),
                          focusNode: lastNameFocus,
                          onChanged: (val) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            // if (val == null || val.isEmpty) {
                            //   return "Last Name can't be empty";
                            // }
                            return null;
                          },
                        ),
                        const Gap(8),
                        TextFormField(
                          controller: nickNameController,
                          maxLength: 20,
                          validator: (val) {
                            if (val != null && val.isNotEmpty) {
                              if (val.length > 20) {
                                return "nickname should not be greater than 20 characters";
                              }
                            }
                            return null;
                          },
                          decoration: TextFieldDecoration(
                            focusNode: nickNameFocus,
                            hintText: 'Account nickname (Optional)',
                            context: context,
                            onClearTap: () {
                              setState(() {
                                nickNameController.clear();
                              });
                              nickNameFocus.requestFocus();
                            },
                            controller: nickNameController,
                          ).inputDecoration(),
                          onChanged: (val) {
                            setState(() {});
                          },
                          focusNode: nickNameFocus,
                          keyboardType: TextInputType.name,
                        ),
                        const Gap(120)
                      ],
                    )),
                Form(
                    key: _formKey2,
                    child: ListView(
                      children: [
                        Text(
                          'Beneficiary Details',
                          style: textTheme.subtitle1?.copyWith(fontSize: 14),
                        ),
                        const Gap(8),
                        PickerContainer(
                          hint: 'Currency',
                          country: selectedCountry,
                          onPressed: () async {
                            showCurrenciesDropDown();
                          },
                        ),
                        const Gap(8),
                        TextFormField(
                          controller: companyNameController,
                          decoration: TextFieldDecoration(
                            focusNode: companyNameFocus,
                            hintText: 'Company Name',
                            context: context,
                            onClearTap: () {
                              setState(() {
                                companyNameController.clear();
                              });
                              companyNameFocus.requestFocus();
                            },
                            controller: companyNameController,
                          ).inputDecoration(),
                          focusNode: companyNameFocus,
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                            setState(() {});
                          },
                          validator: (val) {
                            if (val != null &&
                                val.isNotEmpty &&
                                val.length < 2) {
                              return "Minimum 2 characters required";
                            }
                            return null;
                          },
                        ),
                        const Gap(8),
                        TextFormField(
                          controller: nickNameController,
                          decoration: TextFieldDecoration(
                            focusNode: nickNameFocus,
                            hintText: 'Account nickname (Optional)',
                            context: context,
                            onClearTap: () {
                              setState(() {
                                nickNameController.clear();
                              });
                              nickNameFocus.requestFocus();
                            },
                            controller: nickNameController,
                          ).inputDecoration(),
                          focusNode: nickNameFocus,
                          onChanged: (val) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.name,
                        ),
                        const Gap(120)
                      ],
                    )),
              ],
            ))
          ])),
    );
  }

  void showCurrenciesDropDown() {
    final textTheme = Theme.of(context).textTheme;
    final _searchFocus = FocusNode();
    final _searchController = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BaseView<SelectCountryViewModel>(onModelReady: (p0) async {
          await p0.resetFoundCountries(context);
        }, builder: (context, model, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .90,
            child: Column(children: [
              const Gap(33),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close)),
                      const Spacer(),
                      Text('Select currency',
                          style: textTheme.headline1?.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      const Spacer(),
                    ],
                  )),
              const Gap(16),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                      height: 50,
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
                            size: 18,
                          ),
                          onClearTap: () {
                            _searchController.clear();
                            setState(() {
                              model.resetFoundCountries(context);
                            });
                          },
                          controller: _searchController,
                        ).inputDecoration(),
                        focusNode: _searchFocus,
                        keyboardType: TextInputType.name,
                        onTap: () {
                          setState(() {});
                        },
                        onSaved: (searchTerm) {
                          setState(() {});
                          if (_searchController.text.isNotEmpty) {
                            setState(() {
                              model.searchCountry(
                                  context: context, keyword: searchTerm!);
                            });
                          } else {
                            model.resetFoundCountries(context);
                          }
                        },
                        onChanged: (searchTerm) {
                          setState(() {});
                          if (_searchController.text.isNotEmpty) {
                            setState(() {
                              model.searchCountry(
                                  context: context, keyword: searchTerm);
                            });
                          } else {
                            model.resetFoundCountries(context);
                          }
                        },
                      ))),
              const Gap(16),
              Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38),
                      child: Text(
                        'CURRENCIES',
                        style: textTheme.bodyText1
                            ?.copyWith(fontSize: 12, letterSpacing: 1.2),
                      )),
                  const Gap(12),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ElevatedCardBackground(
                          padding: const EdgeInsets.all(4),
                          child: ListView.separated(
                              itemCount: model.foundCountries.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                final country = model.foundCountries[index];
                                if ((widget.isEuropean &&
                                    !widget.viewModel.sepaCurrencies
                                        .contains(country.currencyISO))) {
                                  return Container();
                                }
                                return const Gap(12);
                              },
                              itemBuilder: (context, index) {
                                if (model.baseModelState ==
                                    BaseModelState.success) {
                                  final country = model.foundCountries[index];
                                  if (country.currencyISO.isEmpty ||
                                      (widget.isEuropean &&
                                          !widget.viewModel.sepaCurrencies
                                              .contains(country.currencyISO))) {
                                    return Container();
                                  }
                                  return CurrencySelectorTile(
                                    title: country.name,
                                    iso2: country.iso2.toLowerCase(),
                                    currency: country.currencyISO,
                                    subtitle: country.currencyISO,
                                    onTap: () {
                                      setState(() {
                                        selectedCountry = country;
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }))),
                  const Gap(24),
                ],
              )),
            ]),
          );
        });
      },
    );
  }
}
