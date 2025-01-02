import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/domain/compra/entity/entrada_comprada_entity.dart';

class EntradaCompradaModel {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  EntradaCompradaModel({
    required this.numeroEntrada,
    required this.fechaCompra,
  });

  factory EntradaCompradaModel.fromMap(Map<String, dynamic> map) {
    return EntradaCompradaModel(
      numeroEntrada: map['numeroEntrada'] as String,
      fechaCompra: map['fechaCompra'] as Timestamp,
    );
  }
}

extension EntradaCompradaXEntity on EntradaCompradaModel {
  EntradaCompradaEntity toEntity() {
    return EntradaCompradaEntity(
      numeroEntrada: numeroEntrada,
      fechaCompra: fechaCompra,
    );
  }
}