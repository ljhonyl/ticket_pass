import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/domain/misentradas/entity/mi_entrada_entity.dart';

class MiEntradaModel {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  MiEntradaModel({
    required this.numeroEntrada,
    required this.fechaCompra,
  });

  factory MiEntradaModel.fromMap(Map<String, dynamic> map) {
    return MiEntradaModel(
      numeroEntrada: map['numeroEntrada'] as String,
      fechaCompra: map['fechaCompra'] as Timestamp,
    );
  }
}

extension MiEntradaXModel on MiEntradaModel {
  MiEntradaEntity toEntity() {
    return MiEntradaEntity(
      numeroEntrada: numeroEntrada,
      fechaCompra: fechaCompra,
    );
  }
}
