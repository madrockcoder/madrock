import 'package:equatable/equatable.dart';

class Reason extends Equatable {
  final String id;
  final String title;
  final String iconImage;
  final String reason;
  const Reason({
    required this.id,
    required this.title,
    required this.iconImage,
    required this.reason,
  });
  @override
  List<Object> get props => [id, title, iconImage, reason];

  @override
  String toString() {
    return 'Reason(id: $id, title: $title, iconImage: $iconImage, reason: $reason)';
  }
}
