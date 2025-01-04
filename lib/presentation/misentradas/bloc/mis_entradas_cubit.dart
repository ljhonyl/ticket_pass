import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/misentradas/usescases/get_mis_compras_caso_de_uso.dart';
import 'package:ticket_pass/domain/misventos/usescases/get_mis_eventos_caso_de_uso.dart';
import 'package:ticket_pass/presentation/misentradas/bloc/mis_entradas_state.dart';

import '../../../service_locator.dart';

class MisEntradasCubit extends Cubit<MisEntradasState> {
  MisEntradasCubit() : super(MisEntradasStateCargando());

  void mostrarCompras(String eventoId) async{
    var compra = await sl<GetMisComprasCasoDeUso>().call(params: eventoId);

    compra.fold(
      (error){
        emit(MisEntradasStateError());
      },
      (data){
        emit(MisEntradasStateCargadas(compras: data));
      }
    );
  }
}