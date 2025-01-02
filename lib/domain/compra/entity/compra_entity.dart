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

  factory CompraEntity.fromMap(Map<String, dynamic> map, List<EntradaCompradaEntity> entradas) {
    return CompraEntity(
      eventoId: map['eventoId'] as String,
      nombreEvento: map['nombreEvento'] as String,
      cantidad: map['cantidad'] as num,
      precioTotal: map['precioTotal'] as num,
      entradas: entradas,
    );
  }
}

extension CompraXModel on CompraEntity {
  CompraModel toModel() {
    return CompraModel(
      eventoId: eventoId,
      nombreEvento: nombreEvento,
      cantidad: cantidad,
      precioTotal: precioTotal,
      entradas: entradas.map((entrada) => entrada.toModel()).toList(), // Cambio aquí para que use 'toModel'
    );
  }
}

