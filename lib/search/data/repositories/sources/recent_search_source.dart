import 'package:pub_chem/search/data/model/recent_search_model.dart';
import 'package:pub_chem/search/data/services/recent_search_service.dart';

abstract class RecentSearchSource {
  Future<List<RecentSearchModel>> getRecentSearchData();
}

class RecentSearchSourceImpl implements RecentSearchSource {
  @override
  Future<List<RecentSearchModel>> getRecentSearchData() async {
    try {
      return RecentSearchService().getRecentSearches();
    } catch (e) {
      rethrow;
    }
  }
}
