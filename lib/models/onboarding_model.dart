import 'package:equatable/equatable.dart';

class Onboard extends Equatable {
  final String? image;
  final String title;
  final String subTitle;
  const Onboard({
    this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  List<Object> get props => [image ?? '', title];

  @override
  String toString() => 'Onboard(image: $image, title: $title)';
}
