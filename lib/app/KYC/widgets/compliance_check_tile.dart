import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../models/source_of_funds.dart';
import '../../../../../../util/color_scheme.dart';
import 'compliance_provider.dart';

class ComplianceCheckTile extends StatefulWidget {
  const ComplianceCheckTile({
    Key? key,
    required this.sourceOfFunds,
    required this.complianceProvider,
    this.onTap,
  }) : super(key: key);
  final SourceOfFunds sourceOfFunds;
  final ComplianceProvider complianceProvider;
  final VoidCallback? onTap;

  @override
  State<ComplianceCheckTile> createState() => _ComplianceCheckTileState();
}

class _ComplianceCheckTileState extends State<ComplianceCheckTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Row(
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.all<Color>(
                  AppColor.kSurfaceColorVariant),
              // checkColor: AppColor.kBorderColor2,
              side: const BorderSide(color: AppColor.kBorderColor),
              value: widget.sourceOfFunds.isSourceOfFund,
              onChanged: (_) {
                setState(() {
                  widget.sourceOfFunds.isSourceOfFund =
                      !widget.sourceOfFunds.isSourceOfFund;
                });
              },
            ),
            const SizedBox(width: 16.0),
            Flexible(
              child: Text(
                widget.sourceOfFunds.title,
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
