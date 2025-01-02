import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/venta/models/entrada_requerida_model.dart';

abstract class VentaRepository{
  Future<Either> getEntradasEnVenta(EntradaRequeridaModel entradas);
}