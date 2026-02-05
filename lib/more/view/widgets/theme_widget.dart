import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/view/theme/cubit/theme_cubit.dart';
import 'package:pub_chem/app/view/theme/models/app_theme_mode.dart';
import 'package:pub_chem/l10n/l10n.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

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
                const Icon(Icons.palette),
                const SizedBox(width: 8),
                Text(
                  l10n.themeTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<ThemeCubit, AppThemeMode>(
              builder: (context, currentTheme) {
                return Column(
                  children: AppThemeMode.values.map((theme) {
                    String themeLabel;
                    switch (theme) {
                      case AppThemeMode.light:
                        themeLabel = l10n.themeLight;
                        break;
                      case AppThemeMode.dark:
                        themeLabel = l10n.themeDark;
                        break;
                      case AppThemeMode.system:
                        themeLabel = l10n.themeSystem;
                        break;
                    }
                    return RadioListTile<AppThemeMode>(
                      title: Row(
                        children: [
                          Icon(
                            theme == AppThemeMode.light
                                ? Icons.light_mode
                                : theme == AppThemeMode.dark
                                ? Icons.dark_mode
                                : Icons.brightness_auto,
                          ),
                          const SizedBox(width: 8),
                          Text(themeLabel),
                        ],
                      ),
                      value: theme,
                      groupValue: currentTheme,
                      onChanged: (value) async {
                        if (value != null) {
                          await context.read<ThemeCubit>().setTheme(
                            value,
                          );
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
