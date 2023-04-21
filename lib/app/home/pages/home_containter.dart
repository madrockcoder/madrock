import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/Profile/profile_page.dart';
import 'package:geniuspay/app/home/pages/all_transactions_page.dart';
import 'package:geniuspay/app/home/pages/home_screen.dart';
import 'package:geniuspay/app/home/view_models/home_view_model.dart';
import 'package:geniuspay/app/payout/payout_selector.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/wallet/wallet_screen_main.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/services/navigation_service.dart';
import 'package:geniuspay/util/color_scheme.dart';

class HomeWidget extends StatefulWidget {
  final int defaultPage;
  final String? showWalletId;
  final String? showSuccessDialog;
  final bool resetUser;
  const HomeWidget(
      {Key? key,
      this.defaultPage = 2,
      this.showWalletId,
      this.showSuccessDialog,
      this.resetUser = false})
      : super(key: key);

  static Future<void> show(BuildContext context,
      {int defaultPage = 2,
      String? showWalletId,
      String? showSuccessDialog,
      bool resetUser = false}) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomeWidget(
          defaultPage: defaultPage,
          showWalletId: showWalletId,
          showSuccessDialog: showSuccessDialog,
          resetUser: resetUser,
        ),
      ),
      ((route) => false),
    );
  }

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late int page;
  final _bottomNavigationKey = GlobalKey();

  Widget _imageWidget(String image, int index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(
        image,
        width: index == page ? 30 : 25,
        color: index == page ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _iconWidget(IconData icon, int index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        size: index == page ? 30 : 25,
        color: index == page ? Colors.white : Colors.black,
      ),
    );
  }

  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    page = widget.defaultPage;
    NavigationServices.parentContext = context;
    _pageController = PageController(initialPage: widget.defaultPage);
    if (widget.showSuccessDialog != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        PopupDialogs(context).successMessage(widget.showSuccessDialog!);
      });
    }
    if (widget.showWalletId != null) {
      final WalletScreenVM _walletScreenVM = sl<WalletScreenVM>();
      _walletScreenVM.showWalletId = widget.showWalletId;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(onModelReady: (p0) async {
      if (widget.resetUser) {
        await p0.getUser();
      }
    }, builder: (context, model, snapshot) {
      return Scaffold(
        backgroundColor: page == 0 ? AppColor.kAccentColor2 : Colors.white,
        // backgroundColor: page == 4 || page == 1 || page == 0 || page == 2
        //     ? Colors.white
        //     : !model.isVerifed && page == 2
        //         ? Colors.white
        //         : AppColor.kAccentColor2,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          buttonBackgroundColor:
              page == 2 ? AppColor.kSecondaryColor : Colors.black,
          index: page,
          animationDuration: const Duration(milliseconds: 300),
          color: Colors.grey.shade50,
          backgroundColor: Colors.transparent,
          items: [
            _imageWidget('assets/home/wallet.svg', 0),
            _imageWidget('assets/home/dollar-square.svg', 1),
            Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  'assets/home/gp_logo.svg',
                  color: page == 2 ? null : Colors.black,
                  width: page == 2 ? 40 : 30,
                )),
            _imageWidget('assets/home/transaction.svg', 3),
            _imageWidget('assets/home/menu.svg', 4),
          ],
          onTap: (index) {
            setState(() {
              page = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          },
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => page = index);
            },
            children: [
              const WalletScreen(),
              PayoutSelectorPage(),
              HomeScreen(
                pageController: _pageController,
              ),
              const AccountTransactionsPage(
                addLeading: false,
              ),
              const ProfileScreen()
            ],
            // children: <Widget>[
            //   const CardCreateScreen(),
            //   PayoutSelectorPage(),
            //   HomeScreen(
            //     pageController: _pageController,
            //   ),
            //   const WalletScreen(),
            //   const ProfileScreen()
            // ],
          ),
        ),
      );
    });
  }
}
