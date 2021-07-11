import 'package:bloc/bloc.dart';
import 'package:first_app/modules/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 0;

  CounterCubit() : super(CounterInitialState());

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }
}
