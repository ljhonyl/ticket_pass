import 'package:dartz/dartz.dart';
import 'package:ticket_pass/domain/cancelarcompra/entity/entrada_cancelada_entity.dart';
import 'package:ticket_pass/domain/cancelarcompra/repository/cancelar_compra_repository.dart';
import 'package:ticket_pass/domain/caso_de_uso.dart';

import '../../../service_locator.dart';

class CancelarCompraCasoDeUso
    implements CasoDeUso<Either, List<EntradaCanceladaEntity>> {
  @override
  Future<Either> call({List<EntradaCanceladaEntity>? params}) async {
    return await sl<CancelarCompraRepository>().cancelarCompra(params!);
  }
}
