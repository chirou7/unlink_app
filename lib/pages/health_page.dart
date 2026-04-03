import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const HealthPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('HealthPage')));
  }
}
