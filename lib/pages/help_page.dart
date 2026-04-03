import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const HelpPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('HelpPage')));
  }
}
