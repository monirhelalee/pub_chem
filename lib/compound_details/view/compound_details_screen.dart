import 'package:flutter/material.dart';

class CompoundDetailsScreen extends StatefulWidget {
  const CompoundDetailsScreen({
    required this.compoundName,
    super.key,
  });

  final String compoundName;

  @override
  State<CompoundDetailsScreen> createState() => _CompoundDetailsScreenState();
}

class _CompoundDetailsScreenState extends State<CompoundDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.compoundName),
      ),
    );
  }
}
