import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const OrdersPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('OrdersPage')));
  }
}
