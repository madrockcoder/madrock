class SubscriptionModal {
  SubscriptionModal({
    required this.name,
    required this.offers,
    this.best,
    this.fee,
  });

  final String name;
  final String? fee;
  final String? best;
  final List<String> offers;
}
