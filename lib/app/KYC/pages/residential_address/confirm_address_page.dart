import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/view_models.dart/address_view_model.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class ConfirmHomeAddreePage extends StatelessWidget {
  ConfirmHomeAddreePage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConfirmHomeAddreePage(),
      ),
    );
  }

  final additionalInformation = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<AddressViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Confirm Home Address',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButtonAsync(
            color: AppColor.kGoldColor2,
            child: Text(
              'CONFIRM & CONTINUE',
              style: textTheme.bodyLarge,
            ),
            onPressed: () async {
              await model.verifyAddress(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please confirm that this information is correct to make sure your card reaches you.',
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Gap(16),
                Center(
                  child: SizedBox(
                    height: 140,
                    child: Image.asset(
                      'assets/images/39.payment-processed-1.png',
                    ),
                  ),
                ),
                const Gap(24),
                CurvedBackground(
                  borderRadius: 20,
                  bgColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model.getName().trim().isNotEmpty)
                        Text(
                          model.getName(),
                          style: textTheme.bodyLarge?.copyWith(
                              color: AppColor.kSecondaryColor, fontSize: 16),
                        ),
                      const Gap(10),
                      Text(
                        "${model.address?.addressLine1},"
                        " ${model.address?.city} ${model.address?.postCode}\n"
                        "${model.address?.state}\n"
                        "${model.country?.name}",
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Edit address',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: AppColor.kSecondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(120)
              ],
            ),
          )),
        ),
      );
    });
  }
}
