import 'package:bloc/bloc.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/search/domain/repositories/recent_search_repository.dart';
import 'package:pub_chem/search/view/bloc/recent_search_event.dart';
import 'package:pub_chem/search/view/bloc/recent_search_state.dart';

class RecentSearchBloc extends Bloc<RecentSearchEvent, RecentSearchState> {
  RecentSearchBloc() : super(const RecentSearchState.initial()) {
    on<LoadRecentSearchEvent>((event, emit) async {
      emit(const RecentSearchState.loading());
      try {
        final recentSearches = await sl<RecentSearchRepository>()
            .getRecentSearchData();
        emit(RecentSearchState.loaded(recentSearches: recentSearches));
      } on Exception catch (e) {
        emit(RecentSearchState.error(message: e.toString()));
      }
    });
  }
}
