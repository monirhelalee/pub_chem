import 'package:freezed_annotation/freezed_annotation.dart';

part 'compound.freezed.dart';

@freezed
abstract class Compound with _$Compound {
  const factory Compound({
    required int cid,
    required String name,
    required String molecularFormula,
    required double molecularWeight,
    required String smiles,
    String? description,
  }) = _Compound;
}
