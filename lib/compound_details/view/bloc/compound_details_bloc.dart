import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/compound_details/domain/repositories/compound_details_repository.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_event.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_state.dart';

class CompoundDetailsBloc
    extends Bloc<CompoundDetailsEvent, CompoundDetailsState> {
  CompoundDetailsBloc() : super(const CompoundDetailsState.initial()) {
    on<LoadCompoundDetailsEvent>((event, emit) async {
      emit(const CompoundDetailsState.loading());
      try {
        final compound = await sl<CompoundDetailsRepository>()
            .getCompoundDetails(
              event.compoundName,
            );
        emit(CompoundDetailsState.loaded(compound: compound));
      } on Exception catch (e) {
        emit(
          CompoundDetailsState.error(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
