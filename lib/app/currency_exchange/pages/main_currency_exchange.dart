import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/view_models/main_currency_exchange_vm.dart';
import 'package:geniuspay/app/currency_exchange/widgets/exchange_flag_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/loading_widget.dart';
import 'package:geniuspay/app/currency_exchange/widgets/recent_exchange_mini.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/iconPath.dart';

class MainCurrencyExchangePage extends StatefulWidget {
  final Wallet? selectedWallet;

  const MainCurrencyExchangePage({Key? key, this.selectedWallet})
      : super(key: key);

  static Future<void> show(
      {required BuildContext context, Wallet? selectedWallet}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MainCurrencyExchangePage(
          selectedWallet: selectedWallet,
        ),
      ),
    );
  }

  @override
  State<MainCurrencyExchangePage> createState() =>
      _MainCurrencyExchangePageState();
}

class _MainCurrencyExchangePageState extends State<MainCurrencyExchangePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<CurrencyExchangeViewModel>(
        onModelReady: (p0) => p0.init(context, widget.selectedWallet),
        builder: (context, model, snapshot) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColor.kAccentColor2,
                appBar: AppBar(
                  backgroundColor: model.baseModelState == BaseModelState.error
                      ? AppColor.kWhiteColor
                      : AppColor.kAccentColor2,
                  centerTitle: true,
                  title: Text('Currency Exchange',
                      style: textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  actions: const [HelpIconButton()],
                ),
                body: model.baseModelState == BaseModelState.success
                    ? Column(
                        children: [
                          MainExchangeWidget(viewModel: model),
                          const Gap(15),
                          exchangeHistoryWidget(),
                        ],
                      )
                    : model.baseModelState == BaseModelState.loading
                        ? const LoadingWidget()
                        : ErrorScreen(
                            showHelp: false,
                            onRefresh: () {
                              setState(() {
                                model.init(context, widget.selectedWallet);
                              });
                            },
                            exception: model.errorType)),
          );
        });
  }

  Widget exchangeHistoryWidget() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Color.fromRGBO(7, 5, 26, 0.07),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: const ExchangeHistories(),
      ),
    );
  }

  Widget emptyExchangeHistoryWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(SvgPath.docSvg),
          const Gap(10),
          Text(
            'You have no currency exchange\ntransations yet',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}

class MainExchangeWidget extends StatefulWidget {
  final CurrencyExchangeViewModel viewModel;

