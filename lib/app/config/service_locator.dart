import 'package:get_it/get_it.dart';
import 'package:pub_chem/app/network_service/api_client.dart';
import 'package:pub_chem/app/view/locale/cubit/locale_cubit.dart';
import 'package:pub_chem/app/view/theme/cubit/theme_cubit.dart';
import 'package:pub_chem/compound_details/data/repositories/implementations/compound_details_impl.dart';
import 'package:pub_chem/compound_details/data/repositories/sources/compound_details_source.dart';
import 'package:pub_chem/compound_details/domain/repositories/compound_details_repository.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_bloc.dart';
import 'package:pub_chem/navbar/cubit/navbar_index_cubit.dart';
import 'package:pub_chem/search/data/services/recent_search_service.dart';
import 'package:pub_chem/splash/view/bloc/splash_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl
    ..registerFactory<SplashBloc>(SplashBloc.new)
    ..registerLazySingleton<CompoundDetailsSource>(
      CompoundDetailsSourceImpl.new,
    )
    ..registerLazySingleton<CompoundDetailsRepository>(
      CompoundDetailsImpl.new,
    )
    ..registerFactory<CompoundDetailsBloc>(CompoundDetailsBloc.new)
    ..registerLazySingleton<ApiClient>(ApiClient.new)
    ..registerSingleton<NavbarIndexCubit>(NavbarIndexCubit())
    ..registerSingleton<ThemeCubit>(ThemeCubit())
    ..registerSingleton<LocaleCubit>(LocaleCubit())
    ..registerLazySingleton<RecentSearchService>(RecentSearchService.new);
}
