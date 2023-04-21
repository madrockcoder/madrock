import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/view_models/main_currency_exchange_vm.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/bank_recipient_home.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/choose_delivery_option_bottomsheet.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/choose_payment_page.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/custom_list_tiles/delivery_time_list_tile.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/custom_list_tiles/payment_method_list_tile.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/custom_list_tiles/receiver_list_tile.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/recurring.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/recurring_payment_bottomsheet.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/transfer_widget_v2.dart';
import 'package:geniuspay/app/payout/view_models/international_transfer_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet_vm.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/international_transfer_model.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

enum PaymentMethod { wallet, card, bank, paySafeCard, cash, mobile, manualBank }

getPaymentMethodAsString(PaymentMethod paymentMethod) {
  switch (paymentMethod) {
    case PaymentMethod.wallet:
      return "Wallet";
    case PaymentMethod.card:
      return "Card";
    case PaymentMethod.bank:
      return "Bank";
    case PaymentMethod.paySafeCard:
      return "PaySafe";
    case PaymentMethod.cash:
      return "Cash";
    case PaymentMethod.mobile:
      return "Mobile";
    case PaymentMethod.manualBank:
      return "Manual Bank";
  }
}

String paymentMethodString(PaymentMethod paymentMethod) {
  switch (paymentMethod) {
    case PaymentMethod.wallet:
      return "WALLET";
    case PaymentMethod.card:
      return "CARD";
    case PaymentMethod.bank:
      return "BANK_TRANSFER";
    case PaymentMethod.paySafeCard:
      return "CARD";
    case PaymentMethod.cash:
      return "Cash";
    case PaymentMethod.mobile:
      return "MOBILE_MONEY";
    case PaymentMethod.manualBank:
      return "BANK_TRANSFER";
  }
}

class InternationalTransferPage extends StatefulWidget {
  final bool isEuropean;

  const InternationalTransferPage({Key? key, required this.isEuropean})
      : super(key: key);

  static Future<void> show(BuildContext context, bool isEuropean) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => InternationalTransferPage(
                isEuropean: isEuropean,
              )),
    );
  }

  @override
  _InternationalTransferPageState createState() =>
      _InternationalTransferPageState();
}

class _InternationalTransferPageState extends State<InternationalTransferPage> {
  final TextEditingController controller1 = TextEditingController(text: '10');
  final FocusNode focusNode1 = FocusNode();

  BankBeneficiary? selectedBeneficiary;
  DeliveryOption selectedDeliveryOption = deliveryOptions[0];
  PaymentMethod? selectedPaymentMethod;
  Wallet? selectedWallet;
  Recurring? selectedRecurring;
  final Converter _walletHelper = Converter();

