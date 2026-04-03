import 'package:flutter/material.dart';

enum PetType { dog, cat }

class PetBreedSelectionPage extends StatefulWidget {
  final String? currentSelectedName;
  final PetType? defaultType;

  const PetBreedSelectionPage({
    super.key,
    this.currentSelectedName,
    this.defaultType,
  });

  @override
  State<PetBreedSelectionPage> createState() => _PetBreedSelectionPageState();
}

class _PetBreedSelectionPageState extends State<PetBreedSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Breed Selection')));
  }
}
