import 'package:flutter/material.dart';

class FirmwareUpgradePage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const FirmwareUpgradePage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('FirmwareUpgradePage')));
  }
}
