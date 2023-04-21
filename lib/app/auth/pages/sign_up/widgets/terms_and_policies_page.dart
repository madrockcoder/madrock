import 'package:flutter/material.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndPoliciesPage extends StatefulWidget {
  const TermsAndPoliciesPage({Key? key, this.title, required this.policy})
      : super(key: key);
  final String? title;
  final Policy policy;

  static Future<void> show(BuildContext context,
      {String? title = 'Terms & Conditions', required Policy policy}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TermsAndPoliciesPage(title: title, policy: policy),
      ),
    );
  }

  @override
  State<TermsAndPoliciesPage> createState() => _TermsAndPoliciesPageState();
}

class _TermsAndPoliciesPageState extends State<TermsAndPoliciesPage> {
  String get url {
    switch (widget.policy) {
      case Policy.termsAndConditions:
        return 'https://geniuspay.com/legal/terms-of-service';
      case Policy.amlPolicy:
        return 'https://geniuspay.com/legal/aml-policy';
      case Policy.privacyPolicy:
        return 'https://geniuspay.com/legal/privacy-policy';
      case Policy.referalTerms:
        return 'https://geniuspay.com/legal/referral-terms';
    }
  }

  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xffD0F3FE)),
      body: Stack(alignment: Alignment.center, children: [
        WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (val) {
            setState(() {
              _loading = false;
            });
          },
        ),
        if (_loading) const CircularProgressIndicator()
      ]),
    );
  }
}
  // late WebViewController _webViewController;

        // onWebViewCreated: (WebViewController webViewController) {
        //   _webViewController = webViewController;
        //   _loadHtmlFromAssets();
        // },

  // Future<void> _loadHtmlFromAssets() async {
  //   String fileHtmlContents = await rootBundle.loadString(widget.filePath!);
  //   _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
  // }