  @override
  void initState() {
    CreateWalletViewModel walletViewModel = sl<CreateWalletViewModel>();
    walletViewModel.getCurrencies(context);
    controller1.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedRecurring = Recurring(
            isRecurring: false,
            firstPayment: DateFormat('yyy-MM-dd').format(DateTime.now()),
            frequency: 'Daily',
            lastPayment: DateFormat('yyy-MM-dd').format(DateTime.now()));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<CurrencyExchangeViewModel>(
        onModelReady: (p0) => p0.init(context, null),
        builder: (context, model, snapshot) {
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
                title: Text(widget.isEuropean
                    ? "European Transfer"
                    : "International Transfer"),
                centerTitle: true,
                actions: const [
                  HelpIconButton(),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                  padding: const EdgeInsets.all(24),
                  child: CustomElevatedButtonAsync(
                    color: AppColor.kGoldColor2,
                    height: 40,
                    child: const Text('SEND'),
                    onPressed: (model.baseModelState !=
                                BaseModelState.success ||
                            showError(model)[0] as bool ||
                            showSellingError(model)[0] as bool ||
                            selectedBeneficiary == null ||
                            selectedPaymentMethod == null)
                        ? null
                        : () async {
                            final internationalTransferVM =
                                sl<InternationalTransferVM>();
                            final authenticationService =
                                sl<AuthenticationService>();
                            final body = InternationalTransferModel(
                              user: authenticationService.user!.id,
                              paymentMethod:
                                  paymentMethodString(selectedPaymentMethod!),
                              scheduled: selectedRecurring!.isRecurring,
                              paymentDate: selectedRecurring!.isRecurring
                                  ? selectedRecurring!.firstPayment
                                  : null,
                              paymentFrequency: selectedRecurring!.isRecurring
                                  ? selectedRecurring!.frequency
                                  : null,
                              lastPaymentDate: selectedRecurring!.isRecurring
                                  ? selectedRecurring!.lastPayment
                                  : null,
                              amount: TotalAmount(
                                  value: double.parse(controller1.text),
                                  currency: model.buyingWallet!.currency,
                                  valueWithCurrency: _walletHelper.getCurrency(
                                          model.buyingWallet!.currency) +
                                      controller1.text),
                              beneficiaryId: selectedBeneficiary!.id!,
                              purposeCode: 'education',
                              description:
                                  'Transfer to ${selectedBeneficiary?.beneficiaryFirstName == null ? selectedBeneficiary?.companyName : "${selectedBeneficiary?.beneficiaryFirstName} ${selectedBeneficiary?.beneficiaryLastName}"}',
                              paymentType: selectedDeliveryOption.deliveryTime,
                            );
                            if (model.buyingWallet?.currency ==
                                model.sellingWallet?.currency) {
                              await internationalTransferVM.validateTransfer(
                                  context: context,
                                  internationalTransferModel: body,
                                  selectedBeneficiary: selectedBeneficiary!,
                                  selectedWallet: selectedWallet!);
                            } else {
                              await internationalTransferVM.getQuotation(
                                  context: context,
                                  internationalTransferModel: body,
                                  selectedBeneficiary: selectedBeneficiary!,
                                  selectedWallet: selectedWallet!,
                                  sellingCurrency:
                                      model.sellingWallet!.currency);
                            }
                          },
                  )),
              body: model.baseModelState == BaseModelState.loading
                  ? ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            enabled: true,
                            child: Container(
                              width: double.infinity,
                              height: 178,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ))
                      ],
                    )
                  : ListView(
                      children: [
                        if (model.buyingWallet?.currency ==
                            model.sellingWallet?.currency) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final result =
                                        await Essentials.showBottomSheet(
                                            RecurringPaymentBottomSheet(
                                              recurring: selectedRecurring!,
                                              amountWithCurrency:
                                                  "${model.buyingWallet?.currency} ${controller1.text}",
                                            ),
                                            context);
                                    if (result != null) {
                                      setState(() {
                                        selectedRecurring = result as Recurring;
                                      });
                                    }
                                  },
                                  child: SvgPicture.asset(
                                      'assets/icons/calendar_add.svg',
                                      width: 24,
                                      height: 24,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                        if (model.buyingWallet?.currency !=
                            model.sellingWallet?.currency)
                          const SizedBox(
                            height: 24,
                          ),
                        TransferWidgetV2(
                          model: model,
                          controller1: controller1,
                          focusNode1: focusNode1,
                          errorText: showError(model)[1] as String,
                          showError: showError(model)[0] as bool,
                          deliveryFee: selectedDeliveryOption.actualPrice,
                          showSellingError: showSellingError(model)[0] as bool,
                          sellingErrorText:
                              showSellingError(model)[1] as String,
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            const Expanded(
                              child: CustomDivider(
                                sizedBoxHeight: 0,
                                color: AppColor.kAccentColor2,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.kSecondaryColor,
                                  borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              child: Text(
                                'Our best exchange rate!',
                                style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                              child: CustomDivider(
                                sizedBoxHeight: 0,
                                color: AppColor.kAccentColor2,
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            BankRecipientHome.show(context, (beneficiary) {
                              if (beneficiary != null) {
                                setState(() {
                                  model.setSellingWallet(
                                      context,
                                      Wallet(
                                          user: 'user',
                                          friendlyName: 'friendlyName',
                                          currency: beneficiary.currency,
                                          isDefault: false));
                                  selectedBeneficiary = beneficiary;
                                });
                              }
                            }, widget.isEuropean, 'Choose beneficiary');
                          },
                          child: ReceiverListTile(
                              selectedBeneficiary: selectedBeneficiary),
                        ),
                        const Gap(16),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final deliveryOption =
                                await Essentials.showBottomSheet(
                              const ChooseDeliveryOptionBottomSheet(),
                              context,
                            ) as DeliveryOption;

                            setState(() {
                              selectedDeliveryOption = deliveryOption;
                            });
                          },
                          child: DeliveryTimeListTile(
                              selectedDeliveryOption: selectedDeliveryOption),
                        ),
                        const Gap(16),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final list =
                                await SelectInternationalPaymentMethod.show(
                              context,
                            ) as List<dynamic>;
                            if (list.isNotEmpty) {
                              setState(() {
                                selectedPaymentMethod =
                                    list[0] as PaymentMethod;
                                selectedWallet = list[1] as Wallet;
                                model.setBuyingWallet(context, selectedWallet!);
                              });
                            }
                          },
                          child: PaymentMethodListTile(
                              selectedPaymentMethod: selectedPaymentMethod,
                              selectedWallet: selectedWallet),
                        ),
                        const Gap(16),
                        // InkWell(
                        //     splashFactory: NoSplash.splashFactory,
                        //     splashColor: Colors.transparent,
                        //     highlightColor: Colors.transparent,
                        //     onTap: () {
                        //       PopupDialogs(context).comingSoonSnack();
                        //     },
                        //     child: const PromoCodeListTile()),
                      ],
                    ),
            ),
          );
        });
  }

  List<dynamic> showError(CurrencyExchangeViewModel model) {
    if (kDebugMode) {
      print(model.sellingCurrency);
    }
    if (controller1.text.isNotEmpty) {
      final amount = double.tryParse(controller1.text) ?? 0.0;
      if (model.buyingWallet!.availableBalance!.value < amount) {
        return [true, 'Exceeded minimum balance'];
      } else if (amount < 5) {
        return [true, 'Minimum amount is 5'];
      }
    } else {
      return [true, 'Please Enter an amount'];
    }
    return [false, ''];
  }

  List<dynamic> showSellingError(CurrencyExchangeViewModel model) {
    final rate = model.exactRate ?? 1;
    final amount =
        double.tryParse(controller1.text.isEmpty ? '1' : controller1.text) ??
            0.0;
    final sellingAmount = amount * rate;
    if ((model.sellingCurrency?.minInvoiceAmount ?? 1) > sellingAmount) {
      return [
        true,
        'Minimum amount to receive is ${model.sellingCurrency?.minInvoiceAmount}'
      ];
    } else if ((model.sellingCurrency?.maxInvoiceAmount ?? 999999999) <
        sellingAmount) {
      return [
        true,
        'Maximum amount to receive is ${model.sellingCurrency?.maxInvoiceAmount}'
      ];
    } else {
      return [false, ''];
    }
  }
}
