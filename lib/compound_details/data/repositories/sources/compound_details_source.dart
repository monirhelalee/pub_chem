import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/app/network_service/api_client.dart';
import 'package:pub_chem/app/network_service/end_points.dart';
import 'package:pub_chem/compound_details/data/cache/compound_cache.dart';
import 'package:pub_chem/compound_details/data/models/compound_model.dart';

abstract class CompoundDetailsSource {
  Future<CompoundModel?> getCompoundDetails(String compoundName);
}

class CompoundDetailsSourceImpl implements CompoundDetailsSource {
  CompoundDetailsSourceImpl();

  @override
  Future<CompoundModel?> getCompoundDetails(String compoundName) async {
    try {
      final cache = sl<CompoundCache>();
      final cached = await cache.get(compoundName);
      if (cached != null) {
        return CompoundModel.fromJson(cached);
      }
      var endPoint = EndPoints.compoundDetails;
      endPoint += '$compoundName/json';
      final response = await sl<ApiClient>().dio.get<Map<String, dynamic>>(
        endPoint,
      );
      if (response.statusCode == 200) {
        final data = response.data!;
        await cache.set(compoundName, data);
        return CompoundModel.fromJson(data);
      } else {
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
