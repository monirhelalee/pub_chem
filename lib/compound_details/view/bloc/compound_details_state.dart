import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';

part 'compound_details_state.freezed.dart';

@freezed
class CompoundDetailsState with _$CompoundDetailsState {
  const factory CompoundDetailsState.initial() = CompoundDetailsInitial;
  const factory CompoundDetailsState.loading() = CompoundDetailsLoading;
  const factory CompoundDetailsState.loaded({
    required Compound compound,
  }) = CompoundDetailsLoaded;
  const factory CompoundDetailsState.error({
    required String message,
  }) = CompoundDetailsError;
}
