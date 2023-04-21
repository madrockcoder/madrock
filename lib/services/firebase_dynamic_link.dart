import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  static String _inviteCode = '';
  static String get inviteCode => _inviteCode;
  Future<void> init() async {
    try {
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (initialLink != null) {
        _inviteCode = initialLink.link.queryParameters['title'] ?? '';
      }
      FirebaseDynamicLinks.instance.onLink
          .listen((PendingDynamicLinkData dynamicLinkData) {
        _inviteCode = dynamicLinkData.link.queryParameters['title'] ?? '';
      }).onError((error) {
        // Handle errors
      });
    } catch (e) {}
  }
}
