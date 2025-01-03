import 'package:ticket_pass/domain/compra/entity/entrada_comprada_entity.dart';
import '../../../data/compra/models/compra_model.dart';
import '../../../domain/compra/entity/peticion_compra_entity.dart';

class CompraEntity {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final List<EntradaCompradaEntity> entradas;

  CompraEntity({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.entradas,
  });
}