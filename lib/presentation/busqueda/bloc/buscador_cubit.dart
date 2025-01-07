import 'package:flutter_bloc/flutter_bloc.dart';

class BuscadorCubit extends Cubit<String>{
  BuscadorCubit() : super ('');

  void actualizarTexto(String nuevoTexto){
    emit(nuevoTexto);
  }

}