import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/bank_recipient_vm.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/bank_beneficiary_requirements.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:iban/iban.dart';

class BankAddAccountDetails extends StatefulWidget {
  final BankRecipientVM viewModel;
  final BankBeneficiaryRequirements requirements;
  final Function(BankBeneficiary?) onselected;
  const BankAddAccountDetails(
      {Key? key,
      required this.viewModel,
      required this.requirements,
      required this.onselected})
      : super(key: key);
  static Future<void> show(
      BuildContext context,
      BankRecipientVM viewModel,
      BankBeneficiaryRequirements requirements,
      Function(BankBeneficiary?) onselected) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => BankAddAccountDetails(
                viewModel: viewModel,
                requirements: requirements,
                onselected: onselected,
              )),
    );
  }

  @override
  State<BankAddAccountDetails> createState() => _BankAddAccountDetailsState();
}

class _BankAddAccountDetailsState extends State<BankAddAccountDetails> {
  BankRecipientVM get viewModel => widget.viewModel;
  BankBeneficiary get bankBeneficiary => widget.viewModel.bankBeneficiary;
  BankBeneficiaryRequirements get requirements => widget.requirements;
  final _formKey1 = GlobalKey<FormState>();
  bool isSEPA() {
    return viewModel.sepaCurrencies.contains(bankBeneficiary.currency);
  }

  Widget textField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      required String hintText,
      String? Function(String?)? validator,
      TextInputType textInputType = TextInputType.name,
      String? counterText,
      bool isIBan = false,
      int? maxLength}) {
    return TextFormField(
      controller: controller,
      decoration: TextFieldDecoration(
        focusNode: focusNode,
        hintText: hintText,
        context: context,
        onClearTap: () {
          setState(() {
            controller.clear();
          });
          focusNode.requestFocus();
        },
        controller: controller,
      ).inputDecoration().copyWith(counterText: null),
      maxLength: maxLength,
      buildCounter: counterText == null
          ? null
          : (context, {required currentLength, required isFocused, maxLength}) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  counterText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
      focusNode: focusNode,
      onChanged: (val) {
        _formKey1.currentState?.validate();
        setState(() {});
      },
      keyboardType: textInputType,
      validator: validator ??
          (val) {
            if (val == null || val.isEmpty) {
              return "$hintText can't be empty";
            }
            return null;
          },
    );
  }

// address
  final streetController = TextEditingController();
  final streetFocus = FocusNode();
  final cityController = TextEditingController();
  final cityFocus = FocusNode();
  final postCodeController = TextEditingController();
  final postFocus = FocusNode();
  final stateController = TextEditingController();
  final stateFocus = FocusNode();

