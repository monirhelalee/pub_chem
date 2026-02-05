import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/view/locale/cubit/locale_cubit.dart';
import 'package:pub_chem/l10n/l10n.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      elevation: .5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 8),
                Text(
                  l10n.languageTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<LocaleCubit, Locale>(
              builder: (context, currentLocale) {
                const supportedLocales = AppLocalizations.supportedLocales;
                return Column(
                  children: supportedLocales.map((locale) {
                    String languageName;
                    switch (locale.languageCode) {
                      case 'en':
                        languageName = l10n.languageEnglish;
                        break;
                      case 'bn':
                        languageName = l10n.languageBengali;
                        break;
                      default:
                        languageName = locale.languageCode.toUpperCase();
                    }
                    return RadioListTile<Locale>(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.translate,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(languageName),
                        ],
                      ),
                      value: locale,
                      groupValue: currentLocale,
                      onChanged: (value) async {
                        if (value != null) {
                          await context.read<LocaleCubit>().setLocale(value);
                        }
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
