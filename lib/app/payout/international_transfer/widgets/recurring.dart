
class Recurring {
  bool isRecurring;
  String firstPayment;
  String frequency;
  String lastPayment;

  Recurring(
      {required this.isRecurring,
      required this.firstPayment,
      required this.frequency,
      required this.lastPayment});
}
