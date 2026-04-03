import 'package:flutter/material.dart';

class AddDevicePage extends StatelessWidget {
  final dynamic device;
  const AddDevicePage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('AddDevicePage')));
  }
}
