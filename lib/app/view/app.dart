import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/app/router/app_router.dart';
import 'package:pub_chem/app/view/theme/config/app_theme.dart';
import 'package:pub_chem/app/view/theme/cubit/theme_cubit.dart';
import 'package:pub_chem/app/view/theme/models/app_theme_mode.dart';
import 'package:pub_chem/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, themeMode) {
          final themeCubit = context.read<ThemeCubit>();
          return MaterialApp.router(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeCubit.getThemeMode(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
