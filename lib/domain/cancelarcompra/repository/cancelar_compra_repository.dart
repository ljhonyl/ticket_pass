import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/cancelarcompra/entity/entrada_cancelada_entity.dart';

abstract class CancelarCompraRepository{
  Future<Either> cancelarCompra(List<EntradaCanceladaEntity> entradas);
}