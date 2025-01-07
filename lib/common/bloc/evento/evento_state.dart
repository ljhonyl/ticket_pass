import 'package:ticket_pass/domain/evento/entity/evento_entity.dart';

abstract class EventoState{}

class EventoStateEstadoInicial extends EventoState{}

class EventoStateCargando extends EventoState{}

class EventoStateCargado extends EventoState{
  final List<EventoEntity> eventos;

  EventoStateCargado({required this.eventos});
}

class EventoStateError extends EventoState{}