import 'package:ticket_pass/domain/cuenta/entity/cuenta_entity.dart';

abstract class CuentaState{}

class CuentaStateCargando extends CuentaState{}

class CuentaStateCargada extends CuentaState{
  final CuentaEntity cuenta;

  CuentaStateCargada({required this.cuenta});
}

class CuentaStateError extends CuentaState{}