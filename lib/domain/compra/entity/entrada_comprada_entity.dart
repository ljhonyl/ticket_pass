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
}

