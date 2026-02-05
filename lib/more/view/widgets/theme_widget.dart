import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/view/theme/cubit/theme_cubit.dart';
import 'package:pub_chem/app/view/theme/models/app_theme_mode.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Theme',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<ThemeCubit, AppThemeMode>(
              builder: (context, currentTheme) {
                return Column(
                  children: AppThemeMode.values.map((theme) {
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
                          Text(theme.name),
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
