abstract class BotonState{}

class BotonInicioState extends BotonState{}

class BotonStateCargando extends BotonState{}

class BotonStateHecho extends BotonState{
  final dynamic params;

  BotonStateHecho({this.params});
}

class BotonStateError extends BotonState{
  final String  msgError;
  BotonStateError({required this.msgError});
}
