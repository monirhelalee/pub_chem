import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/splash/view/bloc/splash_event.dart';
import 'package:pub_chem/splash/view/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(SplashFinished());
  }
}
