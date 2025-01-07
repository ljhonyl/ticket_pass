import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/misventos/usescases/get_mis_eventos_caso_de_uso.dart';
import 'package:ticket_pass/presentation/miseventos/bloc/mi_evento_state.dart';

import '../../../service_locator.dart';

class MiEventoCubit extends Cubit<MiEventoState> {
  MiEventoCubit() : super(MiEventoStateCargando());
  void mostrarCompras() async {
    var compra = await sl<GetMisEventosCasoDeUso>().call();

    compra.fold((error) {
      emit(MiEventoStateError());
    }, (data) {
      emit(MiEventostateCargado(eventos: data));
    });
  }
}
