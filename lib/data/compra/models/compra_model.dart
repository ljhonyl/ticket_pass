import 'package:ticket_pass/data/compra/models/entrada_comprada_model.dart';
import '../../../domain/compra/entity/compra_entity.dart';

class CompraModel {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final List<EntradaCompradaModel> entradas;

  CompraModel({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.entradas,
  });

  factory CompraModel.fromMap(Map<String, dynamic> map, List<EntradaCompradaModel> entradas) {
    return CompraModel(
      eventoId: map['eventoId'] as String,
      nombreEvento: map['nombreEvento'] as String,
      cantidad: map['cantidad'] as num,
      precioTotal: map['precioTotal'] as num,
      entradas: entradas,
    );
  }
}

extension CompraXEntity on CompraModel {
  CompraEntity toEntity() {
    return CompraEntity(
      eventoId: eventoId,
      nombreEvento: nombreEvento,
      cantidad: cantidad,
      precioTotal: precioTotal,
      entradas: entradas.map((entrada) => entrada.toEntity()).toList(),
    );
  }
}