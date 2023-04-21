import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/pages/notifications/notifications_vm.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/notification_message.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NotificationsPage(),
      ),
    );
  }

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String getDate(String givenDate) {
    final date = DateFormat('yyyy-MM-dd hh:mm:ss').parse(givenDate);
    return DateFormat('MMMM dd , yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<NotificationsVM>(onModelReady: (p0) {
      p0.markAllAsRead();
      p0.getNotifications();
    }, builder: (context, model, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.notifications_off,
                              color: AppColor.kSecondaryColor,
                            ),
                            title: const Text('Mute all notifications'),
                          ),
                          if(model.notifications.isNotEmpty)
                          ListTile(
                            onTap: () async {
                              await model.clearAllNotifs();

                              Navigator.pop(context);
                              PopupDialogs(context)
                                  .successMessage('Cleared all notifications');
                            },
                            leading: const Icon(
                              Icons.delete,
                              color: AppColor.kSecondaryColor,
                            ),
                            title: const Text('Clear all'),
                          ),
                        ]),
                      );
                    });
              },
              icon: const Icon(Icons.more_horiz),
              splashRadius: 20,
            )
          ],
        ),
        body: model.notifications.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/home/notification_off.png',
                        width: 32,
                      ),
                      const Gap(10),
                      const Text('You have no notifications at\nthe moment'),
                    ],
                  )
                ],
              )
            : ListView(padding: const EdgeInsets.all(24), children: [
                ElevatedCardBackground(
                    child: Column(children: [
                  const Gap(16),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'All Notifications',
                        style: textTheme.bodyLarge
                            ?.copyWith(color: AppColor.kGreyColor),
                      )),
                  const Gap(16),
                  const Divider(
                    color: AppColor.kSecondaryColor,
                    indent: 5,
                    endIndent: 5,
                  ),
                  for (NotificationMessage message in model.notifications)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.notification_important),
                      title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            message.title ?? '',
                            style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                          )),
                      subtitle: message.dateSent == null
                          ? null
                          : Text(
                              getDate(message.dateSent!),
                              style: textTheme.titleSmall?.copyWith(
                                  color: AppColor.kSecondaryColor,
                                  fontSize: 10),
                            ),
                      trailing: IconButton(
                          onPressed: () async {
                            // model.clearAllNotifs();
                            model.removeNotif(message.id!);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColor.kSecondaryColor,
                            size: 15,
                          )),
                    )
                ]))
              ]),
      );
    });
  }
}
