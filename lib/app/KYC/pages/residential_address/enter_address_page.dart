import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/view_models.dart/address_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:geocoding/geocoding.dart';

import 'confirm_address_page.dart';

class EnterAddressPage extends StatefulWidget {
  const EnterAddressPage({Key? key, this.address}) : super(key: key);

  final Placemark? address;

  static Future<void> show(BuildContext context, {Placemark? address}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EnterAddressPage(
          address: address,
        ),
      ),
    );
  }

  @override
  State<EnterAddressPage> createState() => _EnterAddressPageState();
}

class _EnterAddressPageState extends State<EnterAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final _postCodeController = TextEditingController();
  final _postCodeFocus = FocusNode();

  final _stateController = TextEditingController();
  final _stateFocus = FocusNode();

  final _cityController = TextEditingController();
  final _cityFocus = FocusNode();

  final _streetController = TextEditingController();
  final _streetFocus = FocusNode();

  final _houseNumberController = TextEditingController();
  final _houseNumberFocus = FocusNode();

  final _apartmentNumber = TextEditingController();
  final _apartmentFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<AddressViewModel>(
      onModelReady: (p0) {
        if (p0.country == null) {
          p0.searchCountry(
            context,
          );
        }
        if (widget.address != null) {
          _cityController.text = widget.address?.locality ?? '';
          _streetController.text = widget.address?.name ?? '';
          _postCodeController.text = widget.address?.postalCode ?? '';
          _stateController.text = widget.address?.administrativeArea ?? '';
        }
        {
          p0.init(context);
        }
      },
      builder: (context, model, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: WidgetsUtil.onBoardingAppBar(
            context,
            title: 'Residential address',
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
              padding: const EdgeInsets.all(24),
              child: ContinueButton(
                context: context,
                disabledColor: AppColor.kAccentColor2,
                color: AppColor.kGoldColor2,
                textColor: Colors.black,
                disable: model.disableButton(),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.setAddress();
                    ConfirmHomeAddreePage.show(context);
                  }
                },
              )),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        //Country picker
                        PickerContainer(
                          radius: 9,
                          hint: 'Country',
                          borderColor: AppColor.kSecondaryColor,
                          country: model.country,
                          onPressed: () async {
                            // _showCountryPicker(
                            //     selectedCountry: model.country,
                            //     onTap: (country) {
                            //       model.setCountry = country;
                            //     });
                          },
                        ),
                        const Gap(15),

                        //Postal Code TextField
                        TextFormField(
                          controller: _postCodeController,
                          style: textTheme.bodyText2,
                          decoration: TextFieldDecoration(
                            focusNode: _postCodeFocus,
                            context: context,
                            hintText: 'Postal code',
                            onClearTap: () {
                              setState(() {
                                _postCodeController.clear();
                              });
                              _postCodeFocus.requestFocus();
                            },
                            controller: _postCodeController,
                          ).inputDecoration(),
                          focusNode: _postCodeFocus,
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              model.setPostalCode = val;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Postal code can't be empty";
                            } else if (RegExp(r'[a-z]').hasMatch(val)) {
                              return "Postal code can't have lower letters";
                            }
                            return null;
                          },
                        ),
                        const Gap(15),

                        //State TextField
                        TextFormField(
                          style: textTheme.bodyText2,
                          controller: _stateController,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp(r'[a-z A-Z]'), allow: true),
                          ],
                          decoration: TextFieldDecoration(
                            focusNode: _stateFocus,
                            context: context,
                            hintText: 'Country or State',
                            onClearTap: () {
                              setState(() {
                                _stateController.clear();
                              });
                              _stateFocus.requestFocus();
                            },
                            controller: _stateController,
                          ).inputDecoration(),
                          focusNode: _stateFocus,
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                            setState(() {});
                            if (val.isNotEmpty) {
                              model.setState = val;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "State or county can't be empty";
                            } else if (val.length < 3) {
                              return "Please enter a valid state or county";
                            }
                            return null;
                          },
                        ),
                        const Gap(15),

                        //City TextField
                        TextFormField(
                          style: textTheme.bodyText2,
                          controller: _cityController,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp(r'[a-z A-Z]'), allow: true),
                          ],
                          decoration: TextFieldDecoration(
                            focusNode: _cityFocus,
                            context: context,
                            hintText: 'City',
                            onClearTap: () {
                              setState(() {
                                _cityController.clear();
                              });
                              _cityFocus.requestFocus();
                            },
                            controller: _cityController,
                          ).inputDecoration(),
                          focusNode: _cityFocus,
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                            setState(() {});
                            if (val.isNotEmpty) {
                              model.setCity = val;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "City can't be empty";
                            } else if (val.length < 3) {
                              return "Please enter a valid city";
                            }
                            return null;
                          },
                        ),
                        const Gap(15),

                        //Street TextField
                        TextFormField(
                          controller: _streetController,
                          style: textTheme.bodyText2,
                          decoration: TextFieldDecoration(
                            focusNode: _streetFocus,
                            context: context,
                            hintText: 'Street',
                            onClearTap: () {
                              setState(() {
                                _streetController.clear();
                              });
                              _streetFocus.requestFocus();
                            },
                            controller: _streetController,
                          ).inputDecoration(),
                          focusNode: _streetFocus,
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              model.setStreet = val;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Street can't be empty";
                            }
                            return null;
                          },
                        ),
                        const Gap(15),

                        //House number TextField
                        TextFormField(
                          controller: _houseNumberController,
                          style: textTheme.bodyText2,
                          decoration: TextFieldDecoration(
                            focusNode: _houseNumberFocus,
                            context: context,
                            hintText: 'House number',
                            onClearTap: () {
                              setState(() {
                                _houseNumberController.clear();
                              });
                              _houseNumberFocus.requestFocus();
                            },
                            controller: _houseNumberController,
                          ).inputDecoration(),
                          focusNode: _houseNumberFocus,
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              model.setHouseNo = val;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "House number can't be empty";
                            }
                            return null;
                          },
                        ),
                        const Gap(15),

                        //Apartment TextField
                        TextFormField(
                          controller: _apartmentNumber,
                          style: textTheme.bodyText2,
                          decoration: TextFieldDecoration(
                            focusNode: _apartmentFocus,
                            context: context,
                            hintText: 'Apartment number (optional)',
                            onClearTap: () {
                              setState(() {
                                _apartmentNumber.clear();
                              });
                              _apartmentFocus.requestFocus();
                            },
                            controller: _apartmentNumber,
                          ).inputDecoration(),
                          focusNode: _apartmentFocus,
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              model.setAptNo = val;
                            } else {
                              model.setAptNo = '';
                            }
                          },
                        ),
                        const Gap(400)
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }

  Future<void> _showCountryPicker({required Country? selectedCountry, required Function(Country country) onTap}) async {
    await showCustomScrollableSheet(
        context: context,
        child: CountryListWidget(
          selectedCountry: selectedCountry,
          onTap: onTap,
        ));
  }
}
