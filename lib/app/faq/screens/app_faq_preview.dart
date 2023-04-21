// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/live_support_chat_widget.dart';
import 'package:geniuspay/app/faq/model/app_faq_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AppFAQPreview extends StatefulWidget {
  String id;
  String question;
  String discription;
  List<FAQQuestion> questions;
  AppFAQPreview(
      {Key? key,
      required this.id,
      required this.question,
      required this.discription,
      required this.questions})
      : super(key: key);

  @override
  State<AppFAQPreview> createState() => _AppFAQPreviewState();
}

class _AppFAQPreviewState extends State<AppFAQPreview> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.question,
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 16),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 15),
                child: Text(widget.discription,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor)),
              ),
              Gap(12),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  'Related articles',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
              ),
              for (FAQQuestion question in widget.questions)
                if (question.id != widget.id)
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AppFAQPreview(
                                    id: question.id,
                                    question: question.question,
                                    discription: question.discription,
                                    questions: widget.questions))));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                question.question,
                                maxLines: 4,
                                style: textTheme.bodyMedium?.copyWith(
                                    color: AppColor.kOnPrimaryTextColor),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/faq/Arrow - Down.svg',
                              width: 14.0,
                              height: 14.0,
                            ),
                          ],
                        ),
                      )),
              Divider(
                height: 5,
                color: Color(0xffE0F7FE),
                thickness: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  'Didn\'t find what you were looking for?',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
              ),
              Gap(8),
              LiveSupportChatWidget(),
              Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
