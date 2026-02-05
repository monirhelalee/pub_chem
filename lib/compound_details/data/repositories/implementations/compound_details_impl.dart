import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/compound_details/data/repositories/sources/compound_details_source.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';
import 'package:pub_chem/compound_details/domain/repositories/compound_details_repository.dart';

class CompoundDetailsImpl implements CompoundDetailsRepository {
  @override
  Future<Compound> getCompoundDetails(String compoundName) async {
    final response = await sl<CompoundDetailsSource>().getCompoundDetails(compoundName);
    return response!.toEntity();
  }
}
