import 'package:pub_chem/compound_details/domain/entities/compound.dart';

abstract class CompoundDetailsRepository {
  Future<Compound> getCompoundDetails(String compoundName);
}
