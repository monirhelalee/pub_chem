import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';

part 'compound_details_state.freezed.dart';

@freezed
class CompoundDetailsState with _$CompoundDetailsState {
  const factory CompoundDetailsState.initial() = _Initial;

  const factory CompoundDetailsState.loading() = _Loading;

  const factory CompoundDetailsState.loaded({required Compound compound}) =
      _Loaded;

  const factory CompoundDetailsState.error({required String message}) = _Error;
}
