import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/compra/models/peticion_entrada_compra_model.dart';

class PeticionEntradaCompraEntity {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  PeticionEntradaCompraEntity({
    required this.numeroEntrada,
    required this.fechaCompra,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
      'fechaCompra': fechaCompra,
    };
  }

  factory PeticionEntradaCompraEntity.fromMap(Map<String, dynamic> map) {
    return PeticionEntradaCompraEntity(
      numeroEntrada: map['numeroEntrada'] as String,
      fechaCompra: map['fechaCompra'] as Timestamp,
    );
  }
}

extension PeticionEntradaCompraXEntity on PeticionEntradaCompraEntity {
  PeticionEntradaCompraModel toModel() {
    return PeticionEntradaCompraModel(
      numeroEntrada: numeroEntrada,
      fechaCompra: fechaCompra,
    );
  }
}


