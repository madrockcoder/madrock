class NotificationMessage {
  String? id;
  String? title;
  String? body;
  dynamic type;
  String? dateSent;
  String? read;

  NotificationMessage.fromJson(Map<String, dynamic> message) {
    id = message['id'];
    title = message['title'];
    body = message['body'];
    dateSent = message['dateSent'];
    type = message['type'];
    read = message['read'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'dateSent': dateSent,
      'type': type,
      'read': read,
    };
  }
}

// class NotificationMessage {
//   String title;
//   String body;
//   String? type;
//   DateTime dateSent;
//   bool read;
//   NotificationMessage(
//       {required this.title,
//       required this.body,
//       this.type,
//       required this.dateSent,
//       required this.read});

//        fromJsom(Map<String, dynamic> message) {
//     title = message['title'];
//     body = message['content'];
//     dateSent = message['dateSent'];
//     type = message['type'];
//     read = message['read'];
//     id = message['id'];
//     transactionId = message['transactionId'];
//   }
// }
