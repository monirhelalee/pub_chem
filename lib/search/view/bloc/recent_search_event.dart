import 'package:equatable/equatable.dart';

abstract class RecentSearchEvent extends Equatable {
  const RecentSearchEvent();

  @override
  List<Object> get props => [];
}

class LoadRecentSearchEvent extends RecentSearchEvent {
  const LoadRecentSearchEvent();
}
