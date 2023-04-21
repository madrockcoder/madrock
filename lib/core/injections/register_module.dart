import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  Dio get dio => Dio();
  // InAppReview get inAppReview => InAppReview.instance;

  // RemoteConfig get remoteConfig => RemoteConfig.instance;
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
  // FirebaseServices get firebaseStorage => FirebaseServices();

  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
}
