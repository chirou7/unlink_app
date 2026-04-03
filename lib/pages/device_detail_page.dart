import 'package:flutter/material.dart';

class DeviceDetailPage extends StatelessWidget {
  final dynamic device;
  const DeviceDetailPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('DeviceDetailPage')));
  }
}
