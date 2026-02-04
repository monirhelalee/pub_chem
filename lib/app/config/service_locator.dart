import 'package:get_it/get_it.dart';
import 'package:pub_chem/app/view/theme/cubit/theme_cubit.dart';
import 'package:pub_chem/navbar/cubit/navbar_index_cubit.dart';
import 'package:pub_chem/splash/view/bloc/splash_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Blocs
  sl
    ..registerFactory(SplashBloc.new)
    ..registerSingleton<NavbarIndexCubit>(NavbarIndexCubit())
    ..registerSingleton<ThemeCubit>(ThemeCubit());
}
