import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_test/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CubitInitState());

  ///create a singleton object from this class
  static CounterCubit get(context) => BlocProvider.of(context);

  int _counter = 1;

  ///getter for the counter
  int get counter => _counter;

  void decrement() {
    _counter--;
    //send the new state to the listener.
    emit(CubitMinusState());
  }

  void increment() {
    _counter++;
    //send the new state to the listener.
    emit(CubitPlusState());
  }
}
