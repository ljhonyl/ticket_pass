import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/compra/models/peticion_entrada_compra_model.dart';

class PeticionEntradaCompraEntity {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  PeticionEntradaCompraEntity({
    required this.numeroEntrada,
    required this.fechaCompra,
  });
}

extension PeticionEntradaCompraXEntity on PeticionEntradaCompraEntity {
  PeticionEntradaCompraModel toModel() {
    return PeticionEntradaCompraModel(
      numeroEntrada: numeroEntrada,
      fechaCompra: fechaCompra,
    );
  }
}


