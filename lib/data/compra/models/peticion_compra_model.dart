import 'package:cloud_firestore/cloud_firestore.dart';
import 'peticion_entrada_compra_model.dart';

class PeticionCompraModel {
  final String eventoId;
  final String nombreEvento;
  final num cantidad;
  final num precioTotal;
  final List<PeticionEntradaCompraModel> entradas;
  final Timestamp fechaEvento;
  final String imagen;

  PeticionCompraModel({
    required this.eventoId,
    required this.nombreEvento,
    required this.cantidad,
    required this.precioTotal,
    required this.entradas,
    required this.fechaEvento,
    required this.imagen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventoId': eventoId,
      'nombreEvento': nombreEvento,
      'cantidad': cantidad,
      'precioTotal': precioTotal,
    };
  }
}
