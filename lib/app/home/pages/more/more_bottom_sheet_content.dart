import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/essentials.dart';

import 'expandable_log.dart';
import 'more_data.dart';

class MoreBottomSheetContent extends StatefulWidget {
  const MoreBottomSheetContent({
    Key? key,
  }) : super(key: key);
  // final WalletProvider walletProvider;

  static Widget create(
    BuildContext context,
    // required WalletProvider walletProvider,
  ) {
    return const MoreBottomSheetContent(
        // walletProvider: walletProvider,

        );
  }

  @override
  State<MoreBottomSheetContent> createState() => _MoreBottomSheetContentState();
}

class _MoreBottomSheetContentState extends State<MoreBottomSheetContent> {
  var _isPaymentSectionExpanded = true;
  var _isOtherOperationsExpanded = true;
  var _shortcutsExpanded = true;

  // WalletProvider get walletProvider => widget.walletProvider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'More',
          style: textTheme.bodyLarge,
        ),
        actions: const [HelpIconButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                ExpandableLog(
                  title: 'Payments',
                  expand: (val) {
                    setState(() {
                      _isPaymentSectionExpanded = val;
                    });
                  },
                ),
                if (_isPaymentSectionExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 70,
                          mainAxisSpacing: 32
                      ),
                      itemCount: MoreData(context).paymentItems.length,
                      itemBuilder: (_, i) {
                        return MoreData(
                          context,
                        ).paymentItems[i];
                      },
                    ),
                  ),
              ],
            ),
            if(!shouldTemporaryHideForEarlyLaunch)...[
              const SizedBox(height: 20.0),
              Column(
                children: [
                  ExpandableLog(
                    title: 'Other Operations',
                    expand: (val) {
                      setState(() {
                        _isOtherOperationsExpanded = val;
                      });
                    },
                  ),
                  if (_isOtherOperationsExpanded)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 70,
                            mainAxisSpacing: 32
                        ),
                        itemCount: MoreData(context).otherOperations.length,
                        itemBuilder: (_, i) {
                          return MoreData(
                            context,
                          ).otherOperations[i];
                        },
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 20.0),
            Column(
              children: [
                ExpandableLog(
                  title: 'Shortcuts',
                  expand: (val) {
                    setState(() {
                      _shortcutsExpanded = val;
                    });
                  },
                ),
                if (_shortcutsExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 70,
                          mainAxisSpacing: 32
                      ),
                      itemCount: MoreData(context).shortcuts.length,
                      itemBuilder: (_, i) {
                        return MoreData(
                          context,
                        ).shortcuts[i];
                      },
                    ),
                  ),
                const SizedBox(height: 20.0),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
