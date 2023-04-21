import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/passcode/blocked_account.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/maintenance_screen.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/no_internet_screen.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/oops_screen.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/server_down_screen.dart';
import 'package:geniuspay/core/errors/errors.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback? onRefresh;
  final Object? exception;
  final bool showHelp;
  const ErrorScreen(
      {Key? key,
      required this.onRefresh,
      required this.exception,
      required this.showHelp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (exception.runtimeType == NoInternetException ||
        exception.runtimeType == NoInternetFailure) {
      return NoInternetScreen(
        showHelp: showHelp,
        onPressed: onRefresh,
      );
    } else if (exception.runtimeType == ServerException ||
        exception.runtimeType == ServerFailure) {
      return ServerDownScreen(onPressed: onRefresh, showHelp: showHelp);
    } else if (exception.runtimeType == BlockedUser) {
      return const BlockedAccount();
    } else if (exception.runtimeType == Maintenance) {
      return const MaintenanceBreak();
    } else {
      return OopsScreen(onRefresh: onRefresh, showHelp: showHelp);
    }
  }
}
