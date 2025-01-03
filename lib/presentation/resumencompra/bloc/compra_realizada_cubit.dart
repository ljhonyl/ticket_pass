import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/compra/usescases/get_entradas_compradas_caso_de_uso.dart';
import 'package:ticket_pass/presentation/resumencompra/bloc/compra_realizada_state.dart';

import '../../../service_locator.dart';

class CompraRealizadaCubit extends Cubit<CompraRealizadaState> {
  CompraRealizadaCubit() : super(CompraRealizadaCargando());

  void mostrarCompra(String eventoId) async{
    var compra = await sl<GetEntradasCompradasCasoDeUso>().call(params: eventoId);

    compra.fold(
        (error){
          emit(CompraRealizadaError());
        },
        (data){
          emit(CompraRealizadaCargada(entradas: data));
        }
    );
  }
}