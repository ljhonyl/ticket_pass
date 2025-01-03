import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/compra/entity/peticion_entrada_compra_entity.dart';

class PeticionEntradaCompraModel {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  PeticionEntradaCompraModel({
    required this.numeroEntrada,
    required this.fechaCompra,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroEntrada': numeroEntrada,
      'fechaCompra': fechaCompra,
    };
  }
}

extension PeticionEntradaCompraXModel on PeticionEntradaCompraModel {
  PeticionEntradaCompraEntity toEntity() {
    return PeticionEntradaCompraEntity(
      numeroEntrada: numeroEntrada,
      fechaCompra: fechaCompra,
    );
  }
}

