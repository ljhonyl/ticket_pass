import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';
import 'evento_state.dart';

class EventoCubit extends Cubit<EventoState>{
  final CasoDeUso casoDeUso;
  EventoCubit({required this.casoDeUso}) : super(EventoStateEstadoInicial());

  void mostrarEntradas({dynamic params}) async{
    emit(EventoStateCargando());

    var proximamente = await casoDeUso.call(
      params: params
    );

    proximamente.fold(
        (error){
          emit(EventoStateError());
        },
        (data){
          emit(EventoStateCargado(entradas: data));
        }
    );
  }

  void setEstadoInicial(){
    emit(EventoStateEstadoInicial());
  }
}