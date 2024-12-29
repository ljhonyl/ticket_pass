abstract class BotonState{}

class BotonInicioState extends BotonState{}

class BotonCargandoState extends BotonState{}

class BotonHechoState extends BotonState{}

class BotonErrorState extends BotonState{
  final String  msgError;
  BotonErrorState({required this.msgError});
}