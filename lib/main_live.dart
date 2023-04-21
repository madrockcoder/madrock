import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/landing_page.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/firebase_dynamic_link.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/shared_widgets/dismiss_keyboard.dart';
import 'environment_config.dart';
import 'repos/auth.dart';
import 'repos/global_repo.dart';
import 'repos/local_repo.dart';
import 'services/firebase_services.dart';
import 'services/mixpanel_service.dart';
import 'services/navigation_service.dart';
import 'util/app_theme.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.stack != null) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  };

  EnvironmentConfig.flavor = Flavor.live;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await configureDependecies();
  await preloader();
  Stripe.publishableKey = publishableKey;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SentryFlutter.init(
    (options) {
      options.dsn = RemoteConfigService.getRemoteData.sentryId;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
  // runApp(const MyApp());
  //Instabug.start('fc37d70b4f60149e19809372b48a45ae', []);
}

Future<void> preloader() async {
  // init firebase
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  await RemoteConfigService.init(isDebug: false);
  await FirebaseServices().init();
  MixPanelService.initMixpanel();
  await DynamicLinkService().init();
  // sl<FirebaseServices>().init();
  // load some data need
  // locator<SessionCache>().init();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Provider<LocalBase>(create: (context) => LocalRepo()),
          Provider<AuthBase>(create: (context) {
            final localBase = sl<LocalBase>();
            return Auth(localBase: localBase);
          }),
          ChangeNotifierProvider<AuthProvider>(create: (context) {
            final auth = Provider.of<AuthBase>(context, listen: false);
            return AuthProvider(auth: auth);
          }),
          Provider<GlobalBase>(create: (_) => GlobalRepo()),
          // ChangeNotifierProvider<NotificationProvider>(create: (ctx) {
          //   return NotificationProvider();
          // }),
        ],
        child: DismissKeyboard(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'geniuspay Mobile App',
            navigatorKey: NavigationServices.navigatorKey,
            theme: AppTheme.light(),
            home: const LandingPage(),
          ),
        ));
  }
}
