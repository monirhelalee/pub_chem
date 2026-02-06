import 'package:flutter/material.dart';
import 'package:pub_chem/l10n/l10n.dart';
import 'package:pub_chem/more/view/widgets/app_info_widget.dart';
import 'package:pub_chem/more/view/widgets/language_widget.dart';
import 'package:pub_chem/more/view/widgets/theme_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.moreScreenTitle),
      ),
      body: _body(context),
    );
  }
}

Widget _body(BuildContext context) {
  return ListView(
    padding: const .all(16),
    children: const [
      LanguageWidget(),
      SizedBox(height: 16),
      ThemeWidget(),
      SizedBox(height: 16),
      AppInfoWidget(),
    ],
  );
}
