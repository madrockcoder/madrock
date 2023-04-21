import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/home/widget/transaction_detail_page.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_loader.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet_vm.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/transactions_services.dart';
import '../../../util/color_scheme.dart';

class TransferResultScreen extends StatelessWidget {
  const TransferResultScreen({
    Key? key,
    this.title,
    required this.amount,
    this.description,
    this.from,
    this.to,
    this.date,
    required this.status,
    this.redirectWallet,
    required this.points,
    this.replaceScreen = false,
    this.referenceNumber,
  }) : super(key: key);

  final String? title;
  final String amount;
  final String? description;
  final String? from;
  final String? to;
  final String? date;
  final int status; // 1: success, 2: fail, 3: pending
  final String? redirectWallet;
  final bool replaceScreen;
  final String points;
  final String? referenceNumber;

  static Future<void> show(
      {required BuildContext context,
      required final int status,
      final String? title,
      required final String amount,
      final String? description,
      final String? from,
      final String? to,
      final String? date,
      required String points,
      String? referenceNumber,
      final String? redirectWallet,
      final bool replacescreen = false}) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => TransferResultScreen(
                status: status,
                title: title,
                amount: amount,
                description: description,
                from: from,
                to: to,
                points: points,
                redirectWallet: redirectWallet,
                date: date,
                referenceNumber: referenceNumber,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: (() {
                    if (status == 1) {
                      return [AppColor.kSuccessColor2, Colors.white];
                    } else if (status == 2) {
                      return [AppColor.kRedColor, Colors.white];
                    } else {
                      return [AppColor.kGoldColor2, Colors.white];
                    }
                  }()),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical! * 04,
              right: SizeConfig.blockSizeVertical! * 04,
              top: SizeConfig.screenHeight! > 768
                  ? SizeConfig.blockSizeVertical! * 013
                  : SizeConfig.blockSizeVertical! * 08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                            shape: BoxShape.rectangle,
                          ),
                          height: 85,
                          width: 170,
                        ),
                        Container(
                          width: double.infinity,
                          height: 520,
                          decoration: BoxDecoration(
                            color: AppColor.kWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              left: 23,
                              right: 23,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Gap(80),
                                Text(title ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 20,
                                    )),
                                const Gap(8),
                                if (points.isNotEmpty)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          status == 1
                                              ? 'You’ve earned $points points'
                                              : status == 2
                                                  ? 'You’ve missed $points points'
                                                  : 'You’ll earn $points points',
                                          style: const TextStyle(
                                            color:
                                                AppColor.kOnPrimaryTextColor3,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 14,
                                          )),
                                      const Gap(3),
                                      Icon(Icons.star,
                                          color: Colors.yellow[500]),
                                    ],
                                  ),
                                const Gap(24),
                                if (referenceNumber != null)
                                  DottedBorder(
                                    color: AppColor.kOnPrimaryTextColor3,
                                    dashPattern: const [10, 10],
                                    strokeWidth: 1,
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      height: 105,
                                      padding: const EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 20,
                                          right: 20),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(amount,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'IBM Plex Sans',
                                                  fontSize: 35,
                                                )),
                                            Text('Reference: $referenceNumber',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: AppColor
                                                      .kOnPrimaryTextColor3,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'IBM Plex Sans',
                                                  fontSize: 12,
                                                ))
                                          ]),
                                    ),
                                  ),
                                if (referenceNumber == null)
                                  DottedBorder(
                                    color: AppColor.kOnPrimaryTextColor3,
                                    dashPattern: const [10, 10],
                                    strokeWidth: 1,
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: const EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 20,
                                          right: 20),
                                      child: Column(children: [
                                        Text(amount,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'IBM Plex Sans',
                                              fontSize: 35,
                                            )),
                                        // Text(description ?? '',
                                        //     style: const TextStyle(
                                        //       color: AppColor
                                        //           .kOnPrimaryTextColor3,
                                        //       fontWeight: FontWeight.w300,
                                        //       fontFamily: 'IBM Plex Sans',
                                        //       fontSize: 12,
                                        //     ))
                                      ]),
                                    ),
                                  ),
                                const Gap(24),
                                if (from != null) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('From',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 14,
                                          )),
                                      Text(from ?? '',
                                          style: const TextStyle(
                                            color:
                                                AppColor.kOnPrimaryTextColor3,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                  const Gap(16),
                                  const Divider(
                                    color: AppColor.kOnPrimaryTextColor3,
                                    height: 0.5,
                                  ),
                                  const Gap(16)
                                ],
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('To',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 14,
                                        )),
                                    Text(to ?? '',
                                        style: const TextStyle(
                                          color: AppColor.kOnPrimaryTextColor3,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                                const Gap(16),
                                const Divider(
                                  color: AppColor.kOnPrimaryTextColor3,
                                  height: 0.5,
                                ),
                                const Gap(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Date',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 14,
                                        )),
                                    Text(date ?? '',
                                        style: const TextStyle(
                                          color: AppColor.kOnPrimaryTextColor3,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                                const Gap(42),
                                status == 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: AppColor
                                                                .kSuccessColor3)),
                                                    child: const ImageIcon(
                                                        AssetImage(
                                                            "assets/transfer/refresh.png"),
                                                        color: AppColor
                                                            .kSuccessColor3))),
                                            InkWell(
                                              onTap: () async {
                                                CustomLoaderScreen.show(
                                                    context);
                                                final AuthenticationService
                                                    _authenticationService =
                                                    sl<AuthenticationService>();
                                                final AccountTransactionsService
                                                    _accountTransactionsService =
                                                    sl<AccountTransactionsService>();
                                                final result =
                                                    await _accountTransactionsService
                                                        .fetchAccountTransactions(
                                                            _authenticationService
                                                                .user!.id,
                                                            '5',
                                                            redirectWallet);
                                                Navigator.pop(context);
                                                result.fold((l) {
                                                  HomeWidget.show(context,
                                                      defaultPage: 0,
                                                      showWalletId:
                                                          redirectWallet);
                                                }, (r) {
                                                  if (r[0]
                                                          .transactions[0]
                                                          .reference ==
                                                      referenceNumber) {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                      NoAnimationPageRoute(
                                                        builder: (_) =>
                                                            const HomeWidget(
                                                          defaultPage: 0,
                                                        ),
                                                      ),
                                                      ((route) => false),
                                                    );
                                                    Navigator.of(context).push(
                                                      NoAnimationPageRoute(
                                                        builder: (_) =>
                                                            TransactionDetailPage(
                                                          transaction: r[0]
                                                              .transactions[0],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                });
                                              },
                                              child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .kSuccessColor3)),
                                                  child: const ImageIcon(
                                                      AssetImage(
                                                          "assets/transfer/show.png"),
                                                      color: AppColor
                                                          .kSuccessColor3)),
                                            ),
                                            // Container(
                                            //     width: 40,
                                            //     height: 40,
                                            //     padding:
                                            //         const EdgeInsets.all(10),
                                            //     decoration: BoxDecoration(
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 12),
                                            //         border: Border.all(
                                            //             color: AppColor
                                            //                 .kSuccessColor3)),
                                            //     child: const ImageIcon(
                                            //         AssetImage(
                                            //             "assets/transfer/download.png"),
                                            //         color: AppColor
                                            //             .kSuccessColor3)),
                                          ])
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (() {
                            if (status == 1) {
                              return AppColor.kSuccessColor3;
                            } else if (status == 2) {
                              return AppColor.kRedColor;
                            } else {
                              return AppColor.kGoldColor2;
                            }
                          }()),
                        ),
                        child: FittedBox(
                          child: Icon(
                              (() {
                                if (status == 1) {
                                  return Icons.check;
                                } else if (status == 2) {
                                  return Icons.priority_high;
                                } else {
                                  return Icons.access_time;
                                }
                              }()),
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(28),
                if (status != 1) ...[
                  CustomElevatedButton(
                      radius: 8,
                      height: 40,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: (() {
                        if (status == 1) {
                          return AppColor.kSuccessColor3;
                        } else if (status == 2) {
                          return AppColor.kRedColor;
                        } else {
                          return AppColor.kGoldColor2;
                        }
                      }()),
                      child: Text(
                          (() {
                            if (status == 1) {
                              return 'ANOTHER TRANSFER';
                            } else if (status == 2) {
                              return 'TRY AGAIN';
                            } else {
                              return 'ANOTHER TRANSFER';
                            }
                          }()),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600))),
                  const Gap(8)
                ],
                TextButton(
                  onPressed: () {
                    if (redirectWallet == null) {
                      HomeWidget.show(context);
                    } else {
                      HomeWidget.show(context,
                          defaultPage: 0, showWalletId: redirectWallet);
                    }
                  },
                  child: Text('BACK HOME', style: textTheme.bodyLarge),
                ),
                const Gap(46)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
