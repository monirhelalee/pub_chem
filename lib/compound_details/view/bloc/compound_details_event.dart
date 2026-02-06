abstract class CompoundDetailsEvent {
  const CompoundDetailsEvent();
}

class LoadCompoundDetailsEvent extends CompoundDetailsEvent {
  const LoadCompoundDetailsEvent({required this.compoundName});

  final String compoundName;
}
