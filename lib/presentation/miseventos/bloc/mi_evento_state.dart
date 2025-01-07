import 'package:ticket_pass/domain/misventos/entity/mi_evento_entity.dart';

abstract class MiEventoState {}

class MiEventoStateCargando extends MiEventoState {}

class MiEventostateCargado extends MiEventoState {
  final List<MiEventoEntity> eventos;
  MiEventostateCargado({required this.eventos});
}

class MiEventoStateError extends MiEventoState {}
