import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_pass/domain/cuenta/usescases/get_cuenta_caso_de_uso.dart';
import 'package:ticket_pass/presentation/cuenta/bloc/cuenta_state.dart';

import '../../../service_locator.dart';

class CuentaCubit extends Cubit<CuentaState> {
  CuentaCubit() : super(CuentaStateCargando());

  void getCuenta() async{
    var cuenta = await sl<GetCuentaCasoDeUso>().call();

    cuenta.fold(
      (error){
        emit(CuentaStateError());
      },
      (data){
        emit(CuentaStateCargada(cuenta: data));
      }
    );
  }
}