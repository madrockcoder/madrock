import 'package:flutter/material.dart';

class PaymentLinkPage extends StatelessWidget {
  const PaymentLinkPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PaymentLinkPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
