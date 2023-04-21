import 'package:equatable/equatable.dart';

enum CardType { standard, platinum, gold }

class BankCard extends Equatable {
  final String cardNumber;
  final String expiryDate;
  final String cardHolder;
  final CardType cardType;

  const BankCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolder,
    required this.cardType,
  });

  @override
  List<Object> get props => [cardNumber, expiryDate, cardHolder, cardType];

  @override
  String toString() {
    return 'Card(cardNumber: $cardNumber, expiryDate: $expiryDate, cardHolder: $cardHolder, cardType: $cardType)';
  }

  BankCard copyWith({
    String? cardNumber,
    String? expiryDate,
    String? cardHolder,
    CardType? cardType,
  }) {
    return BankCard(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardHolder: cardHolder ?? this.cardHolder,
      cardType: cardType ?? this.cardType,
    );
  }
}