  const MainExchangeWidget({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<MainExchangeWidget> createState() => _MainExchangeWidgetState();
}

class _MainExchangeWidgetState extends State<MainExchangeWidget> {
  final _buyingAmountController = TextEditingController(text: '10');
  String exactBuyingAmount = '10';
  final _sellingAmountController = TextEditingController(text: '0');
  String exactSellingAmount = '0';
  final bool _isSwap = false;

  @override
  void initState() {
    changeBuyingAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 37,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 50,
            color: Color.fromARGB(17, 239, 239, 239),
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'You send',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: AppColor.kGreyColor),
            ),
            Text(
              '1 ${widget.viewModel.buyingWallet?.currency} = ${widget.viewModel.roundedRate} ${widget.viewModel.sellingWallet?.currency}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 10, fontWeight: FontWeight.w300),
            )
          ]),
          buyingAmountWidget(),
          if (didExceedBalance() || isAmountLess())
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                isAmountLess()
                    ? 'Amount should be greater than 5'
                    : 'Exceeded balance',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColor.kred),
              ),
            )
          else
            const Gap(12),
          exchangeButtonWidget(),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'You get',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColor.kGreyColor),
              )),
          sellingAmountWidget(),
          if (showSellingError()[0] as bool)
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                showSellingError()[1] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColor.kred),
              ),
            ),
          const Gap(12),
          dividerWidget(),
          const Gap(30),
          amountButtonWidget()
        ],
      ),
    );
  }

  bool didExceedBalance() {
    final amount = _buyingAmountController.text.isEmpty
        ? '0'
        : _buyingAmountController.text;
    final enteredAmount = double.parse(amount);
    final maxAmount = widget.viewModel.buyingWallet!.availableBalance!.value;
    if (enteredAmount > maxAmount || enteredAmount > 200000) {
      return true;
    } else {
      return false;
    }
  }

  bool isAmountLess() {
    final amount = _buyingAmountController.text.isEmpty
        ? '0'
        : _buyingAmountController.text;
    final enteredAmount = double.parse(amount);
    if (enteredAmount < 5) {
      return true;
    } else {
      return false;
    }
  }

  Widget buyingAmountWidget() {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = widget.viewModel;
    return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ExchangeFlagButton(
              wallets: viewModel.wallets,
              defaultCurrencyWallet: viewModel.buyingWallet!,
              voidCallback: (Wallet wallet) async {
                await viewModel.setBuyingWallet(context, wallet);
                changeBuyingAmount();
              },
              onCreateWallet: (currencyCode) {},
              showOtherCurrencies: false,
            ),
            const Gap(20),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: CustomTextField(
                        autofocus: true,
                        controller: _buyingAmountController,
                        contentPadding: EdgeInsets.zero,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        hint: '0',
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*')),
                        ],
                        onChanged: (val) {
                          widget.viewModel.getExchangeRate(context: context);
                          setState(() {
                            changeBuyingAmount();
                          });
                        },
                        hintStyle: textTheme.bodyLarge?.copyWith(
                            fontSize: 25, color: AppColor.kSecondaryColor),
                        style: textTheme.bodyLarge?.copyWith(
                            fontSize: 25,
                            color: didExceedBalance() || isAmountLess()
                                ? AppColor.kred
                                : AppColor.kSecondaryColor),
                        textAlign: TextAlign.end,
                      ),
                    )))
          ],
        ));
  }

  void changeBuyingAmount() {
    double rate = widget.viewModel.exactRate ?? 1;
    double amount = double.parse(_buyingAmountController.text.isEmpty
        ? '1'
        : _buyingAmountController.text);
    double convertedAmount = _isSwap ? amount / rate : rate * amount;
    try {
      setState(() {
        _sellingAmountController.text = convertedAmount.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _sellingAmountController.text = convertedAmount.toStringAsFixed(2);
      });
    }

    // return '1.00';
  }

  void changeSellingAmount() {
    double rate = (1 / (widget.viewModel.exactRate ?? 1));
    double amount = double.parse(_sellingAmountController.text.isEmpty
        ? '1'
        : _sellingAmountController.text);
    double convertedAmount = _isSwap ? amount / rate : rate * amount;
    try {
      setState(() {
        _buyingAmountController.text = convertedAmount.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _buyingAmountController.text = convertedAmount.toStringAsFixed(2);
      });
    }

    // return '1.00';
  }

  Widget sellingAmountWidget() {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = widget.viewModel;
    return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ExchangeFlagButton(
              wallets: viewModel.wallets,
              defaultCurrencyWallet: viewModel.sellingWallet!,
              voidCallback: (Wallet wallet) async {
                await viewModel.setSellingWallet(context, wallet);
                changeBuyingAmount();
              },
              onCreateWallet: (currencyCode) async {
                showDialog(
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
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/wallet-money.svg',
                                      width: 48,
                                      height: 48),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Do you want to create a new $currencyCode Wallet to receive funds?",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  CustomYellowElevatedButton(
                                    text: "CREATE WALLET",
                                    onTap: () async {
                                      await widget.viewModel
                                          .createWallet(context, currencyCode);
                                      changeBuyingAmount();
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
              },
              showOtherCurrencies: true,
            ),
            const Gap(16),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: CustomTextField(
                        autofocus: true,
                        controller: _sellingAmountController,
                        contentPadding: EdgeInsets.zero,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        hint: '0',
                        onChanged: (val) {
                          widget.viewModel.getExchangeRate(context: context);
                          setState(() {
                            changeSellingAmount();
                          });
                        },
                        hintStyle: textTheme.bodyLarge?.copyWith(
                            fontSize: 25, color: AppColor.kSecondaryColor),
                        style: textTheme.bodyLarge?.copyWith(
                            fontSize: 25,
                            color: showSellingError()[0] as bool
                                ? AppColor.kRedColor
                                : AppColor.kSecondaryColor),
                        textAlign: TextAlign.end,
                      ),
                    )))
            // Expanded(
            //     child: Align(
            //         alignment: Alignment.centerRight,
            //         child: Text(
            //           _isSwap
            //               ? "${Converter().getCurrency(viewModel.buyingWallet!.currency)}"
            //                   "${changeBuyingAmount()}"
            //               : "${Converter().getCurrency(viewModel.sellingWallet!.currency)}"
            //                   "${changeBuyingAmount()}",
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodyText1
            //               ?.copyWith(fontSize: 25),
            //         )))
          ],
        ));
  }

  List<dynamic> showSellingError() {
    if ((widget.viewModel.sellingCurrency?.minInvoiceAmount ?? 1) >
        (double.tryParse(_sellingAmountController.text) ?? 0)) {
      return [
        true,
        'Minimum amount to receive is ${widget.viewModel.sellingCurrency?.minInvoiceAmount}'
      ];
    } else if ((widget.viewModel.sellingCurrency?.maxInvoiceAmount ??
            999999999) <
        (double.tryParse(_sellingAmountController.text) ?? 0)) {
      return [
        true,
        'Maximum amount to receive is ${widget.viewModel.sellingCurrency?.maxInvoiceAmount}'
      ];
    } else {
      return [false, ''];
    }
  }

  Widget exchangeButtonWidget() {
    final viewModel = widget.viewModel;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColor.kAccentColor2,
          ),
        ),
        const Gap(5),
        InkWell(
          onTap: () {
            // setState(() {
            //   _isSwap = !_isSwap;
            // });
            setState(() {
              viewModel.swapSellingBuyingCurrency(context);
              changeBuyingAmount();
            });
          },
          child: SvgPicture.asset(SvgPath.exchangeSvg),
        ),
        const Gap(5),
        Expanded(
          child: Container(
            height: 1,
            color: AppColor.kAccentColor2,
          ),
        ),
      ],
    );
  }

  Widget dividerWidget() {
    return Container(
      height: 1,
      color: AppColor.kAccentColor2,
    );
  }

  bool buyingAndSellingSame() {
    return widget.viewModel.buyingWallet?.currency ==
        widget.viewModel.sellingWallet?.currency;
  }

  Widget amountButtonWidget() {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = widget.viewModel;
    return CustomElevatedButtonAsync(
      color: AppColor.kSecondaryColor,
      child: Text(
        'EXCHANGE AMOUNT',
        style: textTheme.bodyLarge?.copyWith(
            color: AppColor.kWhiteColor, fontWeight: FontWeight.w600),
      ),
      height: 46,
      onPressed: didExceedBalance() ||
              _buyingAmountController.text.isEmpty ||
              isAmountLess() ||
              buyingAndSellingSame() ||
              showSellingError()[0] as bool
          ? null
          : () async {
              if (viewModel.buyingWallet?.currency ==
                  viewModel.sellingWallet?.currency) {
                PopupDialogs(context).warningMessage(
                    "Buying and selling currency can't be the same");
              } else {
                await viewModel.getExchangeRate(
                    context: context,
                    sellAmount: _buyingAmountController.text,
                    nextStage: true);
              }
            },
    );
  }
}
