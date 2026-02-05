abstract class CompoundDetailsEvent {
  const CompoundDetailsEvent();
}

class LoadCompoundDetails extends CompoundDetailsEvent {
  const LoadCompoundDetails({required this.compoundName});

  final String compoundName;
}
