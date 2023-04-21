import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/currency_selection_bottomsheet.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/converter.dart';

import '../../../util/color_scheme.dart';

class ExchangeFlagButton extends StatefulWidget {
  const ExchangeFlagButton(
      {Key? key,
      required this.voidCallback,
      required this.defaultCurrencyWallet,
      required this.wallets,
      required this.showOtherCurrencies,
      required this.onCreateWallet})
      : super(key: key);
  final Function(Wallet) voidCallback;
  final Wallet defaultCurrencyWallet;
  final List<Wallet> wallets;
  final bool showOtherCurrencies;
  final Function(String) onCreateWallet;
  @override
  State<ExchangeFlagButton> createState() => _ExchangeFlagButtonState();
}

class _ExchangeFlagButtonState extends State<ExchangeFlagButton> {
  late Wallet _selectedWallet;
  final Converter _walletHelper = Converter();

  @override
  Widget build(BuildContext context) {
    _selectedWallet = widget.defaultCurrencyWallet;
    return Theme(
        data: ThemeData(
            splashColor: AppColor.kAccentColor2,
            highlightColor: AppColor.kAccentColor2),
        child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CurrencySelectionBottomSheet(
                      onAccountCurrencySelected: ((wallet) {
                        Navigator.pop(context);
                        setState(() {
                          _selectedWallet = wallet;
                        });
                        widget.voidCallback(wallet);
                      }),
                      canBuy: !widget.showOtherCurrencies,
                      canSell: widget.showOtherCurrencies,
                      onAllCurrencySelected: widget.showOtherCurrencies
                          ? (currency) {
                              Navigator.pop(context);
                              widget.onCreateWallet(currency.code);
                            }
                          : null,
                    );
                  });
            },
            borderRadius: BorderRadius.circular(60),
            child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: AppColor.kAccentColor2,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
                child: Row(children: [
                  CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage(
                          'icons/flags/png/${_walletHelper.getLocale(_selectedWallet.currency)}.png',
                          package: 'country_icons')),
                  const Gap(8),
                  Text(_selectedWallet.currency),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                  ),
                ]))));
  }
}

class CurrencySelectorTile extends StatelessWidget {
  final bool selected;
  final String currency;
  final String title;
  final String? subtitle;
  final String? trailing;
  final Function() onTap;
  final bool loading;
  final String? iso2;
  CurrencySelectorTile(
      {Key? key,
      this.selected = false,
      required this.title,
      required this.currency,
      this.subtitle,
      required this.onTap,
      this.loading = false,
      this.iso2,
      this.trailing})
      : super(key: key);
  final Converter _converter = Converter();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          onTap();
        },
        child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: loading
                    ? null
                    : selected
                        ? AppColor.kAccentColor2
                        : Colors.white),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'icons/flags/png/${iso2 ?? _converter.getLocale(currency)}.png',
                      package: 'country_icons'),
                  radius: 15,
                ),
                const Gap(14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    if (subtitle != null)
                      Text(subtitle!,
                          style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              fontSize: 12,
                              color: AppColor.kSecondaryColor)),
                  ],
                ),
                if (trailing != null) ...[
                  const Spacer(),
                  Text(trailing!,
                      style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColor.kSecondaryColor)),
                ]
              ],
            )));
  }
}
