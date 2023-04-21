import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/currency_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet_vm.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:shimmer/shimmer.dart';

class AddWalletName extends StatefulWidget {
  final CreateWalletViewModel model;
  const AddWalletName({Key? key, required this.model}) : super(key: key);

  @override
  State<AddWalletName> createState() => _AddWalletNameState();
}

class _AddWalletNameState extends State<AddWalletName> {
  final _walletNameController = TextEditingController();
  final _walletFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool setAsDefault = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.only(left: 4, right: 4),
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        Text(
                          'Choose a name',
                          style: textTheme.bodyLarge?.copyWith(fontSize: 16),
                        ),
                        const Spacer(),
                        const HelpIconButton()
                      ],
                    ),
                    const Gap(32),
                    Text(
                      'You can give your new Wallet a new name or we give it a default name.',
                      style: textTheme.bodyMedium?.copyWith(fontSize: 16),
                    ),
                    const Gap(32),
                    TextFormField(
                      controller: _walletNameController,
                      maxLength: 15,
                      decoration: TextFieldDecoration(
                        focusNode: _walletFocus,
                        context: context,
                        hintText: 'Friendly name',
                        onClearTap: () {
                          setState(() {
                            _walletNameController.clear();
                          });
                          _walletFocus.requestFocus();
                        },
                        controller: _walletNameController,
                      ).inputDecoration(),
                      autofocus: true,
                      focusNode: _walletFocus,
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        setState(() {});
                      },
                      validator: (val) {
                        if (val != null && val.length < 5) {
                          return 'Minimum 5 characters are needed';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 0,
                      leading: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        activeColor: AppColor.kSecondaryColor,
                        value: setAsDefault,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              setAsDefault = val;
                            });
                          }
                        },
                      ),
                      title: Text(
                        'Set as default Wallet',
                        style: textTheme.titleSmall
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      ),
                    ),
                    const Spacer(),
                    CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        onPressed: () async {
                          widget.model.setFriendlyName =
                              _walletNameController.text;
                          widget.model.setDefaultWallet = setAsDefault;
                          if (_walletNameController.text.isEmpty
                              ? true
                              : _formKey.currentState!.validate()) {
                            await widget.model.createWallet(context);
                          }
                        },
                        child:
                            Text('CREATE WALLET', style: textTheme.titleLarge)),
                    Gap(MediaQuery.of(context).viewInsets.bottom)
                  ],
                ))));
  }
}

class CountryListTileContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final String flag;
  final String currency;
  final String name;
  const CountryListTileContainer({
    Key? key,
    this.onPressed,
    required this.name,
    required this.flag,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            splashColor: AppColor.kAccentColor2,
            highlightColor: AppColor.kAccentColor2),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: onPressed,
          leading: CurrencyFlagContainer(flag: currency),
          title: Text(currency),
          subtitle: Text(name),
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(children: [
          const Gap(50),
          CustomTextField(
            height: 50,
            radius: 9,
            prefixIcon: SizedBox(
                width: 50,
                child: SvgPicture.asset(
                  'assets/images/search.svg',
                  color: AppColor.kGreyColor,
                )),
            fillColor: AppColor.kAccentColor2,
            keyboardType: TextInputType.emailAddress,
            label: 'Search',
            hint: 'Search',
          ),
          const Gap(25),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const CountryListTileContainer(
                name: 'United States Dollar',
                flag: '',
                currency: 'USD',
              );
            },
            itemCount: 4,
          )
        ]));
  }
}
