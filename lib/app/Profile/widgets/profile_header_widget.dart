import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/profile_page_vm.dart';
import 'package:geniuspay/app/Profile/refer/view_model/refer_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({Key? key}) : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  String _getName(User user) {
    if (user.firstName.isEmpty && user.lastName.isEmpty) {
      return 'Rockstar';
    } else {
      return "${user.firstName} ${user.lastName}";
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<ProfilePageVM>(builder: (context, model, snapshot) {
      User user = model.user;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: 'edit_header',
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        onUpdateProfileImageClicked(model);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/edits.svg'),
                          const Gap(2),
                          Text(
                            'Edit',
                            style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                          )
                        ],
                      )))),
          const Gap(32),
          Hero(
              tag: 'profile_header',
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onUpdateProfileImageClicked(model);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(8.2),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/circle.png'),
                        ),
                      ),
                      child: Stack(children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColor.kAccentColor3,
                            foregroundImage:
                                CachedNetworkImageProvider(user.avatar)),
                        if (loading)
                          const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: AppColor.kSecondaryColor,
                              ))
                      ]),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    _getName(user),
                    style: textTheme.bodyLarge?.copyWith(fontSize: 16),
                  ),
                  Text(
                    "@${user.username}",
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppColor.kSecondaryColor,
                    ),
                  ),
                ],
              )),
          const Gap(32),
          Hero(
              tag: 'link_header',
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () async {
                        final result = await ReferModel().getUrl(user);
                        Clipboard.setData(ClipboardData(text: result));
                        PopupDialogs(context)
                            .successMessage('Copied referral url');
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/link.svg'),
                          const Gap(2),
                          Text(
                            'Link',
                            style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                          )
                        ],
                      )))),
        ],
      );
    });
  }

  onUpdateProfileImageClicked(model) {
    final textTheme = Theme.of(context).textTheme;
    showCustomScrollableSheet(
        context: context,
        child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Upload avatar',
                  style: textTheme.displaySmall
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
                const Gap(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          final result = await ImagePicker().pickImage(
                              source: ImageSource.camera,
                              preferredCameraDevice: CameraDevice.front,
                              maxHeight: 500,
                              maxWidth: 500);
                          if (result != null) {
                            Navigator.pop(context);
                            final bytes = await result.readAsBytes();
                            String img64 = base64Encode(bytes);
                            setState(() {
                              loading = true;
                            });
                            await model.uploadAvatar(context, img64);
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColor.kAccentColor2,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.photo_camera,
                                  size: 32,
                                ),
                                Gap(8),
                                Text('Camera')
                              ]),
                        )),
                    const Gap(16),
                    InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          final result = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 500,
                              maxWidth: 500,);
                          if (result != null) {
                            Navigator.pop(context);
                            final bytes = await result.readAsBytes();
                            String img64 = base64Encode(bytes);
                            setState(() {
                              loading = true;
                            });
                            await model.uploadAvatar(context, img64);
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColor.kAccentColor2,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.photo_fill,
                                  size: 32,
                                ),
                                Gap(8),
                                Text('Gallery')
                              ]),
                        ))
                  ],
                ),
                const Gap(32),
              ],
            )));
  }
}
