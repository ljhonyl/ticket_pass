import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_pass/data/compra/models/entrada_comprada_model.dart';

import '../../../domain/compra/entity/peticion_entrada_compra_entity.dart';

class EntradaCompradaEntity {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  EntradaCompradaEntity({
    required this.numeroEntrada,
    required this.fechaCompra,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
      'fechaCompra': fechaCompra,
    };
  }

  factory EntradaCompradaEntity.fromMap(Map<String, dynamic> map) {
    return EntradaCompradaEntity(
      numeroEntrada: map['numeroEntrada'] as String,
      fechaCompra: map['fechaCompra'] as Timestamp,
    );
  }
}

extension EntradaCompradaXModel on EntradaCompradaEntity {
  EntradaCompradaModel toModel() {
    return EntradaCompradaModel(
      numeroEntrada: numeroEntrada,
      fechaCompra: fechaCompra,
    );
  }
}

