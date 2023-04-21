import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/view_models/main_currency_exchange_vm.dart';
import 'package:geniuspay/app/currency_exchange/widgets/exchange_flag_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/app/shared_widgets/custom_shadow_container.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class TransferWidget extends StatefulWidget {
  final CurrencyExchangeViewModel model;
  final TextEditingController controller1;
  final FocusNode focusNode1;
  final bool showError;
  final String errorText;

  const TransferWidget({
    Key? key,
    required this.model,
    required this.controller1,
    required this.focusNode1,
    required this.showError,
    required this.errorText,
  }) : super(key: key);

  @override
  State<TransferWidget> createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget> {
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
            const Gap(3),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Color(0xFF0B252D),
              size: 8.13,
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
    return CustomShadowContainer(
        child: Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "You send",
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              if (widget.model.buyingWallet?.currency !=
                  widget.model.sellingWallet?.currency)
                Text(
                    "1 ${widget.model.buyingWallet!.currency} = ${widget.model.roundedRate} ${widget.model.sellingWallet!.currency}",
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w300))
            ],
          ),
          const Gap(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectorWidget(widget.model.buyingWallet!.currency, () {
                final textTheme = Theme.of(context).textTheme;
                final _searchFocus = FocusNode();
                final _searchController = TextEditingController();
                bool show = false;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BaseView<CreateWalletViewModel>(
                        onModelReady: (p0) async {
                      // p0.getCurrencies(context);
                      // await Future.delayed(const Duration(milliseconds: 10));
                      // setState(() {
                      //   show = true;
                      // });
                    }, builder: (context, model, snapshot) {
                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .90,
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          const Gap(33),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close)),
                                  const Spacer(),
                                  Text('Select currency',
                                      style: textTheme.displayLarge?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  const Spacer(),
                                ],
                              )),
                          const Gap(16),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
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
                                          model.resetCurrencies();
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
                                          model.searchCurrencies(
                                              context, searchTerm);
                                        });
                                      } else {
                                        model.resetCurrencies();
                                      }
                                    },
                                  ))),
                          const Gap(16),
                          Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * .90 -
                                        160,
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 38),
                                      child: Text(
                                        'YOUR ACCOUNTS',
                                        style: textTheme.bodyLarge?.copyWith(
                                            fontSize: 12, letterSpacing: 1.2),
                                      )),
                                  const Gap(12),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: ElevatedCardBackground(
                                          padding: const EdgeInsets.all(8),
                                          child: ListView.separated(
                                              itemCount:
                                                  widget.model.wallets.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Gap(12);
                                              },
                                              itemBuilder: (context, index) {
                                                final wallet =
                                                    widget.model.wallets[index];
                                                if (_searchController
                                                        .text.isEmpty ||
                                                    (_searchController
                                                            .text.isNotEmpty &&
                                                        wallet.currency
                                                            .toLowerCase()
                                                            .contains(
                                                                _searchController
                                                                    .text
                                                                    .toLowerCase()))) {
                                                  return CurrencySelectorTile(
                                                    selected: widget
                                                            .model
                                                            .buyingWallet!
                                                            .walletID ==
                                                        wallet.walletID,
                                                    title: wallet.friendlyName,
                                                    currency: wallet.currency,
                                                    subtitle: wallet.currency,
                                                    trailing: wallet
                                                        .availableBalance!
                                                        .valueWithCurrency,
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        // _selectedWallet = wallet;
                                                      });
                                                      widget.model
                                                          .setBuyingWallet(
                                                              context, wallet);
                                                      // getSellingAmount();
                                                    },
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }))),
                                  const Gap(24),
                                  Gap(MediaQuery.of(context).viewInsets.bottom),
                                ],
                              )),
                        ]),
                      );
                    });
                  },
                );
              }),
              const Spacer(),
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
      if (widget.model.buyingWallet?.currency !=
          widget.model.sellingWallet?.currency) ...[
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Row(
            children: [
              CustomCircularIcon(
                  Transform.rotate(
                      child: SvgPicture.asset(
                          'assets/icons/profile/points/transfer.svg',
                          width: 8,
                          height: 8,
                          color: Colors.white),
                      angle: Converter.getRadianFromDegree(180)),
                  radius: 16, onTap: () {
                // widget.model.swapSellingBuyingCurrency(context);
              }, color: AppColor.kSecondaryColor),
              const Expanded(
                child: CustomDivider(
                    sizedBoxHeight: 8, color: AppColor.kAccentColor2),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  "They receive",
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const Gap(7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _selectorWidget(sellingCurrency, () {
                  final textTheme = Theme.of(context).textTheme;
                  final _searchFocus = FocusNode();
                  final _searchController = TextEditingController();
                  bool show = true;
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return BaseView<CreateWalletViewModel>(
                          onModelReady: (p0) async {
                        if (p0.allCurrencies.isEmpty) {
                          await p0.getCurrencies(context);
                        }else{
                          p0.resetCurrencies();
                        }
                        await Future.delayed(const Duration(seconds: 1));
                        setState(() {
                          show = true;
                        });
                      }, builder: (context, model, snapshot) {
                        return Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * .90,
                          ),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            const Gap(33),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(Icons.close)),
                                    const Spacer(),
                                    Text('Select currency',
                                        style: textTheme.displayLarge?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                    const Spacer(),
                                  ],
                                )),
                            const Gap(16),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
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
                                            model.resetCurrencies();
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
                                            model.searchCurrencies(
                                                context, searchTerm);
                                          });
                                        } else {
                                          model.resetCurrencies();
                                        }
                                      },
                                    ))),
                            const Gap(16),
                            Container(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * .90 -
                                          160,
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    if (show) ...[
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: ElevatedCardBackground(
                                              padding: const EdgeInsets.all(4),
                                              child: ListView.separated(
                                                  itemCount:
                                                      model.currencies.length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Gap(12);
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    final currencies =
                                                        model.currencies;
                                                    return CurrencySelectorTile(
                                                      title: currencies[index]
                                                          .name,
                                                      currency:
                                                          currencies[index]
                                                              .code,
                                                      subtitle:
                                                          currencies[index]
                                                              .code,
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        widget.model.setSellingWallet(
                                                            context,
                                                            Wallet(
                                                                user: 'user',
                                                                friendlyName:
                                                                    'friendlyName',
                                                                currency:
                                                                    currencies[
                                                                            index]
                                                                        .code,
                                                                isDefault:
                                                                    false));
                                                        setState(() {
                                                          sellingCurrency =
                                                              currencies[index]
                                                                  .code;
                                                        });
                                                        // getSellingAmount();
                                                      },
                                                    );
                                                  }))),
                                      Gap(MediaQuery.of(context).viewInsets.bottom),
                                      const Gap(24),
                                    ]
                                  ],
                                )),
                          ]),
                        );
                      });
                    },
                  );
                }),
                const Spacer(),
                IntrinsicWidth(
                  child: Text(
                    getSellingAmount(),
                    style: const TextStyle(
                        fontSize: 25,
                        color: AppColor.kSecondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ]));
  }

  String getSellingAmount() {
    double rate = widget.model.exactRate ?? 1;
    double amount = double.tryParse(
        widget.controller1.text.isEmpty ? '1' : widget.controller1.text)??0.0;
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
          onChanged: onChanged,
          autofocus: true,
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
          ),
        ),
      ),
    );
  }
}
