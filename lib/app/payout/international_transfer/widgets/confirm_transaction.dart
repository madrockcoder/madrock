import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/view_models/international_transfer_vm.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/international_transfer_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';

class ConfirmInternationalTransaction extends StatefulWidget {
  final InternationalTransferModel internationalTransferModel;
  final BankBeneficiary selectedBeneficiary;
  final Wallet selectedWallet;
  final bool sameCurrency;
  final String? exchangeRate;
  const ConfirmInternationalTransaction(
      {Key? key,
      required this.internationalTransferModel,
      required this.selectedBeneficiary,
      required this.selectedWallet,
      required this.sameCurrency,
      this.exchangeRate})
      : super(key: key);

  @override
  State<ConfirmInternationalTransaction> createState() =>
      _ConfirmInternationalTransactionState();
}

class _ConfirmInternationalTransactionState
    extends State<ConfirmInternationalTransaction> {
  Widget customTile(String title, String subtitle) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          title,
          style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Spacer(),
        Text(
          subtitle,
          style: textTheme.bodyMedium
              ?.copyWith(color: Colors.grey[500], fontSize: 12),
        ),
      ],
    );
  }

  final Converter _walletHelper = Converter();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .9,
        ),
        margin: const EdgeInsets.only(top: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              const Gap(24),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(18),
              const Spacer(),
              const Text('Confirm Transaction'),
              const Spacer(
                flex: 2,
              ),
              const Gap(24),
            ],
          ),
          const Gap(32),
          Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .7,
              ),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.white,
                          AppColor.kAccentColor2.withOpacity(.5),
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColor.kAccentColor2,
                        child: SvgPicture.asset(
                          'assets/icons/wallet-money.svg',
                          width: 25,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        'Wallet payment',
                        style: textTheme.bodyLarge?.copyWith(
                            fontSize: 20, color: AppColor.kSecondaryColor),
                      ),
                      const Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CountryFlagContainer(
                            flag: _walletHelper
                                .getLocale(widget.selectedWallet.currency),
                            size: 12,
                          ),
                          const Gap(8),
                          Text(
                            '${widget.selectedWallet.currency} Wallet',
                            style: textTheme.titleSmall,
                          )
                        ],
                      ),
                      const Gap(20),
                      const Text(
                        'If all the data is correct, confirm the transaction to proceed with the payment.',
                        textAlign: TextAlign.center,
                      ),
                      const Gap(52),
                    ]),
                  ),
                  const Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            'Sending to',
                            style: textTheme.titleSmall
                                ?.copyWith(color: AppColor.kSecondaryColor),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              CountryFlagContainer(
                                flag: _walletHelper.getLocale(
                                    widget.selectedBeneficiary.currency),
                                size: 40,
                              ),
                              const Gap(12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.selectedBeneficiary
                                                .beneficiaryFirstName ==
                                            null
                                        ? widget
                                            .selectedBeneficiary.companyName!
                                        : "${widget.selectedBeneficiary.beneficiaryFirstName} ${widget.selectedBeneficiary.beneficiaryLastName}",
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    widget.selectedBeneficiary.hashedIban ?? '',
                                    style: textTheme.bodyMedium
                                        ?.copyWith(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const Gap(16),
                      DottedLine(
                        dashGapLength: 6,
                        dashColor: Colors.grey[400]!,
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Text(
                            'Amount',
                            style: textTheme.titleSmall
                                ?.copyWith(color: AppColor.kSecondaryColor),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                widget.internationalTransferModel.amount
                                        .valueWithCurrency ??
                                    '',
                                style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                              if (!widget.sameCurrency) ...[
                                const Icon(
                                  Icons.arrow_right_alt,
                                  size: 16,
                                  color: AppColor.kSecondaryColor,
                                ),
                                Text(
                                  widget.internationalTransferModel
                                          .receivingAmount?.valueWithCurrency ??
                                      '',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[500], fontSize: 12),
                                )
                              ],
                            ],
                          ),
                        ],
                      ),
                      const Gap(8),
                      if (!widget.sameCurrency) ...[
                        customTile('Exchange Rate', widget.exchangeRate!),
                        const Gap(8)
                      ],
                      customTile(
                          'Transfer fee',
                          widget.internationalTransferModel.fees
                                  ?.valueWithCurrency ??
                              ''),
                      const Gap(8),
                      customTile(
                          'Delivery option',
                          getPaymentDeliveryTime(
                              widget.internationalTransferModel.paymentType)),
                      if (widget.internationalTransferModel.paymentMethod !=
                          null) ...[
                        const Gap(8),
                        customTile('Payment method',
                            widget.internationalTransferModel.paymentMethod!)
                      ],
                      // Gap(8),
                      // customTile('Order no', 'Transfer #12345678'),
                      // Gap(8),
                      // customTile('Reference', 'School fees'),
                      const Gap(16),
                      Row(
                        children: [
                          Text(
                            "Total to pay",
                            style: textTheme.titleSmall
                                ?.copyWith(color: AppColor.kSecondaryColor),
                          ),
                          const Spacer(),
                          Text(
                            widget.internationalTransferModel.totalAmount
                                    ?.valueWithCurrency ??
                                '',
                            style: textTheme.titleSmall
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      )
                    ]),
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: CustomElevatedButtonAsync(
                color: AppColor.kGoldColor2,
                child: Text(
                  'PAY ${widget.internationalTransferModel.totalAmount?.valueWithCurrency}',
                  style: textTheme.bodyLarge,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  final InternationalTransferVM _internationalTransferVM =
                      sl<InternationalTransferVM>();
                  _internationalTransferVM.createInternationalTransfer(
                      context,
                      widget.internationalTransferModel,
                      widget.selectedWallet.friendlyName,
                      widget.selectedBeneficiary.beneficiaryFirstName == null
                          ? widget.selectedBeneficiary.companyName!
                          : "${widget.selectedBeneficiary.beneficiaryFirstName} ${widget.selectedBeneficiary.beneficiaryLastName}");
                },
              ))
        ]));
  }
}
