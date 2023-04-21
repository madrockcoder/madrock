import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewTemplate extends StatefulWidget {
  final String url;
  final String completedUrl;
  const PaymentWebViewTemplate(
      {Key? key, required this.url, required this.completedUrl})
      : super(key: key);
  static Future<void> show(
      BuildContext context, String url, String completedUrl) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentWebViewTemplate(
          url: url,
          completedUrl: completedUrl,
        ),
      ),
    );
  }

  @override
  State<PaymentWebViewTemplate> createState() => _PaymentWebViewTemplateState();
}

class _PaymentWebViewTemplateState extends State<PaymentWebViewTemplate> {
  bool _loading = true;
  bool popped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Platform.isIOS
            ? AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              )
            : null,
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: WebView(
                initialUrl: widget.url,
                onPageFinished: (value) {
                  if (_loading) {
                    setState(() {
                      _loading = false;
                    });
                  }
                  if (value.startsWith(widget.completedUrl) && !popped) {
                    setState(() {
                      popped = true;
                    });
                    Navigator.pop(context, value);
                  }
                },
                onPageStarted: (value) {
                  if (value.startsWith(widget.completedUrl) && !popped) {
                    setState(() {
                      popped = true;
                    });
                    Navigator.pop(context, value);
                  }
                },
                javascriptMode: JavascriptMode.unrestricted,
              )),
          if (_loading) const Center(child: CircularProgressIndicator()),
        ]));
  }
}