//
  final ibanController = TextEditingController();
  final ibanFocus = FocusNode();
  final swiftController = TextEditingController();
  final swiftFocus = FocusNode();
  final accountNumberController = TextEditingController();
  final accountNumberFocus = FocusNode();
  final ifscController = TextEditingController();
  final ifscFocus = FocusNode();

  final cnapsController = TextEditingController();
  final cnapsFocus = FocusNode();
  final abaController = TextEditingController();
  final abaFocus = FocusNode();
  final bsbCodeController = TextEditingController();
  final bsbCodeFocus = FocusNode();
  final sortCodeController = TextEditingController();
  final sortCodeFocus = FocusNode();
  final clabeController = TextEditingController();
  final clabeFocus = FocusNode();
  final institutionController = TextEditingController();
  final institutionFocus = FocusNode();
  final branchCodeController = TextEditingController();
  final branchFocus = FocusNode();
  final bankCodeController = TextEditingController();
  final bankCodeFocus = FocusNode();

  String? getIdentifierValue() {
    if (requirements.sortCode != null) {
      return sortCodeController.text;
    } else if (requirements.bicSwift != null) {
      return swiftController.text;
    } else if (requirements.bsbCode != null) {
      return bsbCodeController.text;
    } else if (requirements.ifsc != null) {
      return ifscController.text;
    } else if (requirements.clabe != null) {
      return clabeController.text;
    } else if (requirements.branchCode != null) {
      return branchCodeController.text;
    } else if (requirements.bankCode != null) {
      return bankCodeController.text;
    } else if (requirements.institutionCode != null) {
      return institutionController.text;
    } else if (requirements.aba != null) {
      return abaController.text;
    } else {
      return null;
    }
  }

  Widget bankInfoWidget(String title, String? subtitle) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
              color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600),
        ),
        const Gap(8),
        Expanded(
            child: Text(
          subtitle ?? '',
          textAlign: TextAlign.right,
          style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountType = widget.viewModel.bankBeneficiary.beneficiaryType;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Account details"),
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
                style: textTheme.bodyLarge,
              ),
              onPressed: () async {
                if (_formKey1.currentState?.validate() == true) {
                  if (requirements.beneficiaryAddress != null) {
                    widget.viewModel.setAddress(
                        streetController.text,
                        cityController.text,
                        postCodeController.text,
                        stateController.text);
                  }
                  if (getIdentifierValue() != null) {
                    widget.viewModel
                        .setIdentifier(requirements, getIdentifierValue()!);
                  }

                  if (ibanController.text.isNotEmpty) {
                    widget.viewModel.setIban(ibanController.text);
                  }
                  if (accountNumberController.text.isNotEmpty) {
                    widget.viewModel
                        .setAccountNumber(accountNumberController.text);
                  }
                  if (ibanController.text.isNotEmpty && isSEPA()) {
                    final result = await widget.viewModel
                        .verifyIban(context, ibanController.text);
                    if (result != null && result.isValid) {
                      await confirmBank(result.toMap());
                    }
                  } else if (swiftController.text.isNotEmpty) {
                    final result = await widget.viewModel
                        .verifySwift(context, swiftController.text);
                    if (result != null) {
                      await confirmBank(result.toMap());
                    }
                  } else if (ifscController.text.isNotEmpty) {
                    final result = await widget.viewModel
                        .verifyIfsc(context, ifscController.text);
                    if (result != null) {
                      await confirmBank(result.toMap());
                    }
                  } else if (bsbCodeController.text.isNotEmpty) {
                    final result = await widget.viewModel
                        .verifyBsb(context, bsbCodeController.text);
                    if (result != null) {
                      await confirmBank(result.toMap());
                    }
                  } else {
                    await widget.viewModel
                        .addBankBeneficiary(context, widget.onselected);
                  }
                }
              })),
      body: Form(
          key: _formKey1,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Center(
                child: Column(children: [
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(children: [
                        CircleAvatar(
                          backgroundColor: AppColor.kAccentColor2,
                          radius: 30,
                          child: accountType == BankRecipientType.individual
                              ? Text(
                                  bankBeneficiary.beneficiaryFirstName![0] +
                                      bankBeneficiary.beneficiaryLastName![0],
                                  style: textTheme.bodyMedium?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              : const Icon(
                                  Icons.business,
                                  color: Colors.black,
                                ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: CountryFlagContainer(
                                size: 20,
                                flag: bankBeneficiary.bankCountryIso2))
                      ])),
                  const Gap(8),
                  Text(
                    accountType == BankRecipientType.individual
                        ? "${bankBeneficiary.beneficiaryFirstName} ${bankBeneficiary.beneficiaryLastName}"
                        : viewModel.bankBeneficiary.companyName ?? '',
                    style: textTheme.bodyMedium
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    bankBeneficiary.currency,
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: 16, color: AppColor.kSecondaryColor),
                  )
                ]),
              ),
              const Gap(32),
              if (requirements.beneficiaryAddress != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country: ${bankBeneficiary.beneficiaryCountry}',
                      style: textTheme.bodyLarge,
                    ),
                    const Gap(8),
                    textField(
                        controller: streetController,
                        focusNode: streetFocus,
                        hintText: 'Street address'),
                    const Gap(8),
                    Row(
                      children: [
                        Expanded(
                            child: textField(
                                controller: cityController,
                                focusNode: cityFocus,
                                hintText: 'City')),
                        const Gap(8),
                        Expanded(
                            child: textField(
                                controller: postCodeController,
                                focusNode: postFocus,
                                hintText: 'Postal Code')),
                      ],
                    ),
                    const Gap(8),
                    textField(
                        controller: stateController,
                        focusNode: stateFocus,
                        hintText: 'State'),
                    const Gap(24),
                  ],
                ),
              Text(
                'Bank Details',
                style: textTheme.bodyLarge,
              ),
              const Gap(8),
              if (requirements.iBan != null) ...[
                textField(
                  controller: ibanController,
                  focusNode: ibanFocus,
                  hintText: 'IBAN',
                  isIBan: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "IBAN can't be empty";
                    } else if (!isValid(val)) {
                      return 'Enter a valid IBAN number';
                    }
                    return null;
                  },
                ),
                const Gap(8),
              ],
              if (requirements.ifsc != null) ...[
                textField(
                    controller: ifscController,
                    focusNode: ifscFocus,
                    hintText: 'IFSC Code'),
                const Gap(8)
              ],
              if (requirements.bicSwift != null) ...[
                textField(
                    controller: swiftController,
                    focusNode: swiftFocus,
                    hintText: 'SWIFT'),
                const Gap(8)
              ],
              if (requirements.sortCode != null) ...[
                textField(
                    controller: sortCodeController,
                    focusNode: sortCodeFocus,
                    counterText:
                        'A sort code is a 6 digit number that identifies your bank',
                    hintText: 'Sort Code',
                    maxLength: 6,
                    textInputType: TextInputType.number),
                const Gap(8)
              ],
              if (requirements.bsbCode != null) ...[
                textField(
                    controller: bsbCodeController,
                    focusNode: bsbCodeFocus,
                    hintText: 'BSB Code'),
                const Gap(8)
              ],
              if (requirements.aba != null) ...[
                textField(
                    controller: abaController,
                    focusNode: abaFocus,
                    hintText: 'ABA'),
                const Gap(8)
              ],
              if (requirements.cnaps != null) ...[
                textField(
                    controller: cnapsController,
                    focusNode: cnapsFocus,
                    hintText: 'Cnaps'),
                const Gap(8)
              ],
              if (requirements.clabe != null) ...[
                textField(
                    controller: clabeController,
                    focusNode: clabeFocus,
                    hintText: 'Clabe'),
                const Gap(8)
              ],
              if (requirements.institutionCode != null) ...[
                textField(
                    controller: institutionController,
                    focusNode: institutionFocus,
                    hintText: 'Institution Code'),
                const Gap(8)
              ],
              if (requirements.branchCode != null) ...[
                textField(
                    controller: branchCodeController,
                    focusNode: branchFocus,
                    hintText: 'Branch Code'),
                const Gap(8)
              ],
              if (requirements.bankCode != null) ...[
                textField(
                    controller: bankCodeController,
                    focusNode: bankCodeFocus,
                    hintText: 'Bank Code'),
                const Gap(8)
              ],
              if (requirements.accountNumber != null) ...[
                textField(
                    controller: accountNumberController,
                    focusNode: accountNumberFocus,
                    textInputType: TextInputType.number,
                    hintText: 'Account number'),
                const Gap(8)
              ],
              Gap(MediaQuery.of(context).viewInsets.bottom)
              // const Gap(500)
            ],
          )),
    );
  }

  confirmBank(Map<String, String> bankInformationMap) async {
    final textTheme = Theme.of(context).textTheme;
    final confirmbank = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 20.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank Information',
                        style: textTheme.bodyMedium?.copyWith(
                            color: AppColor.kSecondaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                      const Gap(16),
                      const Divider(
                        color: AppColor.kSecondaryColor,
                        height: 6,
                      ),
                      const Gap(16),
                      for (String key in bankInformationMap.keys) ...[
                        bankInfoWidget(key, bankInformationMap[key]),
                        const Gap(8)
                      ],
                      const SizedBox(
                        height: 24,
                      ),
                      CustomYellowElevatedButton(
                        text: "CONFIRM",
                        onTap: () async {
                          Navigator.pop(context, true);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomYellowElevatedButton(
                          text: "CANCEL",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          transparentBackground: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (confirmbank) {
      await widget.viewModel.addBankBeneficiary(context, widget.onselected);
    }
  }
}
