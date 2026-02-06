import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/search/data/repositories/sources/recent_search_source.dart';
import 'package:pub_chem/search/domain/entities/recent_search.dart';
import 'package:pub_chem/search/domain/repositories/recent_search_repository.dart';

class RecentSearchImpl implements RecentSearchRepository {
  @override
  Future<List<RecentSearch>> getRecentSearchData() async {
    final response = await sl<RecentSearchSource>().getRecentSearchData();
    return response.map((e) => e.toEntity()).toList();
  }
}
