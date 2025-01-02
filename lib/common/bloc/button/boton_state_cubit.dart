import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/common/bloc/button/boton_state.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';

class BotonStateCubit extends Cubit<BotonState>{
  BotonStateCubit() : super(BotonInicioState());

  Future<void> finalizar({dynamic params, required CasoDeUso casoDeUso}) async{
    //Cuando se llama al metodo este pasa a cargando
    emit(BotonCargandoState());
    try{
      Either respuesta = await casoDeUso.call(params: params);
      print(respuesta);

      respuesta.fold(
          (error){
            emit(BotonErrorState(msgError: error));
          },
          (data){
            emit(BotonHechoState(params: data));
          }
      );
    }catch (e){
      emit(BotonErrorState(msgError: e.toString()));
    }
  }
}