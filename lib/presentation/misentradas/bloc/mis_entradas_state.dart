import 'package:ticket_pass/domain/misentradas/entity/mi_compra_entity.dart';

abstract class MisEntradasState{}

class MisEntradasStateCargando extends MisEntradasState{}

class MisEntradasStateCargadas extends MisEntradasState{
  final List<MiCompraEntity> compras;
  MisEntradasStateCargadas({required this.compras});
}

class MisEntradasStateError extends MisEntradasState{}