import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/compound_details/domain/repositories/compound_details_repository.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_event.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_state.dart';

class CompoundDetailsBloc
    extends Bloc<CompoundDetailsEvent, CompoundDetailsState> {
  CompoundDetailsBloc({
    CompoundDetailsRepository? repository,
  }) : _repository = repository ?? sl<CompoundDetailsRepository>(),
       super(const CompoundDetailsState.initial()) {
    on<LoadCompoundDetails>(_onLoadCompoundDetails);
  }

  final CompoundDetailsRepository _repository;

  Future<void> _onLoadCompoundDetails(
    LoadCompoundDetails loadEvent,
    Emitter<CompoundDetailsState> emit,
  ) async {
    emit(const CompoundDetailsState.loading());
    try {
      final compound = await _repository.getCompoundDetails(loadEvent.compoundName);
      emit(CompoundDetailsState.loaded(compound: compound));
    } catch (e) {
      emit(
        CompoundDetailsState.error(
          message: e.toString(),
        ),
      );
    }
  }
}
