import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:http/http.dart' as http;
import 'package:geniuspay/util/color_scheme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExportPDFBottomSheet extends StatefulWidget {
  const ExportPDFBottomSheet({Key? key}) : super(key: key);

  @override
  State<ExportPDFBottomSheet> createState() => _ExportPDFBottomSheetState();
}

class _ExportPDFBottomSheetState extends State<ExportPDFBottomSheet> {
  String get url => "http://africau.edu/images/default/sample.pdf";
  File? pdfFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              const Spacer(),
              const Text(
                "Export account details",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.kOnPrimaryTextColor2),
              ),
              const Spacer(),
              const HelpIconButton(),
            ],
          ),
          const Gap(44),
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  color: Colors.grey.withOpacity(.1),
                  offset: const Offset(0, 8),
                )
              ]),
              child: WebView(
                initialUrl: url,
                onPageStarted: (value) async {
                  final response = await http.get(Uri.parse(url));
                  if (response.statusCode == 200) {
                    final documentDirectory =
                        (await getTemporaryDirectory()).path;
                    File _pdfFile =
                        File('$documentDirectory/Account-Details.pdf');
                    _pdfFile.writeAsBytesSync(response.bodyBytes);
                    setState(() {
                      pdfFile = _pdfFile;
                    });
                  }
                },
                javascriptMode: JavascriptMode.unrestricted,
              ),
              // child: const PDF(
              //   swipeHorizontal: true,
              //   fitEachPage: true,
              //   enableSwipe: true,
              // ).cachedFromUrl('http://africau.edu/images/default/sample.pdf'),
            ),
          ),
          const Gap(64),
          CustomYellowElevatedButton(
            text: "EXPORT PDF",
            disable: pdfFile==null,
            onTap: () {
              if (pdfFile != null) {
                Share.shareFiles([pdfFile!.path],
                    subject: "My geniuspay Account Details");
              }
            },
          )
        ],
      ),
    );
  }
}
