import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/compra/entity/peticion_compra_entity.dart';

abstract class CompraRepository {
  Future<Either> comprar(PeticionCompraEntity compra);
  Future<Either> getEntradasCompradas(String eventoId);
}
