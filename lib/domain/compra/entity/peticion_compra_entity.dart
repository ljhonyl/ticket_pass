import 'dart:convert';

import '../../../data/compra/models/peticion_compra_model.dart';
import 'peticion_entrada_compra_entity.dart';

class PeticionCompraEntity {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final List<PeticionEntradaCompraEntity> entradas;

  PeticionCompraEntity({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.entradas,
  });
}

extension PeticionCompraXEntity on PeticionCompraEntity {
  PeticionCompraModel toModel() {
    return PeticionCompraModel(
      eventoId: eventoId,
      nombreEvento: nombreEvento,
      cantidad: cantidad,
      precioTotal: precioTotal,
      entradas: entradas.map((entrada) => entrada.toModel()).toList(),
    );
  }
}
