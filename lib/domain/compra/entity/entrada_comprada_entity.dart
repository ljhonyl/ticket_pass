import 'package:cloud_firestore/cloud_firestore.dart';

class EntradaCompradaEntity {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  EntradaCompradaEntity({
    required this.numeroEntrada,
    required this.fechaCompra,
  });
}
