import 'package:pub_chem/search/domain/entities/recent_search.dart';

abstract class RecentSearchRepository {
  Future<List<RecentSearch>> getRecentSearchData();
}
