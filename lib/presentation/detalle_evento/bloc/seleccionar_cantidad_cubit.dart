import 'package:flutter_bloc/flutter_bloc.dart';

class SeleccionarCantidadCubit extends Cubit<int>{
  SeleccionarCantidadCubit() : super(1);

  void sumar(){
    emit(state +1);
  }

  void restar(){
    if(state != 1){
      emit(state -1);
    }
  }
}