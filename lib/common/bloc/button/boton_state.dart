abstract class BotonState{}

class BotonInicioState extends BotonState{}

class BotonCargandoState extends BotonState{}

class BotonHechoState extends BotonState{
  final dynamic params;

  BotonHechoState({this.params});
}

class BotonErrorState extends BotonState{
  final String  msgError;
  BotonErrorState({required this.msgError});
}