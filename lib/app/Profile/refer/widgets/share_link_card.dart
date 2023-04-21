import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/refer/view_model/refer_model.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';

import 'package:geniuspay/util/color_scheme.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

class ShareLinkCard extends StatefulWidget {
  const ShareLinkCard({Key? key}) : super(key: key);

  @override
  State<ShareLinkCard> createState() => _ShareLinkCardState();
}

class _ShareLinkCardState extends State<ShareLinkCard> {
  @override
  void initState() {
    getUrl();
    super.initState();
  }

  String url = '';
  getUrl() async {
    final AuthenticationService _authenticationService =
        sl<AuthenticationService>();
    final result = await ReferModel().getUrl(_authenticationService.user);
    setState(() {
      url = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColor.kAccentColor3,
                height: 3,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
            Text(
              'Share your link',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Expanded(
              child: Divider(
                color: AppColor.kAccentColor3,
                height: 3,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColor.kAccentColor2,
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Text(
              url,
              style: textTheme.bodyMedium
                  ?.copyWith(color: AppColor.kSecondaryColor),
            )),
            TextButton.icon(
                onPressed: () async {
                  Share.share(
                    'Sign up with geniuspay via this link $url and get 20\$!',
                  );
                },
                icon: const Icon(
                  Ionicons.share_social,
                  color: AppColor.kSecondaryColor,
                  size: 12,
                ),
                label: Text(
                  'Share',
                  style: textTheme.titleMedium
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ))
          ]),
        )
      ],
    );
  }
}
