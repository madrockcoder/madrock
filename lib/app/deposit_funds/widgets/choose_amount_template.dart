import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/widgets/round_tag_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class ChooseAmountTemplate extends StatefulWidget {
  final Wallet wallet;
  final String imageAssetPath;
  final String currency;
  final String currencySymbol;
  final Function(BuildContext context, String amount, Wallet wallet) onPressed;
  const ChooseAmountTemplate(
      {Key? key,
      required this.wallet,
      required this.imageAssetPath,
      required this.currency,
      required this.currencySymbol,
      required this.onPressed})
      : super(key: key);

  @override
  State<ChooseAmountTemplate> createState() => _ChooseAmountTemplateState();
}

class _ChooseAmountTemplateState extends State<ChooseAmountTemplate> {
  double _amount = 10;
  final _amountController = TextEditingController();
  double get minAmount =>
      double.parse(widget.wallet.walletType?.minDeposit ?? '5');
  double get maxAmount =>
      double.parse(widget.wallet.walletType?.maxDeposit ?? '2500');
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.kWhiteColor,
        centerTitle: true,
        title: Text('Deposit amount',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        actions: const [HelpIconButton()],
      ),
      body: Container(
        color: AppColor.kWhiteColor,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(10),
              logoWidget(),
              const Gap(30),
              amountCard(textTheme),
              const Gap(28.5),
              continueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoWidget() {
    return SizedBox(
        height: 50, width: 140, child: Image.asset(widget.imageAssetPath));
  }

  bool _showToolTip(double amount) {
    if (amount > maxAmount || amount < minAmount) {
      return true;
    } else {
      return false;
    }
  }

  Widget amountCard(TextTheme textTheme) {
    print(maxAmount.toString().length);
    print(maxAmount);
    return Container(
      width: double.infinity,
      height: 240,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Balance.png'), fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Enter amount',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
          ),
          const Gap(22.5),
          SimpleTooltip(
            arrowTipDistance: 0,
            arrowBaseWidth: 28,
            arrowLength: 12,
            borderRadius: 8,
            borderWidth: 1,
            show: _showToolTip(_amount),
            backgroundColor: AppColor.errorAlertBg,
            borderColor: AppColor.kRedColor,
            ballonPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            tooltipDirection: TooltipDirection.up,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.kSecondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.currency,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColor.kSecondaryColor, fontSize: 10),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColor.kSecondaryColor,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: IntrinsicWidth(
                      child: CustomTextField(
                        autofocus: true,
                        removePadding: true,
                        controller: _amountController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*')),
                        ],
                        contentPadding: EdgeInsets.zero,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        hint: '0.00',
                        maxLength: maxAmount.toStringAsFixed(0).length,
                        onChanged: (val) {
                          final value = val.isEmpty ? '0' : val;
                          double amount = double.parse(value);
                          setState(() {
                            _amount = amount;
                          });
                        },
                        hintStyle: textTheme.bodyLarge?.copyWith(
                            fontSize: 30, color: AppColor.kSecondaryColor),
                        style: textTheme.bodyLarge?.copyWith(
                            fontSize: 30, color: AppColor.kSecondaryColor),
                        textAlign: TextAlign.end,
                      ),
                    ))
              ],
            ),
            content: Text(
              _amount > maxAmount
                  ? "Amount is greater than ${widget.currencySymbol} $maxAmount"
                  : "Amount is less than ${widget.currencySymbol} $minAmount",
              style: textTheme.titleSmall?.copyWith(color: AppColor.kRedColor),
            ),
          ),
          const Gap(20),
          RoundTag(
            label: 'Minimum: ${widget.currencySymbol} $minAmount',
            textStyle: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 10),
          ),
          const Gap(10),
          RoundTag(
            label: 'Limit: ${widget.currencySymbol} $maxAmount',
            textStyle: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 10),
          )
        ],
      ),
    );
  }

  Widget continueButton() {
    return CustomElevatedButtonAsync(
      child: Text(
        'CONTINUE',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      color: AppColor.kGoldColor2,
      disabledColor: AppColor.kAccentColor2,
      onPressed: _amountController.text.isEmpty || _showToolTip(_amount)
          ? null
          : () async {
              await widget.onPressed(
                  context, _amountController.text, widget.wallet);
            },
    );
  }
}

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  const TooltipShapeBorder({
    this.radius = 10.0,
    this.arrowWidth = 15.0,
    this.arrowHeight = 10.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  ShapeBorder scale(double t) => this;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));

    return Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..arcToPoint(rect.bottomLeft, radius: const Radius.circular(10))
      ..lineTo(rect.bottomCenter.dx - 8, rect.bottomCenter.dy)
      ..lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy + 10)
      ..lineTo(rect.bottomCenter.dx + 8, rect.bottomCenter.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(getOuterPath(rect), paint);
  }
}
