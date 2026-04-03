import 'package:flutter/material.dart';

class PetDetailPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const PetDetailPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('PetDetailPage')));
  }
}
