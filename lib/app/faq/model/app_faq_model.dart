enum FAQType { app, account, payments, security, all, other, payinout }

extension ParseToString on FAQType {
  String toShortString() {
    switch (this) {
      case FAQType.app:
        return 'App';
      case FAQType.account:
        return 'Account';
      case FAQType.payments:
        return 'Payments';
      case FAQType.security:
        return 'Security';
      case FAQType.all:
        return 'All';
      case FAQType.other:
        return 'Other';
      case FAQType.payinout:
        return 'Deposits / Withdrawals';
    }
  }
}

class FAQQuestion {
  const FAQQuestion({
    required this.id,
    required this.discription,
    required this.question,
    required this.type,
  });

  factory FAQQuestion.fromJson(Map<String, String> json) => FAQQuestion(
        id: json['id']!,
        discription: json['discription']!,
        question: json['title']!,
        type: json['type']! as FAQType,
      );

  final String id;
  final String question;
  final String discription;
  final FAQType type;

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'discription': discription,
        'type': type,
      };
}
