import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/app/network_service/api_client.dart';
import 'package:pub_chem/app/network_service/end_points.dart';
import 'package:pub_chem/compound_details/data/models/compound_model.dart';

abstract class CompoundDetailsSource {
  Future<CompoundModel?> getCompoundDetails(String compoundName);
}

class CompoundDetailsSourceImpl implements CompoundDetailsSource {
  @override
  Future<CompoundModel?> getCompoundDetails(String compoundName) async {
    try {
      var endPoint = EndPoints.compoundDetails;
      endPoint += '$compoundName/json';
      final response = await sl<ApiClient>().dio.get<Map<String, dynamic>>(
        endPoint,
      );
      if (response.statusCode == 200) {
        return CompoundModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
