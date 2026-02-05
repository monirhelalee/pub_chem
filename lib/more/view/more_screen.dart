import 'package:flutter/material.dart';
import 'package:pub_chem/more/view/widgets/app_info_widget.dart';
import 'package:pub_chem/more/view/widgets/theme_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: _body(context),
    );
  }
}

Widget _body(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const ThemeWidget(),
      const SizedBox(height: 16),
      AppInfoWidget(),
    ],
  );
}
