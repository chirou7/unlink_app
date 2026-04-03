import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final dynamic device;
  const AboutPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('AboutPage')));
  }
}
