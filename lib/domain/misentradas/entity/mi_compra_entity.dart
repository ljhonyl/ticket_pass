import 'package:cloud_firestore/cloud_firestore.dart';

import 'mi_entrada_entity.dart';

class MiCompraEntity {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final Timestamp fechaDeCompra;
  final List<MiEntradaEntity> entradas;

  MiCompraEntity({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.fechaDeCompra,
    required this.entradas,
  });
}