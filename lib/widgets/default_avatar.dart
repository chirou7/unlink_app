import 'package:flutter/material.dart';

class DefaultAvatarWidget extends StatelessWidget {
  final double size;
  const DefaultAvatarWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) =>
      Container(width: size, height: size, color: Colors.grey);
}
