import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:geniuspay/models/user.dart';

class ReferModel {
  Future<String> getUrl(User? user) async {
    if (user != null) {
      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse(
            "https://r.geniuspay.me/refer-friend?title=${user.username}"),
        uriPrefix: "https://r.geniuspay.me",
        // androidParameters: const AndroidParameters(
        //   packageName: "com.geniuspay.geniuspay",
        //   minimumVersion: 1,
        // ),
        longDynamicLink: Uri.parse(
            'https://r.geniuspay.me/?link=https://r.geniuspay.me/refer-friend?title=${user.username}&apn=com.geniuspay.geniuspay&ibi=com.geniuspay.geniuspay&isi=1607507940&ofl=https://geniuspay.com&st=geniuspay&sd=Send money to anyone, anywhere, at the lowest transaction fees&si=https://i.ibb.co/D487Xmr/apple-store.png'),
        // iosParameters: const IOSParameters(
        //   bundleId: "com.geniuspay.geniuspay",
        //   minimumVersion: '1',
        //   appStoreId: '1607507940',
        // ),
        // socialMetaTagParameters: SocialMetaTagParameters(
        //     title: 'geniuspay',
        //     imageUrl: Uri.parse('https://i.ibb.co/D487Xmr/apple-store.png'),
        //     description:
        //         'Send money to anyone, anywhere, at the lowest transaction fees'),
      );
      final dynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      return "${dynamicLink.shortUrl}";
    } else {
      return '';
    }
  }
}
