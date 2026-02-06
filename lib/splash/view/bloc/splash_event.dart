import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitEvent extends SplashEvent {
  SplashInitEvent({required this.showSplash});
  final bool showSplash;
}

class SplashStartedEvent extends SplashEvent {}
