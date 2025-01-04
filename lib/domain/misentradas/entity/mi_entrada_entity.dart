import 'package:cloud_firestore/cloud_firestore.dart';

class MiEntradaEntity {
  final String numeroEntrada;
  final Timestamp fechaCompra;

  MiEntradaEntity({
    required this.numeroEntrada,
    required this.fechaCompra,
  });
}
