import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/custom_list_tile.dart';
// import 'package:geniuspay/app/beneficiaries/widgets/custom_list_tile.dart';
// import 'package:geniuspay/constants/color_scheme.dart';

class BankModalSheet extends StatelessWidget {
  const BankModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        child: Container(
          height: 240,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBeneficiaryListTile(
                    'Own Account', 'An account owned by you at another financial institution.', Container(), Container()),
                const Gap(12),
                CustomBeneficiaryListTile('Third Party Account', 'An account that belongs to a different person or organisation.',
                    Container(), Container())
              ],
            ),
          ),
        ));
  }
}
