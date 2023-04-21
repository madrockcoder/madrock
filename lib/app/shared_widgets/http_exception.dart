class CustomHttpException implements Exception {
  final String title;
  final String message;
  CustomHttpException({
    required this.title,
    required this.message,
  });

  @override
  String toString() {
    return 'Title: $title, Message: $message';
  }
}
