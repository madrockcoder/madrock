class SourceOfFunds {
  final String title;
  final String requestText;
  bool isSourceOfFund;
  SourceOfFunds({
    required this.title,
    required this.requestText,
    this.isSourceOfFund = false,
  });

  @override
  String toString() => 'SourceOfFunds(title: $title, requestText: $requestText, isSourceOfFund: $isSourceOfFund)';
}
