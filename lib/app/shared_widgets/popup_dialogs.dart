import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

import '../../util/color_scheme.dart';
import '../../util/enums.dart';

/// PopupDialogs
class PopupDialogs {
  /// PopupDialogs
  const PopupDialogs(this.context);

  /// unVerifiedSnack
  final BuildContext context;

  /// unVerifiedSnack
  void successMessage(String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: AppColor.successMessageBg,
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          Icons.check_circle,
          color: AppColor.successMessageBorder,
          size: 22,
        ),
      ),
      messageColor: AppColor.successMessageBorder,
      message: message,
      duration: const Duration(seconds: 4),
    ).show(context);
    // var snackbar = SnackBar(
    //   backgroundColor: AppColor.successMessageBorder,
    //   margin: EdgeInsets.only(
    //     left: 20,
    //     right: 20,
    //     bottom: MediaQuery.of(context).size.height - 200,
    //   ),
    //   padding: const EdgeInsets.all(2),
    //   content: Container(
    //       height: 57,
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //           color: AppColor.successMessageBg,
    //           borderRadius: BorderRadius.circular(6)),
    //       child: Row(
    //         children: [
    //           const Gap(24),
    //           const CircleAvatar(
    //             radius: 12,
    //             backgroundColor: AppColor.successMessageBorder,
    //             child: Icon(
    //               Icons.check,
    //               color: AppColor.kWhiteColor,
    //               size: 12,
    //             ),
    //           ),
    //           const Gap(16),
    //           Expanded(
    //               child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                 Text(
    //                   'SUCCESS!',
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headline6
    //                       ?.copyWith(color: AppColor.successMessageBorder),
    //                 ),
    //                 Text(
    //                   message,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .subtitle2
    //                       ?.copyWith(color: AppColor.successMessageBorder),
    //                 )
    //               ])),
    //         ],
    //       )),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  /// unVerifiedSnack
  void errorMessage(String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: AppColor.errorAlertBg,
      icon: const CircleAvatar(
        radius: 12,
        backgroundColor: AppColor.kRedColor,
        child: Icon(
          Icons.close,
          color: AppColor.kWhiteColor,
          size: 12,
        ),
      ),
      messageColor: AppColor.kRedColor,
      message: message,
      duration: const Duration(seconds: 4),
    ).show(context);
    // var snackbar = SnackBar(
    //   backgroundColor: AppColor.kRedColor,
    //   margin: EdgeInsets.only(
    //     left: 20,
    //     right: 20,
    //     bottom: MediaQuery.of(context).size.height - 200,
    //   ),
    //   padding: const EdgeInsets.all(2),
    //   content: Container(
    //       height: 57,
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //           color: AppColor.errorAlertBg,
    //           borderRadius: BorderRadius.circular(6)),
    //       child: Row(
    //         children: [
    //           const Gap(24),
    //           const CircleAvatar(
    //             radius: 12,
    //             backgroundColor: AppColor.kRedColor,
    //             child: Icon(
    //               Icons.close,
    //               color: AppColor.kWhiteColor,
    //               size: 12,
    //             ),
    //           ),
    //           const Gap(16),
    //           Expanded(
    //               child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                 Text(
    //                   'ERROR!',
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headline6
    //                       ?.copyWith(color: AppColor.kRedColor),
    //                 ),
    //                 Text(
    //                   message,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .subtitle2
    //                       ?.copyWith(color: AppColor.kRedColor),
    //                 )
    //               ])),
    //         ],
    //       )),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  /// unVerifiedSnack
  void warningMessage(String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: AppColor.warningMessageBg,
      icon: const Icon(
        Icons.error,
        color: AppColor.kSecondaryColor,
        size: 24,
      ),
      shouldIconPulse: false,
      messageColor: AppColor.warningMessageBorder,
      message: message,
      duration: const Duration(seconds: 4),
    ).show(context);
    // var snackbar = SnackBar(
    //   backgroundColor: AppColor.warningMessageBorder,
    //   margin: EdgeInsets.only(
    //     left: 20,
    //     right: 20,
    //     bottom: MediaQuery.of(context).size.height - 200,
    //   ),
    //   padding: const EdgeInsets.all(2),
    //   content: Container(
    //       height: 57,
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //           color: AppColor.warningMessageBg,
    //           borderRadius: BorderRadius.circular(6)),
    //       child: Row(
    //         children: [
    //           const Gap(24),
    //           const Icon(
    //             Icons.error_sharp,
    //             color: AppColor.warningMessageBorder,
    //             size: 24,
    //           ),
    //           const Gap(16),
    //           Expanded(
    //               child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                 Text(
    //                   'WARNING!',
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headline6
    //                       ?.copyWith(color: AppColor.warningMessageBorder),
    //                 ),
    //                 Text(
    //                   message,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .subtitle2
    //                       ?.copyWith(color: AppColor.warningMessageBorder),
    //                 )
    //               ])),
    //         ],
    //       )),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  /// unVerifiedSnack
  void informationMessage(String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: const Color(0xffEBFAFF),
      icon: const Icon(
        Icons.error,
        color: AppColor.kSecondaryColor,
        size: 24,
      ),
      shouldIconPulse: false,
      messageColor: AppColor.kSecondaryColor,
      message: message,
      duration: const Duration(seconds: 4),
    ).show(context);
    // var snackbar = SnackBar(
    //   backgroundColor: AppColor.kSecondaryColor,
    //   margin: EdgeInsets.only(
    //     left: 20,
    //     right: 20,
    //     bottom: MediaQuery.of(context).size.height - 200,
    //   ),
    //   padding: const EdgeInsets.all(2),
    //   content: Container(
    //       height: 57,
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //           color: const Color(0xffEBFAFF),
    //           borderRadius: BorderRadius.circular(6)),
    //       child: Row(
    //         children: [
    //           const Gap(24),
    //           const Icon(
    //             Icons.error_sharp,
    //             color: AppColor.kSecondaryColor,
    //             size: 24,
    //           ),
    //           const Gap(16),
    //           Expanded(
    //               child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                 Text(
    //                   'COMING SOON!',
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headline6
    //                       ?.copyWith(color: AppColor.kSecondaryColor),
    //                 ),
    //                 Text(
    //                   message,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .subtitle2
    //                       ?.copyWith(color: AppColor.kSecondaryColor),
    //                 )
    //               ])),
    //         ],
    //       )),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  ///unVerifiedSnack
  void unVerifiedSnack() {
    // return PopupDialogs(context).snackPopup(
    //   status: RequestStatus.info,
    //   message: 'Verify your account to be able to perform this action.',
    // );
  }

  /// comingSoonSnack
  void comingSoonSnack([String? message]) {
    informationMessage('We are still baking this feature');
  }

  /// snackContainerColor
  Color snackContainerColor(RequestStatus status) {
    if (status == RequestStatus.success) {
      return AppColor.kSuccessContainerColor;
    } else if (status == RequestStatus.failure) {
      return AppColor.kErrorContainerColor;
    } else if (status == RequestStatus.info) {
      return AppColor.kErrorContainerColor;
    } else {
      return AppColor.kErrorContainerColor;
    }
  }

  /// snackContainerBorderColor
  Color snackContainerBorderColor(RequestStatus status) {
    if (status == RequestStatus.success) {
      return AppColor.kSuccessBorder;
    } else if (status == RequestStatus.failure) {
      return AppColor.kErrorBorderColor;
    } else if (status == RequestStatus.info) {
      return AppColor.kInfoBorderColor;
    } else {
      return AppColor.kWarningBorderColor;
    }
  }

  /// snackTextColor
  Color snackTextColor(RequestStatus status) {
    if (status == RequestStatus.success) {
      return AppColor.kSuccessTextColor;
    } else if (status == RequestStatus.failure) {
      return AppColor.kErrorTextColor;
    } else if (status == RequestStatus.info) {
      return AppColor.kInfoTextColor;
    } else {
      return AppColor.kWarningTextColor;
    }
  }

  /// snackTextIcon
  String snackTextIcon(RequestStatus status) {
    if (status == RequestStatus.success) {
      return 'assets/icons/success.svg';
    } else if (status == RequestStatus.failure) {
      return 'assets/icons/failure.svg';
    } else if (status == RequestStatus.info) {
      return 'assets/icons/info.svg';
    } else {
      return 'assets/icons/warning.svg';
    }
  }
}
