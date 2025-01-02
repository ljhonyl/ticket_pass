import 'package:ticket_pass/domain/compra/entity/compra_entity.dart';

abstract class CompraRealizadaState{}

class CompraRealizadaCargando extends CompraRealizadaState{}

class CompraRealizadaCargada extends CompraRealizadaState{
  final List<CompraEntity> entradas;
  CompraRealizadaCargada({required this.entradas});
}

class CompraRealizadaError extends CompraRealizadaState{}