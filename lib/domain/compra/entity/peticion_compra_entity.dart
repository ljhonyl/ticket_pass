import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/compra/models/peticion_compra_model.dart';
import 'peticion_entrada_compra_entity.dart';

class PeticionCompraEntity {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final List<PeticionEntradaCompraEntity> entradas;
  final Timestamp fechaEvento;
  final String imagen;

  PeticionCompraEntity({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.entradas,
    required this.fechaEvento,
    required this.imagen,
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
      fechaEvento: fechaEvento,
      imagen: imagen
    );
  }
}
