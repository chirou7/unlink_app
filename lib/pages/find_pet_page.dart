import 'package:flutter/material.dart';

class FindPetPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const FindPetPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('FindPetPage')));
  }
}
