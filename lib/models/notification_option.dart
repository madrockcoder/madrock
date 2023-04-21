import 'dart:convert';

class NotificationOption {
  final String? id;
  final bool? accountNotification;
  final bool? newFeatures;
  final bool? salesNews;
  final bool? accountTips;
  final bool? analytics;
  final bool? performance;
  final bool? targeting;
  final bool? smsOffers;
  final bool? partnerOffers;
  final bool? pushNotificationOffers;
  final bool? emailOffers;
  final bool? unusualActivity;

  const NotificationOption({
    this.id,
    this.accountNotification,
    this.newFeatures,
    this.salesNews,
    this.accountTips,
    this.analytics,
    this.performance,
    this.targeting,
    this.smsOffers,
    this.partnerOffers,
    this.pushNotificationOffers,
    this.emailOffers,
    this.unusualActivity,
  });

  Map<String, dynamic> toMap() {
    return {
      if (accountNotification != null)
        'account_notification': accountNotification,
      if (newFeatures != null) 'new_features': newFeatures,
      if (salesNews != null) 'sales_news': salesNews,
      if (accountTips != null) 'account_tips': accountTips,
      if (analytics != null) 'analytics': analytics,
      if (performance != null) 'performance': performance,
      if (targeting != null) 'targetting': targeting,
      if (smsOffers != null) 'sms_offers': smsOffers,
      if (partnerOffers != null) 'partner_offers': partnerOffers,
      if (pushNotificationOffers != null)
        'push_notification_offers': pushNotificationOffers,
      if (emailOffers != null) 'email_offers': emailOffers,
      if (unusualActivity != null) 'unusual_activity': unusualActivity
    };
  }

  factory NotificationOption.fromMap(Map<String, dynamic> map) {
    return NotificationOption(
        id: map['id'],
        accountNotification: map['account_notification'] ?? false,
        newFeatures: map['new_features'] ?? false,
        salesNews: map['sales_news'] ?? false,
        accountTips: map['account_tips'] ?? false,
        analytics: map['analytics'] ?? false,
        performance: map['performance'] ?? false,
        targeting: map['targetting'] ?? false,
        smsOffers: map['sms_offers'] ?? false,
        partnerOffers: map['partner_offers'] ?? false,
        pushNotificationOffers: map['push_notification_offers'] ?? false,
        emailOffers: map['email_offers'] ?? false,
        unusualActivity: map['unusual_activity'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory NotificationOption.fromJson(String source) =>
      NotificationOption.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationOption(accountNotification: $accountNotification, newFeatures: $newFeatures, salesNews: $salesNews, accountTips: $accountTips, analytics: $analytics, performance: $performance, targeting: $targeting, smsOffers: $smsOffers, partnerOffers: $partnerOffers, pushNotificationOffers: $pushNotificationOffers, emailOffers: $emailOffers)';
  }
}
