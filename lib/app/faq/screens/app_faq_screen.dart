// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/faq/faqquestions/app_faq_data.dart';
import 'package:geniuspay/app/faq/faqquestions/myaccount_faq_data.dart';
import 'package:geniuspay/app/faq/faqquestions/payments_faq_data.dart';
import 'package:geniuspay/app/faq/faqquestions/security_faq_data.dart';
import 'package:geniuspay/app/faq/faqquestions/other_faq_data.dart';
import 'package:geniuspay/app/faq/faqquestions/payinout_faq_data.dart';
import 'package:geniuspay/app/faq/model/app_faq_model.dart';

import 'package:geniuspay/app/faq/screens/app_faq_preview.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';

import 'package:geniuspay/util/color_scheme.dart';

TextEditingController searchController = TextEditingController();

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class AppFAQ extends StatefulWidget {
  final FAQType type;
  final bool autofocus;
  const AppFAQ({Key? key, required this.type, this.autofocus = false})
      : super(key: key);
  static Future<void> show(
      {required BuildContext context,
      required FAQType type,
      bool? autofocus}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppFAQ(
          type: type,
          autofocus: autofocus ?? false,
        ),
      ),
    );
  }

  @override
  State<AppFAQ> createState() => _AppFAQState();
}

class _AppFAQState extends State<AppFAQ> {
  late List<FAQQuestion> questions;
  String query = '';

  @override
  void initState() {
    super.initState();
    questions = getQuestions(widget.type);
  }

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  List<FAQQuestion> getQuestions(FAQType type) {
    switch (widget.type) {
      case FAQType.app:
        return allAppQuestions;

      case FAQType.account:
        return allAccountQuestions;

      case FAQType.payments:
        return allPaymentQuestions;

      case FAQType.security:
        return allSecurityQuestions;

      case FAQType.other:
        return allOtherQuestions;

      case FAQType.payinout:
        return allPayInOutQuestions;

      case FAQType.all:
        return allAppQuestions +
            allAccountQuestions +
            allPaymentQuestions +
            allSecurityQuestions +
            allOtherQuestions +
            allPayInOutQuestions;
    }
  }

  final _searchFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.close, color: Color(0xff111111), size: 20),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Column(
          children: [
            SizedBox(
                height: 40,
                child: TextFormField(
                  autofocus: widget.autofocus,
                  controller: searchController,
                  decoration: TextFieldDecoration(
                    focusNode: _searchFocus,
                    context: context,
                    hintText: 'Search',
                    clearSize: 8,
                    prefix: const Icon(
                      CupertinoIcons.search,
                      color: AppColor.kSecondaryColor,
                      size: 18,
                    ),
                    onClearTap: () {
                      searchController.clear();
                      setState(() {
                        questions = getQuestions(widget.type);
                      });
                    },
                    controller: searchController,
                  ).inputDecoration(),
                  focusNode: _searchFocus,
                  keyboardType: TextInputType.name,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (val) {
                    setState(() {
                      searchQuestion(val);
                    });
                  },
                )),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                widget.type.toShortString(),
                style: textTheme.bodyLarge
                    ?.copyWith(color: AppColor.kSecondaryColor),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final FAQQuestions = questions[index];

                  return Column(children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AppFAQPreview(
                                      id: FAQQuestions.id,
                                      question: FAQQuestions.question,
                                      discription: FAQQuestions.discription,
                                      questions: getQuestions(widget.type),
                                    ))));
                      },
                      contentPadding: EdgeInsets.only(right: 0),
                      title: Text(FAQQuestions.question,
                          style: textTheme.bodyMedium?.copyWith(
                              color: AppColor.kOnPrimaryTextColor,
                              fontSize: 16)),
                      trailing: SvgPicture.asset(
                        'assets/faq/Arrow - Down.svg',
                        width: 14.0,
                        height: 14.0,
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Color(0xffE0F7FE),
                      thickness: 1,
                    )
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchQuestion(String query) {
    final questions = getQuestions(widget.type).where((q) {
      final titleLower = q.question.toLowerCase();

      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.questions = questions;
    });
  }
}
