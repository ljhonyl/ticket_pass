import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/data/misentradas/models/mi_entrada_model.dart';
import 'package:ticket_pass/domain/misentradas/entity/mi_compra_entity.dart';

class MiCompraModel {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final Timestamp fechaDeCompra;
  final List<MiEntradaModel> entradas;

  MiCompraModel({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.fechaDeCompra,
    required this.entradas,
  });

  factory MiCompraModel.fromMap(Map<String, dynamic> map, List<MiEntradaModel> entradas) {
    return MiCompraModel(
      eventoId: map['eventoId'] as String,
      nombreEvento: map['nombreEvento'] as String,
      cantidad: map['cantidad'] as num,
      precioTotal: map['precioTotal'] as num,
      fechaDeCompra: map['fechaDeCompra'] as Timestamp,
      entradas: entradas,
    );
  }
}

extension MiCompraXModel on MiCompraModel {
  MiCompraEntity toEntity() {
    return MiCompraEntity(
      eventoId: eventoId,
      nombreEvento: nombreEvento,
      cantidad: cantidad,
      precioTotal: precioTotal,
      fechaDeCompra: fechaDeCompra,
      entradas: entradas.map((entrada) => entrada.toEntity()).toList(),
    );
  }
}