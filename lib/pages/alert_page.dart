import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  final dynamic device;
  const AlertPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('AlertPage')));
  }
}
