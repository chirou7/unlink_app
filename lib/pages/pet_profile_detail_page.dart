import 'package:flutter/material.dart';
import '../models/device_model.dart';

class PetProfileDetailPage extends StatelessWidget {
  const PetProfileDetailPage({super.key, required DeviceModel device});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Pet Profile Detail')));
}
