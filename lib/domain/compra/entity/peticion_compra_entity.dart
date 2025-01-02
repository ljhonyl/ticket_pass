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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventoId': eventoId,
      'nombreEvento': nombreEvento,
      'cantidad': cantidad,
      'precioTotal': precioTotal,
    };
  }

  factory PeticionCompraEntity.fromMap(Map<String, dynamic> map, List<PeticionEntradaCompraEntity> entradas) {
    return PeticionCompraEntity(
      eventoId: map['eventoId'] as String,
      nombreEvento: map['nombreEvento'] as String,
      cantidad: map['cantidad'] as num,
      precioTotal: map['precioTotal'] as num,
      entradas: entradas,
    );
  }
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
