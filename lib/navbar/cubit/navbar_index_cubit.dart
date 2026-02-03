import 'package:bloc/bloc.dart';

class NavbarIndexCubit extends Cubit<int> {
  NavbarIndexCubit() : super(0);
  void changeIndex(int index) => emit(index);
}
