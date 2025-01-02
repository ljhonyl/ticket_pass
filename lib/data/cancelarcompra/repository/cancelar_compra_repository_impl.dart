import 'package:dartz/dartz.dart';
import 'package:ticket_pass/data/cancelarcompra/service/cancelar_compra_firebase_service.dart';
import 'package:ticket_pass/domain/cancelarcompra/entity/entrada_cancelada_entity.dart';
import 'package:ticket_pass/domain/cancelarcompra/repository/cancelar_compra_repository.dart';

import '../../../service_locator.dart';

class CancelarCompraRepositoryImpl extends CancelarCompraRepository{
  @override
  Future<Either> cancelarCompra(List<EntradaCanceladaEntity> entradas) async{
    return await sl<CancelarCompraFirebaseService>().cancelarCompra(entradas.map((entrada) => entrada.toModel()).toList());
  }
}