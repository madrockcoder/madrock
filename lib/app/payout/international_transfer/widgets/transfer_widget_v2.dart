import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/view_models/main_currency_exchange_vm.dart';
import 'package:geniuspay/app/shared_widgets/currency_selection_bottomsheet.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class TransferWidgetV2 extends StatefulWidget {
  final CurrencyExchangeViewModel model;
  final TextEditingController controller1;
  final FocusNode focusNode1;
  final bool showError;
  final String errorText;

  final bool showSellingError;
  final String sellingErrorText;
  final double deliveryFee;

  const TransferWidgetV2(
      {Key? key,
      required this.model,
      required this.controller1,
      required this.focusNode1,
      required this.showError,
      required this.errorText,
      required this.deliveryFee,
      required this.showSellingError,
      required this.sellingErrorText})
      : super(key: key);

  @override
  State<TransferWidgetV2> createState() => _TransferWidgetV2State();
}

class _TransferWidgetV2State extends State<TransferWidgetV2> {
  final Converter _walletHelper = Converter();

  Widget _selectorWidget(String currency, Function() onPressed) {
    return InkWell(
        onTap: () {
          onPressed();
        },
        child: Row(
          children: [
            CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(
                    'icons/flags/png/${_walletHelper.getLocale(currency)}.png',
                    package: 'country_icons')),
            const Gap(8),
            Text(
              currency,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(2),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Color(0xFF0B252D),
              size: 12,
            ),
          ],
        ));
  }

  late String sellingCurrency;

  @override
  void initState() {
    sellingCurrency = widget.model.sellingWallet!.currency;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sending from",
              style: textTheme.bodyMedium
                  ?.copyWith(fontSize: 12, color: AppColor.kSecondaryColor),
            ),
            const Gap(7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _selectorWidget(widget.model.buyingWallet!.currency, () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return CurrencySelectionBottomSheet(
                        canBuy: true,
                        onAccountCurrencySelected: (wallet) {
                          Navigator.pop(context);
                          widget.model.setBuyingWallet(context, wallet);
                        },
                      );
                    },
                  );
                }),
                const Spacer(),
                if (widget.model.buyingWallet != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      Converter()
                          .getCurrency(widget.model.buyingWallet!.currency),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.showError ? AppColor.kred : null),
                    ),
                  ),
                customKeyboardTextField(
                    controller: widget.controller1,
                    textAlign: TextAlign.right,
                    onChanged: (val) {
                      // getSellingAmount();
                      setState(() {});
                    },
                    textStyle: TextStyle(
                        fontSize: 25,
                        color: widget.showError ? AppColor.kred : null,
                        fontWeight: FontWeight.w600),
                    focusNode: widget.focusNode1)
              ],
            ),
            widget.showError
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.info,
                        color: AppColor.kRedColor,
                        size: 6,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.errorText,
                        style: const TextStyle(
                            color: AppColor.kRedColor, fontSize: 6),
                      )
                    ],
                  )
                : const SizedBox()
          ],
        ),
        const Gap(10),
        if (widget.model.buyingWallet?.currency !=
            widget.model.sellingWallet?.currency) ...[
          Row(
            children: [
              CustomCircularIcon(
                  Transform.rotate(
                      child: SvgPicture.asset(
                          'assets/icons/profile/points/transfer.svg',
                          width: 8,
                          height: 8,
                          color: Colors.white),
                      angle: Converter.getRadianFromDegree(180)),
                  radius: 24, onTap: () {
                widget.model.swapSellingBuyingCurrency(context);
              }, color: AppColor.kSecondaryColor),
              const Expanded(
                child: CustomDivider(
                    sizedBoxHeight: 8, color: AppColor.kAccentColor2),
              ),
              const Gap(8),
              Text(
                '1 ${widget.model.buyingWallet!.currency} = ${widget.model.roundedRate} ${widget.model.sellingWallet!.currency} • Delivery fee: ${widget.deliveryFee.toStringAsFixed(2)} USD',
                style: textTheme.bodyMedium
                    ?.copyWith(fontSize: 12, color: AppColor.kSecondaryColor),
              )
            ],
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Receiving in",
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: 12, color: AppColor.kSecondaryColor),
                  ),
                ],
              ),
              const Gap(7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _selectorWidget(sellingCurrency, () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return CurrencySelectionBottomSheet(
                          canSell: true,
                          onAccountCurrencySelected: (wallet) {
                            Navigator.pop(context);
                            widget.model.setBuyingWallet(context, wallet);
                          },
                          onAllCurrencySelected: (currency) {
                            Navigator.pop(context);
                            widget.model.setSellingWallet(
                                context,
                                Wallet(
                                    user: 'user',
                                    friendlyName: 'friendlyName',
                                    currency: currency.code,
                                    isDefault: false));
                            setState(() {
                              sellingCurrency = currency.code;
                            });
                            getSellingAmount();
                          },
                        );
                      },
                    );
                  }),
                  const Spacer(),
                  if (widget.model.sellingWallet != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 6.0),
                      child: Text(
                        Converter()
                            .getCurrency(widget.model.sellingWallet!.currency),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: widget.showSellingError
                                ? AppColor.kRedColor
                                : AppColor.kSecondaryColor),
                      ),
                    ),
                  IntrinsicWidth(
                    child: Text(
                      getSellingAmount(),
                      style: TextStyle(
                          fontSize: 25,
                          color: widget.showSellingError
                              ? AppColor.kRedColor
                              : AppColor.kSecondaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              if (widget.showSellingError)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.info,
                      color: AppColor.kRedColor,
                      size: 6,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.sellingErrorText,
                      style: const TextStyle(color: AppColor.kRedColor, fontSize: 6),
                    )
                  ],
                )
            ],
          )
        ],
      ]),
    );
  }

  String getSellingAmount() {
    double rate = widget.model.exactRate ?? 1;
    double amount = double.tryParse(
            widget.controller1.text.isEmpty ? '1' : widget.controller1.text) ??
        0.0;
    double convertedAmount = amount * rate;
    setState(() {
      sellingCurrency = widget.model.sellingWallet!.currency;
    });
    return convertedAmount.toStringAsFixed(2);
  }

  Widget customKeyboardTextField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      required TextStyle textStyle,
      ValueSetter<String>? onChanged,
      String hintText = "0.00",
      bool disable = false,
      TextAlign textAlign = TextAlign.start}) {
    return AbsorbPointer(
      absorbing: disable,
      child: IntrinsicWidth(
        child: TextField(
          controller: controller,
          showCursor: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          focusNode: focusNode,
          style: textStyle,
          textAlign: textAlign,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          maxLength: 10,
          onChanged: onChanged,
          // autofocus: true,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: textStyle,
              counterText: ''),
        ),
      ),
    );
  }
}
