import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/splash/view/bloc/splash_event.dart';
import 'package:pub_chem/splash/view/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>(_onStarted);
  }

  Future<void> _onStarted(
    SplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    if (event is SplashInitEvent) {
      print('hjsdhgfhjsf ${event.showSplash}');
    }
    emit(SplashLoading());
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(SplashFinished());
  }
}
