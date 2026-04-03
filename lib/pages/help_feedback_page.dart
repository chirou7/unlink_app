import 'package:flutter/material.dart';

class HelpFeedbackPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const HelpFeedbackPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('HelpFeedbackPage')));
  }
}
